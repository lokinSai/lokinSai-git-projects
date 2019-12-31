#
# You probably want to borrow code from your Lab6 solution to send the image
#
from __future__ import print_function
import requests
import json
from sys import argv
from time import perf_counter
from numpy import mean
from PIL import Image
import os

hostname = argv[1]
filename = argv[2]
#operation = argv[2]
#rounds = int(argv[3])

addr = "http://"+hostname+":5000"
   
# prepare headers for http request
headers = {'content-type': 'image/jpg'}
img = open(filename,'rb').read()
# send http request with image and receive response
image_url = addr + "/api/image/"+filename
response = requests.put(image_url, data=img, headers=headers)
# decode response
print("Response is", response)
hash_response = json.loads(response.text)
print("hash value",hash_response["hash"])

checksum_url = addr + "/api/hash/" + str(hash_response["hash"])
response = requests.get(checksum_url)
geotag_numberplate_response = json.loads(response.text)
print("Numberplate and Geotag", geotag_numberplate_response["number plate"],
                                geotag_numberplate_response["latitude"],
                                geotag_numberplate_response["longitude"])

if geotag_numberplate_response["number plate"] != "None":
    license_url = addr + "/api/license/" + str(geotag_numberplate_response["number plate"])
    response = requests.get(license_url)
    checksum_response = json.loads(response.text)
    print("checksum", checksum_response["checksum"])
