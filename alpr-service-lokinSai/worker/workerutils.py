from PIL import Image
from PIL.ExifTags import TAGS, GPSTAGS
from openalpr import Alpr
from locale import setlocale
import locale
import hashlib
import redis
import pika

#
# Sample code from: https://gist.github.com/moshekaplan/5330395
#
def get_md5(binstring):
    result = hashlib.md5(binstring)
    return result.hexdigest()


def get_exif_data(image):
    """Returns a dictionary from the exif data of an PIL Image item. Also converts the GPS Tags"""
    exif_data = {}
    info = image._getexif()
    if info:
        for tag, value in info.items():
            decoded = TAGS.get(tag, tag)
            if decoded == "GPSInfo":
                gps_data = {}
                for gps_tag in value:
                    sub_decoded = GPSTAGS.get(gps_tag, gps_tag)
                    gps_data[sub_decoded] = value[gps_tag]

                exif_data[decoded] = gps_data
            else:
                exif_data[decoded] = value

    return exif_data


def _convert_to_degress(value):
    """Helper function to convert the GPS coordinates stored in the EXIF to degress in float format"""
    deg_num, deg_denom = value[0]
    d = float(deg_num) / float(deg_denom)

    min_num, min_denom = value[1]
    m = float(min_num) / float(min_denom)

    sec_num, sec_denom = value[2]
    s = float(sec_num) / float(sec_denom)

    return d + (m / 60.0) + (s / 3600.0)


def get_lat_lon(exif_data, debug=False):
    """Returns the latitude and longitude, if available,
    from the provided exif_data (obtained through get_exif_data above)"""
    lat = None
    lon = None

    if "GPSInfo" in exif_data:
        gps_info = exif_data["GPSInfo"]

        gps_latitude = gps_info.get("GPSLatitude")
        gps_latitude_ref = gps_info.get("GPSLatitudeRef")
        gps_longitude = gps_info.get("GPSLongitude")
        gps_longitude_ref = gps_info.get("GPSLongitudeRef")

        if gps_latitude and gps_latitude_ref and gps_longitude and gps_longitude_ref:
            lat = _convert_to_degress(gps_latitude)
            if gps_latitude_ref != "N":
                lat *= -1

            lon = _convert_to_degress(gps_longitude)
            if gps_longitude_ref != "E":
                lon *= -1
    else:
        if debug:
            print("No EXIF data")

    return lat, lon


def getLatLon(filename, debug=False):
    try:
        image = Image.open(filename)
        exif_data = get_exif_data(image)
        return get_lat_lon(exif_data, debug)
    except:
        return None


def get_latlong_image(img):
    exif_data = get_exif_data(img)
    return get_lat_lon(exif_data)


def get_number_plate(arr):
    setlocale(locale.LC_CTYPE, "C")
    alpr = Alpr("us", "/etc/openalpr/openalpr.conf", "/usr/share/openalpr/runtime_data")
    results = alpr.recognize_array(arr)
    if len(results["results"]) == 0:
        # print("Can't find a plate")
        return None, None
    else:
        return str(results["results"][0]["confidence"]), results["results"][0]["plate"]

