### CSCI 5253 Data Center and Scaling 
#### Lab3 Assignment - Data Joins in Hadoop
-----
The objective of the assignment is to do data join using multiple map-reduce operations given two text files

The approach for the assignment was to use **Hadoop Streaming API** to implement the hadoop application in python.

Four Map-Reduce operations were used to get the final count of same state citations. The approach towards creating are expressed in following details: 

MAP-REDUCE 1
#### Step1: Join two text files by "Citing" column as key
* **Input**: apat63_99.txt & cite75_99.txt
* Take **Citing** and corresponding **Citing State** from apat63_99.txt 
* Take **Citing** and **Cited** from cite75_99.txt.
* The output of Mapper are *Citing, Cited, --*  and *Citing, -- ,Citing State* sent to Reducer.
* In Reducer, it looks for new *Citing* value and corresponding *Citing State* and stores them in variables.
* In the next iteration, it compares the previous *Citing* with the current *Citing*. If there are same, it perfoms a join.
* The **output** from Reducer will be **Citing ,Cited,  CitingState**

MAP-REDUCE 2
#### Step2: Join a text file with previous Reducer output by "Cited" column as key
* **Input**: apat63_99.txt & Previous Reducer output - **Citing, Cited, CitingState**
* Take **Cited** and corresponding **Cited State** from apat63_99.txt 
* Take **Citing, Cited, CitingState**  from previous Reducer output.
* The output of Mapper are *Cited, Citing, CitingState, --*  and *Cited, --, --, Cited State* sent to Reducer.
* In Reducer, it looks for new *Cited* value and corresponding *Cited State* and stores them in variables.
* In the next iteration, it compares the previous *Cited* with the current *Cited*. If there are same, it perfoms a join.
* The **output** from Reducer will be **Cited, Citing, CitingState, CitedState**

MAP REDUCE 3
#### Step3: Count the number of same state citations by "Citing" column as key
* **Input**: **Citing, CitedState, Cited, CitingState** from previous Reducer
* Check if **CitedState** is equal to **CitingState**.
* IF yes:
	* The value will be "1" for corresponding "Citing" key
* Else:
	* The value will be "0" for corresponding "Citing" key
* The output of Mapper will be <*Citing,CitedState, Cited, CitingState* : "1" or "0">
* The reducer will count the number of 1's which has same state  by *Citation* key and gives the total number of same state citations.
* **Output**: **Citation**, **Count**

MAP REDUCE 4
#### Step4: Join same state count with the apat63_99.txt to add as new column
* **input**: **Citation,Count** from previous Reducer and apat63_99.txt
* Check if *Citation* from **Citation, Count** is equal to *Citation* in apat63_99.txt.
* If both values match, then join the count to the end of each line in the apat63_99.txt file.
* Thereby, we get the count of same state citations for each line else "0" if there are no same state citations. 


Makefile was written in such a way to run 4 Map-Reduces in one single job

