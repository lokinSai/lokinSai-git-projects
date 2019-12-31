USER=$(shell whoami)

##
## Configure the hadoop class path for the GCP dataproc environment
##

export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar

prepare:
	hdfs dfs -put apat63_99.txt input/apat63_99.txt
	hdfs dfs -put cite75_99.txt input/cite75_99.txt 

filesystem:
	-hdfs dfs -mkdir /user1
	-hdfs dfs -mkdir /user1/$(USER)

jobone:
	hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
	-mapper Mapper1.py \
	-reducer Reducer1.py \
	-file Mapper1.py -file Reducer1.py \
	-input input -output stream-output

copyone:
	hdfs dfs -cp input/apat63_99.txt stream-output

jobtwo:
	hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
	-mapper Mapper2.py \
	-reducer Reducer2.py \
	-file Mapper2.py -file Reducer2.py \
	-input stream-output -output stream-output1


jobthree:
	hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
	-mapper Mapper3.py \
	-reducer Reducer3.py \
	-file Mapper3.py -file Reducer3.py \
	-input stream-output1 -output stream-output2

copytwo:
	hdfs dfs -cp input/apat63_99.txt stream-output2

jobfour:
	hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
	-mapper Mapper4.py \
	-reducer Reducer4.py \
	-file Mapper4.py -file Reducer4.py \
	-input stream-output2 -output stream-output3

run: jobone copyone jobtwo jobthree copytwo jobfour
