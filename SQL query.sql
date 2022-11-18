--Creation of a new table to union all the month wise data--
CREATE TABLE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
( 
  ride_id string(100),
  rideable_type string(100),
  started_at timestamp,
  ended_at timestamp,
  start_station_name string(100),
  start_station_id string(100),
  end_station_name string(100),
  end_station_id string(100),
  start_lat float64,
  start_lng float64,
  end_lat float64,
  end_lng float64,
  member_casual string(10));


--Merger of past 12 month data into one table--
INSERT INTO `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Oct_2021_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Oct_2021_02`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Nov_2021`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Dec_2021`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Jan_2022`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Feb_2022`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Mar_2022`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Apr_2022`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.May_2022_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.May_2022_02`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Jun_2022_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Jun_2022_02`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Jul_2022_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Jul_2022_02`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Aug_2022_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Aug_2022_02`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Sep_2022_01`
)
UNION ALL
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.Sep_2022_02`
);

--Verification of total no of rows in merged table--
SELECT sum(no_of_rows) as total_rows from
(
SELECT count(*) as no_of_rows
FROM `my-project-1-364015.Bikeshare_Trip_data.Oct_2021_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Oct_2021_02` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Nov_2021` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Dec_2021` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Jan_2022` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Feb_2022` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Mar_2022` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Apr_2022` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.May_2022_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.May_2022_02` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Jun_2022_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Jun_2022_02` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Jul_2022_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Jul_2022_02` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Aug_2022_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Aug_2022_02` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Sep_2022_01` union all
SELECT count(*) 
FROM `my-project-1-364015.Bikeshare_Trip_data.Sep_2022_02`);

SELECT count(*) as total_rows
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`;

--calculation of ride_length in minutes--
ALTER TABLE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
ADD column ride_length_in_minutes INT64;

UPDATE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
SET ride_length_in_minutes = timestamp_diff(ended_at,started_at,minute)
WHERE TRUE;

--calculation of day_of_week--
ALTER TABLE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
ADD column day_of_week string;

UPDATE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
SET day_of_week = FORMAT_DATETIME('%A', started_at) 
WHERE TRUE;

--calculation of month--
ALTER TABLE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
ADD column month_of_ride string;

UPDATE `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
SET month_of_ride = FORMAT_DATETIME('%B', started_at) 
WHERE TRUE;


--data cleaning--

--verification of duplicate ride_id records--
SELECT
  (SELECT COUNT(DISTINCT(ride_id)) FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`) as distinct_rows,
  (SELECT COUNT(*) FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`) as total_rows;

--deletion of duplicate ride_id--
DELETE FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE ride_id 
in(SELECT ride_id FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY ride_id
HAVING COUNT(ride_id) >1);

--deletion of records where ride_length_in_minutes is negative--
DELETE FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE ride_length_in_minutes < 0;

--verification of null values in ride_id--
SELECT * 
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE ride_id is null;

--verification of null values in ride_length_in_minutes--
SELECT * 
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE ride_length_in_minutes is null;

--verification of null values in member_casual--
SELECT * 
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE member_casual is null;

--verification of null values in rideable_type--
SELECT * 
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE rideable_type is null;

--verification of column member_casual and string values(typo/misspelling)--
SELECT member_casual, COUNT(member_casual) as count, SUM(COUNT(member_casual)) OVER() as total_count
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY member_casual;

--verification of column rideable_type and string values(typo/misspelling)--
SELECT rideable_type, COUNT(rideable_type) as count, SUM(COUNT(rideable_type)) OVER() as total_count
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY rideable_type;

--creation of new table deleting null values in start and end station name--
CREATE TABLE `my-project-1-364015.Bikeshare_Trip_data.no_null_station_data` as
(
SELECT *
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
WHERE start_station_name is not null and end_station_name is not null);


--ANALYSIS--
--1.no of rides,avg, max and total ride_length by users--
SELECT 
  member_casual,
  count(ride_id) as no_of_rides,
  sum(ride_length_in_minutes) as total_ride_length,
  ROUND(AVG(ride_length_in_minutes)) as avg_ride_minutes,
  ROUND(MAX(ride_length_in_minutes)) as max_ride_minutes,
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY member_casual;

--2.ride lengths of member and casual riders --
SELECT
  member_casual,
  (case
  when ride_length_in_minutes < 5 then "less than 5 minutes"
  when ride_length_in_minutes between 5 and 10 then "5 to 10 minutes"
  when ride_length_in_minutes between 10 and 20 then "10 to 20 minutes"
  else "greater than 20 minutes"
  end) as  ride_length_in_minutes,
  count(ride_length_in_minutes) as no_of_occurance
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY ride_length_in_minutes, member_casual
order by no_of_occurance desc;

--3.Calculation of the average ride_length of the users by day_of_week--
SELECT member_casual,day_of_week,Avg(ride_length_in_minutes) as avg_ride_length,count(ride_length_in_minutes) as no_of_rides
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY day_of_week,member_casual
ORDER BY avg_ride_length desc;

--4.Calculation of the average ride_length of the users by weekday & weekend--
SELECT 
  member_casual,
  sum(ride_length_in_minutes) as total_ride_length,
  Avg(ride_length_in_minutes) as avg_ride_length,
  (case
  WHEN day_of_week = "Saturday" or day_of_week = "Sunday" THEN "WEEKEND"
  ELSE "WEEKDAY"
  END) as day_of_week,count(ride_id) as total_rides
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY day_of_week,member_casual
ORDER BY avg_ride_length desc;

--5.month wise distribution of rides by the users--
SELECT 
  member_casual,month_of_ride,count(month_of_ride) as max_no_rides,Avg(ride_length_in_minutes) as avg_ride_length,
  sum(ride_length_in_minutes) as total_ride_length
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY month_of_ride,member_casual
order by total_ride_length desc;

--6.usage of rideable_type by users--
SELECT 
  member_casual,rideable_type,count(ride_id) as total_rides,Avg(ride_length_in_minutes) as avg_ride_length,
  sum(ride_length_in_minutes) as total_ride_length
FROM `my-project-1-364015.Bikeshare_Trip_data.trip_data_21_22`
GROUP BY member_casual,rideable_type
ORDER BY total_rides desc;

--7.Most used start station by members--
SELECT 
  member_casual,
  start_station_name,
  count(start_station_name) as no_of_times_used,
  start_lat,
  start_lng
FROM `my-project-1-364015.Bikeshare_Trip_data.no_null_station_data`
WHERE member_casual = "member"
GROUP BY start_station_name,start_lat,start_lng,member_casual
ORDER BY no_of_times_used desc
LIMIT 100;

--8.Most used start station by casual riders--
SELECT 
  member_casual,
  start_station_name,
  count(start_station_name) as no_of_times_used,
  start_lat,
  start_lng
FROM `my-project-1-364015.Bikeshare_Trip_data.no_null_station_data`
WHERE member_casual = "casual"
GROUP BY start_station_name,start_lat,start_lng,member_casual
ORDER BY no_of_times_used desc
LIMIT 100;

--9.Most used path by members
SELECT member_casual,concat(start_station_name,' to ',end_station_name) as path,count(ride_id) as total_rides,
  start_station_name,
  round(start_lat,6) as start_lat,
  round(start_lng,6) as start_lng,
  end_station_name,
  round(end_lat,6) as end_lat,
  round(end_lng,6) as end_lng,  
  (case
    when start_station_name = end_station_name then 'round trip'
    else 'not a round trip'
    end
  ) as trip,safe_divide(count(ride_id),sum(count(ride_id)) over())*100 as percent_of_total_ride
FROM `my-project-1-364015.Bikeshare_Trip_data.no_null_station_data`
WHERE member_casual = "member"
GROUP BY member_casual, path,trip,start_station_name,start_lat,start_lng,end_station_name,end_lat,end_lng
ORDER BY total_rides desc
Limit 100;

--10.Most used path by casual riders--
SELECT member_casual,concat(start_station_name,' to ',end_station_name) as path,count(ride_id) as total_rides,
  start_station_name,
  round(start_lat,6) as start_lat,
  round(start_lng,6) as start_lng,
  end_station_name,
  round(end_lat,6) as end_lat,
  round(end_lng,6) as end_lng,  
  (case
    when start_station_name = end_station_name then 'round trip'
    else 'not a round trip'
    end
  ) as trip,safe_divide(count(ride_id),sum(count(ride_id)) over())*100 as percent_of_total_ride
FROM `my-project-1-364015.Bikeshare_Trip_data.no_null_station_data`
WHERE member_casual = "casual"
GROUP BY member_casual, path,trip,start_station_name,start_lat,start_lng,end_station_name,end_lat,end_lng
ORDER BY total_rides desc
LIMIT 100;