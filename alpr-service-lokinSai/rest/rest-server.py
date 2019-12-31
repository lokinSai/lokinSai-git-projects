from flask import Flask, request, Response
import jsonpickle
import numpy as np
from PIL import Image
import io
import hashlib
import pika
import redis

app = Flask(__name__)
#connection = pika.BlockingConnection(pika.ConnectionParameters('rabbitmq'))
#channel = connection.channel()
credentials = pika.PlainCredentials('lokin', 'lokin')
parameters = pika.ConnectionParameters('rabbitmq',
                                       5672,
                                       '/',
                                       credentials)

connection = pika.BlockingConnection(parameters)
channel = connection.channel()

@app.route('/api/image/<filename>', methods=['PUT'])
def test(filename):
    print(filename)
    r = request
    
    md5hash_image = hashlib.md5(r.data).hexdigest()
    response = {"hash": md5hash_image}
    # encode response using jsonpickle
    message = {"hash":md5hash_image, "image_byte":r.data, "filename":filename}
    message_string = jsonpickle.encode(message)

    #connection = pika.BlockingConnection(pika.ConnectionParameters('rabbitmq'))
    #channel = connection.channel()
    channel.exchange_declare(exchange='toWorker1',exchange_type='direct')

    channel.basic_publish(exchange='toWorker1',
                      routing_key='toWorker1',
                      body=message_string)

    channel.exchange_declare(exchange="logs", exchange_type="topic")
    message = "Image's hash value and content sent to {0}".format("rabbitmq")
    channel.basic_publish(exchange="logs",
                          routing_key="{0}.rest.info".format("rabbitmq"),
                          body=message)

    print("[x] Sent 'md5hash_image and image_bytes")
    #connection.close()
    response_pickled = jsonpickle.encode(response)

    return Response(response=response_pickled, status=200, mimetype="application/json")

@app.route('/api/hash/<checksum>',methods=['GET'])
def test1(checksum):
    print(checksum)
    r = redis.Redis(host="redis",db=1)
    values = r.get(str(checksum))
    if values is None:
        print("The values don't exist")
        return ["0","0","0"]
    else:
        res = values.decode("utf-8").split(",")
        list_all = [elem for elem in res]
    response = {"number plate":list_all[0], "latitude":list_all[2], "longitude":list_all[3]}
    response_pickled = jsonpickle.encode(response)

    return Response(response=response_pickled, status=200, mimetype="application/json")

@app.route('/api/license/<numberplate>',methods=['GET'])
def test2(numberplate):
    print(numberplate)
    r = redis.Redis(host="redis",db=3)
    checksum_value = r.get(str(numberplate))
    if checksum_value is None:
        print("The values don't exist")
        return ["0"]
    else:
        res = checksum_value.decode("utf-8")
        res_list = [res]
    response = {"checksum":res_list[0]}
    response_pickled = jsonpickle.encode(response)

    return Response(response=response_pickled, status=200, mimetype="application/json")
app.run(host="0.0.0.0", port=5000)
