install.packages("dplyr")
library(dplyr)
install.packages("hflights")
library(hflights)
data(hflights)
head(hflights)
flights<-tbl_df(hflights) ##local data frame
flights
print(flights,n=20)
data.frame(head(flights)) ##to convert into normal dataframe
## dplyr approach is simpler to read and write 
##Command structure 
###...1 Fisrt argument is data frame 
###...2 return value is data frame 
###...3 nothing is modified in place 
## Dplyr does not prefer row names 

##based on R approach to view flights on Jan 1
flights[flights$DayofMonth==1 & flights$Month==1]

##dplyr approach
filter(flights,DayofMonth==1,Month==1)
## filter(localdataframe,condition,condition)
## we can use comma or apresand 

##use pipe for OR condition
filter(flights,UniqueCarrier== "AA" | UniqueCarrier== "UA")

##Using for %n% infix operator
filter(flights,UniqueCarrier %n% c("AA","UA"))

##.....Pick function to pick up columns by name....##
##Base R approach is difficult to type and read
##dplyr appracoh uses similar syntax
##Like SELECT in SQL 

flights[,c("DepTime","ArrTime","FlightNum")]

###dplr appraoch 
select(flights,DepTime,ArrTime,FlightNum)
##use colon to select continous columns, and use contains to match with column names
##note: 'starts_with','ends_with' and match column by name

select(flights,Year:DayOfWeek,contains("Time"),starts_with("Air"),ends_with("Num"))

##Chaining or pipeling
##usual way to perform multiple operations in one line is by nesting 
##can write commands in natural way by using %>% infix operator (called normally as then)
filter(select(flights,UniqueCarrier,DepDelay),DepDelay>60)
flights%>%select(UniqueCarrier,DepDelay)%>%filter(DepDelay>60)

##Create two vectors and calculate the distance between them
x1<-1:5 
x2<-2:6
##sqrt((sum(x1-x2)^2))
(x1-x2)^2%>%sum()%>%sqrt

##Arrange: Reorder rows
##base R approach to selct UniqueCarrier and DepDelay colmuns and sort by DepDelay
flights[order(flights$DepDelay),c("UniqueCarrier","DepDelay")]

##Dplyr approach 
flights%>%select(UniqueCarrier,DepDelay)%>%arrange(DepDelay)

#use desc for descending
flights%>%select(UniqueCarrier,DepDelay)%>%arrange(desc(DepDelay))

##mutate: add of new variables
##to create functions of new varaibles from existing variables

##based on R approach to add new columns  
flights$Speed<-flights$Distance/(flights$AirTime*60)
flights[,c("Distance","AirTime","Speed")]

##Dplyr approach 
flights%>%select(Distance,AirTime)%>%mutate(Speed=Distance/AirTime*60)
flights<-flights%>%mutate(Speed=Distance/AirTime*60)

##summarise is to reduce varaibles to values 
##primarly useful for data that has been grouped by one or more varaibles 
##group by creates groups that will be created on summarise uses the provided aggregation function to summarise each group

##dplyr approach to calculate average of Arrival Delay by Dest group
flights%>%group_by(Dest)%>%summarise(avg_delay=mean(ArrTime,na.rm=TRUE))

##summarise_each allows to apply summary function to multiple columns at once
##note: there is also mutate_each

flights%>%group_by(UniqueCarrier)%>%summarise_each(funs(mean),Cancelled,Diverted)
flights%>%group_by(UniqueCarrier)%>%summarise_each(funs(min(.,na.rm=TRUE),max(.,na.rm=TRUE)),ArrDelay,DepDelay)

##n() counts the number of rows in the group
## n_distinct(vector) counts the unique items in a vector

flights%>%group_by(Month,DayofMonth)%>%summarise(flight_count=n())%>%arrange(desc(flight_count))

##when there is summarise or n() function we need to replace with tally 
flights%>%group_by(Month,DayofMonth)%>%tally(sort=TRUE)

##for each destination, count the total number of flights and the number of distinct planes that flew there
flights%>%group_by(Dest)%>%summarise(flight_count=n(),plane_count=n_distinct(TailNum))

##for each destination , show the number of cancelled and not cancelled 
flights%>%group_by(Dest)%>%select(Cancelled)%>%table()%>%head()

##window functions takes n values and returns n values 
##Aggregation function takes n inputs and returns 1 value 
