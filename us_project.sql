# US Househould Income Data Cleaning

SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;

-- Changing the column name id

ALTER TABLE us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`;

-- Identifying Duplicates in id column

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id, 
		id,
		ROW_NUMBER () OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income
		) AS duplicates
	WHERE row_num > 1);

-- Checking errors in state_name column

SELECT DISTINCT(state_name)
FROM us_household_income
GROUP BY state_name
ORDER by state_name;

UPDATE us_household_income
SET state_name = 'Georgia'
WHERE state_name = 'georia';

UPDATE us_household_income
SET state_name = 'Alabama'
WHERE state_name = 'alabama';

-- Checking the place column

SELECT *
FROM us_household_income
WHERE place = '';

SELECT *
FROM us_household_income
WHERE city = 'Vinemont'
ORDER BY 1;

UPDATE us_household_income
SET place = 'Autaugaville'
WHERE city = 'Vinemont' 
AND
county = 'Autauga County';

-- Checking type column

SELECT type, 
COUNT(type)
FROM us_household_income
GROUP BY type;

UPDATE us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs';

-- Checking AWater and ALand columns for Null or 0 values

SELECT ALand, AWater
FROM us_household_income
WHERE AWater IS NULL OR AWater = 0;

SELECT ALand, AWater
FROM us_household_income
WHERE ALand IS NULL OR ALand = 0;    
  
------------------------------------------------------------------------------------------------------------
# US Household Income Exploratory Analysis

-- What are the top 10 states with largest land area?

SELECT state_name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY state_name
ORDER BY 2 DESC
LIMIT 10;

-- What are the top 10 states with the largest water area?

SELECT state_name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY state_name
ORDER BY 3 DESC
LIMIT 10;

-- Joining the income and statistics tables

SELECT *
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0;

-- What are the 5 states with lowest average income (mean)?

SELECT income.state_name, 
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY income.state_name
ORDER BY 2
LIMIT 5;

-- What are the 5 states with highest average income (mean)?

SELECT income.state_name, 
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY income.state_name
ORDER BY 2 DESC
LIMIT 5;

-- What are the 5 states with lowest average income (median)?

SELECT income.state_name, 
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY income.state_name
ORDER BY 3
LIMIT 5;

-- What are the 5 states with highest average income (median)?

SELECT income.state_name, 
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY income.state_name
ORDER BY 3 DESC
LIMIT 5;

-- Average income (mean) based on type

SELECT type,  
COUNT(type),
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY type
HAVING COUNT(type) > 100
ORDER BY 3 DESC;

-- Average income (median) based on type

SELECT type,  
COUNT(type),
ROUND(AVG(mean), 1), 
ROUND(AVG(median), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY type
HAVING COUNT(type) > 100
ORDER BY 4 DESC;

-- What are the top 10 cities with highest average income (mean)?

SELECT income.state_name, city, ROUND(AVG(mean), 1)
FROM us_household_income AS income
JOIN us_household_income_statistics AS statistics
	ON income.id = statistics.id
WHERE mean <> 0
GROUP BY city, state_name
ORDER BY 3 DESC
LIMIT 10;
