#!/bin/sh
#
# This is the script you need to provide to launch a rabbitmq instance
# and cause it to run the rabbitmq-install.sh script
#
gcloud compute instances create rabbitmq --image-family ubuntu-1804-lts --image-project ubuntu-os-cloud --tags default-allow-internal --zone us-central1-b --network-interface=no-address
gcloud compute scp rabbit-install.sh rabbitmq:~
gcloud compute ssh loma6340@rabbitmq --command="sudo sh rabbit-install.sh"
