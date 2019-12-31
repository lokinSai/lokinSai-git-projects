#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
# and cause it to run the redis-install.sh script
#
kubectl create deployment worker --image=gcr.io/lab5-vm/worker:latest
kubectl expose deployment worker --port 5000 --target-port 5000