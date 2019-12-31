import pika
import io
from PIL import Image
import workerutils
import jsonpickle
import redis

def callback(ch, method, properties, body):
    print('in here')
    global cnl
    body_d = jsonpickle.decode(body)
    print(type(body_d["image_byte"]))
    print(body_d["hash"])
    print(body_d["filename"])
    print("New Message Received")
    ioBuffer = io.BytesIO(body_d["image_byte"])
    img = Image.open(ioBuffer)
    lat, long = workerutils.get_latlong_image(img)
    if not lat or not long:
        lat,long  = None,None
    print(lat,long)
    confidence, number_plate = workerutils.get_number_plate(body_d["image_byte"])
    if not confidence or not number_plate:
        confidence,number_plate= None,None
    print(confidence, number_plate)
    md5_hash = body_d["hash"]
    if lat is not None and long is not None:
        if confidence is not None and number_plate is not None:
            channel.basic_publish(exchange='logs',
                                routing_key='{0}.rest.info'.format("rabbitmq"),
                                body="geotag and numberplate sucessfully delivered")
        else:
            channel.basic_publish(exchange='logs',
                                  routing_key = '{0}.rest.debug'.format("rabbitmq"),
                                  body = "Geotag sucessfully delivered and numberplate not found")
    elif lat is None and long is None:
        if confidence is not None and number_plate is not None:
            channel.basic_publish(exchange='logs',
                                  routing_key = '{0}.rest.debug'.format("rabbitmq"),
                                  body="Numberplate sucessful delievered and Geotag not found")
        else:
            channel.basic_publish(exchange='logs',
                                  routing_key = '{0}.rest.debug'.format("rabbitmq"),
                                  body="Number plate and Geotag not found")
    
    #confidence, number_plate = workerutils.get_number_plate(body_d["image_byte"])
    #print(confidence, number_plate)
    #md5_hash = body_d["hash"]
    # Save in db1
    string_value = str(number_plate)+","+str(confidence)+","+str(lat)+","+str(long)
    r = redis.Redis(host="redis",port=6379, db=1)
    r.set(md5_hash, string_value)
    # Save in db2
    r = redis.Redis(host="redis",port=6379, db=2)
    r.set(body_d["filename"],md5_hash)
    # Save in db3
    r = redis.Redis(host="redis",port=6379, db=3)
    if number_plate is not None:
        r.set(number_plate, md5_hash)

def log_callback(ch, method, properties, body):
    print(" {0}, message - {1}".format(method.routing_key.split('.'), body.decode('utf-8')))


if __name__ == "__main__":

    #credentials = pika.PlainCredentials('lokin', 'lokin')
    #parameters = pika.ConnectionParameters('rabbitmq',
    #                               5672,
    #                               '/',
    #                               credentials)

    connection = pika.BlockingConnection(pika.ConnectionParameters('rabbitmq',5672))

    channel = connection.channel()
    print("channel created")
    channel.exchange_declare(exchange='toWorker1', exchange_type='direct')
    channel.exchange_declare(exchange='logs', exchange_type='topic')

    worker = channel.queue_declare('toWorker1')
    queue_for_worker = worker.method.queue

    logs = channel.queue_declare('logs')
    queue_for_logs = logs.method.queue
    channel.queue_bind(exchange='logs', queue=queue_for_logs, routing_key='#.rest.debug')
    channel.queue_bind(exchange='logs', queue=queue_for_logs, routing_key='#.rest.info')
    print(' [*] Waiting for logs. To exit press CTRL+C')
    channel.basic_consume(queue=queue_for_logs, on_message_callback=log_callback, auto_ack=True)

    channel.queue_bind(exchange='toWorker1', queue=queue_for_worker, routing_key='toWorker1')
    print("queue declared")
    channel.basic_consume(queue='toWorker1', on_message_callback=callback, auto_ack=True)
    print(" [*] Waiting for messages. To exit press CTRL+C")
    
    channel.start_consuming()

