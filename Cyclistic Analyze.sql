--Aggregate the data
With BikeData2023cleaned as
(Select
ride_id
,rideable_type
,start_time
,end_time
,ROUND(start_lat,4) as start_latitude
,ROUND(start_long,4) as start_longitude
,ROUND(end_lat,4) as end_latitude
,ROUND(end_long,4) as end_longitude
,member_casual
,Format(start_time,'MMM') as start_month
,Format(start_time,'dddd') as day_of_week
,ROUND(cast(DATEDIFF(SECOND,start_time,end_time)as float)/60,2) as ride_length_minutes
FROM BikeData2023)
--Total number of rides by rider type and bike type.
,total_rides as
(Select 
	member_casual
	,rideable_type
	,count(*) as number_of_rides
	,SUM(ride_length_minutes) as total_ride_minutes
FROM BikeData2023cleaned
Group by member_casual
,rideable_type)
--Total number of rides by month by rider type
,rides_month as
(Select
	member_casual
	,start_month
	,count(*) as number_of_rides
FROM BikeData2023cleaned
Group by 
start_month
,member_casual)
--Average ride length by month by rider type
,average_ride_length as
(Select
	member_casual
	,start_month
	,AVG(ride_length_minutes) as average_ride_length_minutes
FROM BikeData2023cleaned
Group by
	start_month
	,member_casual
)
--Number of rides per weekday by rider type
,rides_weekday as
(Select
	member_casual
	,day_of_week
	,count(*) as number_of_rides
FROM BikeData2023cleaned
Group by
	member_casual
	,day_of_week)
--Average ride length per weekday by rider type
,rides_length_weekday as 
(Select
	member_casual
	,day_of_week
	,AVG(ride_length_minutes) as average_ride_length_minutes
FROM BikeData2023cleaned
Group by
	member_casual
	,day_of_week)
--Destination casual rider
,ride_destination_casual as
(select
member_casual 
,end_latitude
,end_longitude
,count(*) as number_of_rides
From BikeData2023cleaned
where member_casual = 'casual'
Group by 
	member_casual
	,end_latitude
	,end_longitude)
--Destination member rider
,ride_destination_member as
(select
member_casual 
,end_latitude
,end_longitude
,count(*) as number_of_rides
From BikeData2023cleaned
where member_casual = 'member'
Group by 
	member_casual
	,end_latitude
	,end_longitude)
--Top 10 destinations for casual and member riders
,top_ten_casual_destiations as
(Select Top 10
*
FROM ride_destination_casual
order by number_of_Rides DESC)
,top_ten_member_destinations as
(Select Top 10
*
from ride_destination_member
order by number_of_rides DESC)
