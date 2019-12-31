#!/bin/sh
#
# This is the script you need to provide to install the rest-server.py and start it running.
# It will be provided to the instance using redis-launch.sh
#
sudo apt-get update
sudo apt-get install -y python3 python3-pip git
pip3 install concurrency
pip3 install logging
pip3 install pillow
pip3 install numpy
pip3 install Flask
pip3 install jsonpickle
pip3 install requests
apt-get install python3-pip
pip3 install pika
pip3 install redis
python3 rest-server.py
