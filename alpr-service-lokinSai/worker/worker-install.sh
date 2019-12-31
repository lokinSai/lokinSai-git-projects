#!/bin/sh
#
# This is the script you need to provide to install the rest-server.py and start it running.
# It will be provided to the instance using redis-launch.sh
#
##!/bin/sh
#
# The following script should install OpenALPR using apt-get
# in Ubuntu 19.10. There's an error in the configuration that needs
# to be addressed manually
#
# Install prerequisites
apt-get update
export DEBIAN_FRONTEND=noninteractive 
apt-get install -y openalpr
(cd /usr/share/openalpr/runtime_data/ocr/; cp tessdata/lus.traineddata .)

#
# Install other packages as needed
#
apt-get install -y python3 python3-pika python3-pillow python3-openalpr python3-redis
sudo apt-get update && sudo apt-get install -y openalpr openalpr-daemon openalpr-utils libopenalpr-dev
sudo pip3 install pika --upgrade
pip3 install jsonpickle