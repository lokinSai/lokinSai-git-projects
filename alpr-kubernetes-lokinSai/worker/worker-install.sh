#!/bin/sh
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
apt-get install -y python3 python3-pip python3-pika python3-pillow python3-openalpr python3-redis python3-jsonpickle
apt-get install -y openalpr openalpr-daemon openalpr-utils libopenalpr-dev
#apt-get install python3-pip
pip3 install pika --upgrade
#pip3 install jsonpickle
python3 worker/workerutils.py worker
python3 worker/worker-server.py worker

