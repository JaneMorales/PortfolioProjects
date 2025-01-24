#DATA CLEANING WORLD_LIFE_EXPECTANCY DATA

SELECT *
FROM world_life_expectancy;

-- Identifying Duplicates

SELECT country, year, 
	CONCAT(country, year),
    COUNT(CONCAT(country, year))
FROM world_life_expectancy
GROUP BY country, year, 
			CONCAT(country, year)
HAVING COUNT(CONCAT(country, year)) > 1;

-- Finding the row_id with duplicates and then removing them

SELECT *
FROM (
SELECT row_id, 
	CONCAT(country, year),
    ROW_NUMBER() OVER(PARTITION BY CONCAT(country, year)
ORDER BY CONCAT(country, year)) AS row_num
FROM world_life_expectancy
) AS row_table
WHERE row_num > 1;

DELETE FROM world_life_expectancy
WHERE
row_id IN (
SELECT row_id 
FROM (
SELECT row_id, 
	CONCAT(country, year),
    ROW_NUMBER() OVER(PARTITION BY CONCAT(country, year)
ORDER BY CONCAT(country, year)) AS row_num
FROM world_life_expectancy
) AS row_table
WHERE row_num > 1
);

-- Identifying blanks in status column

SELECT *
FROM world_life_expectancy
WHERE status = '';

SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> '';

-- Identifying the countries that are developing 
-- Adding developing to the status column if country is a developing

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing';

UPDATE world_life_expectancy            -- Receiving an error on this update statement
SET status = 'Developing'
WHERE country IN ( 
				SELECT DISTINCT(country)
				FROM world_life_expectancy
				WHERE status = 'Developing'
				);

UPDATE world_life_expectancy AS table1  -- Update statement worked; needed to join the table on itself 
JOIN world_life_expectancy AS table2
	ON table1.country = table2.country
SET table1.status = 'Developing'
WHERE table1.status = ''
AND table2.status <> ''
AND table2.status = 'Developing';

-- Identifying the countries that are developed 
-- Adding developed to the status column if country is a developed

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developed';

UPDATE world_life_expectancy AS table1  
JOIN world_life_expectancy AS table2
	ON table1.country = table2.country
SET table1.status = 'Developed'
WHERE table1.status = ''
AND table2.status <> ''
AND table2.status = 'Developed';

SELECT *                   -- Status column is good to go
FROM world_life_expectancy
WHERE status = '';

-- Identifying blanks for Life expectancy column

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = '';

-- Taking the AVG of Life expectancy before the blank row and after the blank row to populate Life expectancy for the blanks

SELECT country, year, `Life expectancy`
FROM world_life_expectancy;

SELECT table1.country, table1.year, table1.`Life expectancy`,
	table2.country, table2.year, table2.`Life expectancy`,
	table3.country, table3.year, table3.`Life expectancy`,
   ROUND((table2.`Life expectancy` + table3.`Life expectancy`) / 2, 1)
FROM world_life_expectancy AS table1
JOIN world_life_expectancy AS table2
	ON table1.country = table2.country
	AND table1.year = table2.year - 1
 JOIN world_life_expectancy AS table3
	ON table1.country = table3.country
	AND table1.year = table3.year + 1
    WHERE table1.`Life expectancy` = '';
    
UPDATE world_life_expectancy AS table1
JOIN world_life_expectancy AS table2
	ON table1.country = table2.country
	AND table1.year = table2.year - 1
 JOIN world_life_expectancy AS table3
	ON table1.country = table3.country
	AND table1.year = table3.year + 1
SET table1.`Life expectancy` =  ROUND((table2.`Life expectancy` + table3.`Life expectancy`) / 2, 1)
WHERE table1.`Life expectancy` = '';

SELECT *                         -- Life expectancy good to go
FROM world_life_expectancy
WHERE `Life expectancy` = '';


-----------------------------------------------------------------------------------------------------------------
#EXPLORATORY DATA ANALYSIS WORLD_LIFE_EXPECTANCY DATA

SELECT *                         
FROM world_life_expectancy;


-- Which countries had the most change in a span of 15 years for Life expectancy?

SELECT country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS life_increase_15_years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY life_increase_15_years DESC;

-- What is the average life expectancy for each year?

SELECT year, 
ROUND(AVG(`Life expectancy`), 2)                       
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY year
ORDER BY year;                  -- AVG life expectancy at 69

-- What is the correlation between GDP and life expectancy?

SELECT country, 
ROUND(AVG(`Life expectancy`), 1) AS life_exp,
ROUND(AVG(GDP), 1) AS GDP                  
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND GDP > 0
ORDER BY GDP;                              

SELECT 
SUM(CASE
	WHEN GDP >= 1500 THEN 1
	ELSE 0
END) high_GDP_count
FROM world_life_expectancy;               -- 1326 countries have high GDP 

SELECT 
SUM(CASE
	WHEN GDP <= 1500 THEN 1
	ELSE 0
END) low_GDP_count                    
FROM world_life_expectancy;               -- 1612 countries have low GDP 

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) high_GDP_count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) high_GDP_life_exp,   -- life expectancy with a high GDP for all 1326 countries is about 74
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) low_GDP_count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) low_GDP_life_exp     -- life expectancy with a low GDP for all 1612 countries is about 65
FROM world_life_expectancy;                

-- What is the average life expectancy of status (developed country or developing country)?

SELECT status, 
COUNT(DISTINCT country), 
ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY status;

-- What is the correlation between BMI and life expectancy for each country?

SELECT country, 
ROUND(AVG(`Life expectancy`), 1) AS life_exp,
ROUND(AVG(BMI), 1) AS BMI                  
FROM world_life_expectancy
GROUP BY country
HAVING life_exp > 0
AND BMI > 0
ORDER BY BMI DESC;                         -- higher life expenctancy has a higher BMI on average and lower life expectancy has a lower BMI on average

-- What is the adult mortality each year for every country?

SELECT country, 
year, 
`Life expectancy`, 
`Adult Mortality`,
SUM(`Adult Mortality`) OVER (PARTITION BY country ORDER BY year) AS rolling_total
FROM world_life_expectancy;

