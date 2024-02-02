/*Clean the data to remove any trips less than 1 minute and any trips longer than 1 day
Anything that is less than 1 day is likely a test by the company and not done by a real rider.
Trips over 24 hours likely issues with bike not registering return correctly.  Below query finds results 
and removes them from the table there are 157,487 rows that meet this criteria*/


Delete from BikeData2023
where ride_id in 
	(Select 
	a.ride_id
	from BikeData2023 a
	Group by a.ride_id 
	having
	 SUM(cast(DATEDIFF(SECOND,a.start_time,a.end_time)as float)/60) <= 1 
	 or SUM(cast(DATEDIFF(SECOND,a.start_time,a.end_time)as float)/60) >= 1440)
 

 /*Docked and Classic Bikes are the same type and docked_bike stopped being used in the data after August 30, 2023. 
 Below is a query to update all records in the data set to change docked_bike to classic_bike.  There were 76,110 rows
 that were updated*/


Update BikeData2023
set rideable_type = 'classic_bike'
where rideable_type = 'docked_bike'


/*Each ride must have ending coordinates to map where trips originate and end.
Update coordinates for items that have station_id using coordinates from other data

25 rows with end_station_id 23001 have missing coordinates*/


Update BikeData2023
Set
end_lat = 41.884334564209
,end_long = -87.6589050292969
where end_station_id = '23001' and end_lat is null


/*14 rows with end station_id 23002 have missing coordinates*/


Update BikeData2023
Set
end_lat = 41.9500007629395
,end_long = -87.6800003051758
where end_station_id = '23002' and end_lat is null


/* 65 rows with end station_id 23003 have missing coordinates*/

Update BikeData2023
Set
end_lat = 41.884334564209
,end_long = -87.6589050292969
where end_station_id = '23003' and end_lat is null


/*8 rows with end stationid 653B have missing coordinates*/


Update BikeData2023
Set
end_lat = 41.7799987792969
,end_long = -87.5899963378906
where end_station_id = '653B' and (end_lat is null or end_long is null)

/*5 rows with end_station_id of 22005 with missing coordinates*/


Update BikeData2023
Set
end_lat = 41.7858619689941
,end_long = -87.6045532226563
where end_station_id = '22005' and (end_lat is null or end_long is null)


/*675 rows with missing end coordinates and missing end_station_id or end_station_name. 
Remove these rows*/


Delete from BikeData2023
where ride_id in(
		Select ride_id
			from BikeData2023
			Where 
			(end_lat is null or end_long is null or start_lat is null or start_long is null))
