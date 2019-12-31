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
print(geotag_numberplate_response)
#print(geotag_numberplate_response.keys())
list_all = geotag_numberplate_response['values']
if list_all is not None: 
    #print(list_all)
    res_dict = {"number_plate":list_all[0],"latitude":list_all[2],"longitude":list_all[3]}
    print("Numberplate and Geotag", res_dict)
#res_dict = geotag_numberplate_response["values"]
#for k in res_dict.keys():
#    print(res_dict[k].decode('utf-8').split(","))
#print(geotag_numberplate_response["values"].decode('utf-8').split(","))

#print("Numberplate and Geotag", geotag_numberplate_response["number plate"],
#                                geotag_numberplate_response["latitude"],
#                                geotag_numberplate_response["longitude"])

if res_dict["number_plate"] != "None":
    license_url = addr + "/api/license/" + str(res_dict["number_plate"])
    response = requests.get(license_url)
    checksum_response = json.loads(response.text)
    print("checksum", checksum_response["checksum"])
