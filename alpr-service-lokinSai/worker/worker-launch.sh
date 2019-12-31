#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
# and cause it to run the redis-install.sh script
#
gcloud compute instances create worker --image-family ubuntu-1804-lts --image-project ubuntu-os-cloud --zone us-central1-b --tags default-allow-internal --network-interfaces=no-address
gcloud compute scp worker-install.sh worker:~
gcloud compute scp worker-server.py worker:~
gcloud compute scp workerutils.py worker:~
gcloud compute ssh loma6340@worker --command="sudo sh worker-install.sh"
