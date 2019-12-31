#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
# and cause it to run the redis-install.sh script
#
gcloud compute instances create redis --image-family ubuntu-1804-lts --image-project ubuntu-os-cloud --tags default-allow-internal --zone us-central1-b ----network-interface=no-address
gcloud compute scp redis-install.sh redis:~
gcloud compute ssh loma6340@redis --command="sudo sh redis-install.sh"
