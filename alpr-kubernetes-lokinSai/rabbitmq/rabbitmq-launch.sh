#!/bin/sh
#
# This is the script you need to provide to launch a rabbitmq instance
# service
#
kubectl create deployment rabbitmq --image=rabbitmq
kubectl expose deployment rabbitmq --port 5672 --target-port 5672
