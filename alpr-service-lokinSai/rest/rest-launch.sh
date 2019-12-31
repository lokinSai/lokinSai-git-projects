#!/bin/sh
#
# This is the script you need to provide to launch a rest instance
# and cause it to run the rest-install.sh script
#

gcloud compute instances create rest --image-family ubuntu-1804-lts --image-project ubuntu-os-cloud --zone us-central1-b --tags default-allow-internal --network-interfaces=no-address
gcloud compute scp rest-install.sh rest:~
gcloud compute scp rest-server.py rest:~
gcloud compute ssh loma6340@redis --command="sudo sh rest-install.sh"
