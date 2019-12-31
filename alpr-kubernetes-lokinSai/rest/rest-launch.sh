#!/bin/sh
#
# This is the script you need to provide to launch a redis instance
#
kubectl create deployment rest --image=gcr.io/lab5-vm/rest:latest
kubectl expose deployment rest --type=LoadBalancer --port 5000 --target-port 5000