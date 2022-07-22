
CASE STUDY-CYCLISTIC DATASET (January 2021-June 2021)

--------------------------------------------------------------------------------------------------


--STANDARDIZE DATA


SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202101]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202101]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202101]
SET ride_length_modified = CONVERT(Time, ride_length)
------------------------------------------------------

SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202101]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202102]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202102]
SET ride_length_modified = CONVERT(Time, ride_length)
------------------------------------------------------

SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202103]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202103]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202103]
SET ride_length_modified = CONVERT(Time, ride_length)
------------------------------------------------------

SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202104]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202104]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202104]
SET ride_length_modified = CONVERT(Time, ride_length)



SELECT TRY_CONVERT(float, start_station_id)
FROM [Case Study].[dbo].[divvy-tripdata-202104]

UPDATE [Case Study].[dbo].[divvy-tripdata-202104]
SET start_station_id = TRY_CONVERT(Float, start_station_id)

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202104]
ADD start_station_id_modified Float;

UPDATE [Case Study].[dbo].[divvy-tripdata-202104]
SET start_station_id_modified = CONVERT(Float, start_station_id)


ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202104] 
ALTER COLUMN end_station_id nvarchar(255)



ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202104]
DROP COLUMN start_station_id_modified
-------------------------------------------------------

SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202105]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202105]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202105]
SET ride_length_modified = CONVERT(Time, ride_length)


SELECT TRY_CONVERT(float, start_station_id)
FROM [Case Study].[dbo].[divvy-tripdata-202105]

UPDATE [Case Study].[dbo].[divvy-tripdata-202105]
SET start_station_id = TRY_CONVERT(Float, start_station_id)

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202105]
ADD start_station_id_modified Float;

UPDATE [Case Study].[dbo].[divvy-tripdata-202105]
SET start_station_id_modified = CONVERT(Float, start_station_id)


ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202105]
DROP COLUMN start_station_id_modified
------------------------------------------------------

SELECT ride_length_modified, CONVERT(Time,ride_length)
FROM [Case Study].[dbo].[divvy-tripdata-202106]

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202106]
ADD ride_length_modified Time;

UPDATE [Case Study].[dbo].[divvy-tripdata-202106]
SET ride_length_modified = CONVERT(Time, ride_length)


SELECT TRY_CONVERT(float, start_station_id)
FROM [Case Study].[dbo].[divvy-tripdata-202106]

UPDATE [Case Study].[dbo].[divvy-tripdata-202106]
SET start_station_id = TRY_CONVERT(Float, start_station_id)

ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202106]
ADD start_station_id_modified Float;

UPDATE [Case Study].[dbo].[divvy-tripdata-202106]
SET start_station_id_modified = CONVERT(Float, start_station_id)


ALTER TABLE [Case Study].[dbo].[divvy-tripdata-202106]
DROP COLUMN start_station_id_modified
--------------------------------------------------------------------------------------------------

--TABLES COMBINED

SELECT * 
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	UNION
SELECT *
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	UNION
SELECT *
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	UNION
SELECT *
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	UNION
SELECT *
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	UNION
SELECT *
FROM [Case Study].[dbo].[divvy-tripdata-202106]

---------------------------------------------------------------------------------------------------

--SUMMARY STATISTICS


--TOTAL NUMBER OF MEMBERS FOR EACH MONTH IN 2021


SELECT DISTINCT(month_year), COUNT(member_casual) AS Total_member
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual) 
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual) 
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'member'
	GROUP BY month_year, member_casual



--TOTAL NUMBER OF CASUAL RIDERS FOR EACH MONTH IN 2021


SELECT DISTINCT(month_year), COUNT(member_casual) AS Total_casual
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
		UNION
SELECT DISTINCT(month_year), COUNT(member_casual)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'casual'
	GROUP BY month_year, member_casual
----------------------------------------------------------------------------------------------------------------------



--AVERAGE RIDE LENGTH FOR MEMBERS FOR EACH MONTH IN 2021


SELECT DISTINCT(month_year), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
			AS Avg_member_ride_length
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'member'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'member'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'member'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'member'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'member'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'member'
	GROUP BY month_year



--AVERAGE RIDE LENGTH FOR CASUAL RIDERS FOR EACH MONTH IN 2021


SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
			AS Avg_casual_ride_length
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'casual'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'casual'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'casual'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'casual'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'casual'
	GROUP BY month_year
		UNION
SELECT DISTINCT(month_year), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'casual'
	GROUP BY month_year
--------------------------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR JANUARY 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_January
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_January
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202101]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
-----------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR FEBRUARY 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_February
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_February
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202102]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
---------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR MARCH 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_March
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_March
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202103]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
---------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR APRIL 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_April
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_April
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202104]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
---------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR MAY 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_May
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_May
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202105]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
---------------------------------------------------------------------------------------------------------



--TOTAL OF EACH BIKE USED AND AVERAGE TIME ON BIKE BY MEMBERS AND CASUAL RIDERS FOR JUNE 2021


SELECT DISTINCT(rideable_type), 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_member_June
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'member' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'member' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'member' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type


SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) AS Avg_time, 
	   COUNT(rideable_type) AS total_bike_casual_June
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'casual' 
	AND rideable_type = 'classic_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'casual' 
	AND rideable_type = 'electric_bike'
	GROUP BY rideable_type
		UNION
SELECT DISTINCT(rideable_type), 
       CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time), 
	   COUNT(rideable_type)
FROM [Case Study].[dbo].[divvy-tripdata-202106]
WHERE member_casual = 'casual' 
	AND rideable_type = 'docked_bike'
	GROUP BY rideable_type
---------------------------------------------------------------------------------------------------------



--MOST COMMON DAY TO RIDE BIKES AND AVERAGE TIME PER DAY FOR MEMBERS AND CASUAL RIDERS IN EACH MONTH OF 2021

----NOTE: 1 = SUNDAY, 2 = MONDAY, 3 = TUESDAY, 4 = WEDNESDAY, 5 = THURSDAY, 6 = FRIDAY, 7 = SATURDAY


--JANUARY 2021


SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202101]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC


--FEBRUARY 2021
	
	
SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202102]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC


--MARCH 2021


SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202103]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC


--APRIL 2021


SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202104]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC


--MAY 2021


SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
       day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202105]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC


--JUNE 2021


SELECT month_year, 
	   day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_members_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'member'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC

SELECT month_year, 
	   day_of_week, 
	   CAST(CAST(AVG(CAST(CAST(ride_length_modified AS Datetime) AS Float)) AS Datetime) AS Time) 
		AS Avg_time_per_day, 
	   COUNT(day_of_week) 
		AS Total_casual_per_day
FROM [Case Study].[dbo].[divvy-tripdata-202106]
	WHERE member_casual = 'casual'
	GROUP BY month_year, day_of_week
		ORDER BY COUNT(day_of_week) DESC
