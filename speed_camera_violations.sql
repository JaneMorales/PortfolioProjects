CREATE DATABASE IF NOT EXISTS speed_camera_violations;
USE speed_camera_violations;

CREATE TABLE speed_camera_violations.violations_copy (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    camera_id VARCHAR(10),
    address VARCHAR(255),
    violation_date DATE,  
    violations INT
);

LOAD DATA INFILE 'Speed_Camera_Violations_2022_2023.csv'
INTO TABLE speed_camera_violations.violations_copy
FIELDS TERMINATED BY ','  
IGNORE 1 LINES
(camera_id, address, violation_date, violations);
--------------------------------------------------------------------------------------------------------------------------------------------------
# DATA CLEAN UP

SELECT *
FROM violations_copy;

-- Find number of missing camera_id rows

SELECT DISTINCT camera_id, COUNT(camera_id) AS total_camera_id
FROM violations_copy
GROUP BY camera_id;  -- 4 blanks (camera_id)

-- Find which rows are missing camera_id

SELECT camera_id, address
FROM violations_copy
WHERE TRIM(camera_id) = ''; -- found empty camera_id rows
	
 -- Check for the distinct camera_id name attached to the address 
 
SELECT DISTINCT camera_id, address
FROM violations_copy
WHERE address = '1315 W GARFIELD BLVD'
OR address = '3542 E 95TH ST'
OR address = '2513 W 55TH'
OR address = '1274 E 83RD ST'
ORDER BY address;

-- Update address with the correct camera_id

UPDATE violations_copy
SET camera_id = 'CHI121'
WHERE TRIM(camera_id) = ''
	AND address = '1315 W GARFIELD BLVD';

UPDATE violations_copy
SET camera_id = 'CHI141'
WHERE TRIM(camera_id) = ''
	AND address = '3542 E 95TH ST';
    
UPDATE violations_copy
SET camera_id = 'CHI070'
WHERE TRIM(camera_id) = ''
	AND address = '2513 W 55TH';

UPDATE violations_copy
SET camera_id = 'CHI197'
WHERE TRIM(camera_id) = ''
	AND address = '1274 E 83RD ST';

-- Recheck to see if blanks are gone

SELECT camera_id, address
FROM violations_copy
WHERE TRIM(camera_id) = '';  -- good to go

------------------------------------------------------------------------------------------------------------------------------
# DATA ANALYSIS

-- What is the total amount of violations in 2022?

SELECT SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31';            -- 2,731,585

-- What is the total amount of violations in 2023?

SELECT SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31';          -- 2,288,983

-- How many camera_id's are listed for 2022?

SELECT COUNT(DISTINCT camera_id) AS total_num_of_camera_ids
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31';   -- 158

-- How many camera_id's are listed for 2023?

SELECT COUNT(DISTINCT camera_id) AS total_num_of_camera_ids
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31';  -- 169
    
-- What camera appears the most in 2022?

SELECT camera_id, address, COUNT(*) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY camera_id, address
ORDER BY times_camera_id_appears DESC
LIMIT 1;                                    -- CHI121 = 366

-- What camera appears the most in 2023?

SELECT camera_id, address, COUNT(*) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY camera_id, address
ORDER BY times_camera_id_appears DESC
LIMIT 1;                                   -- CHI141 = 366

-- What camera appears the least in 2022?

SELECT camera_id, address, COUNT(*) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY camera_id, address
ORDER BY times_camera_id_appears
LIMIT 1;                                   -- CHI078 = 29   

-- What camera appears the least in 2023?

SELECT camera_id, address, COUNT(*) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY camera_id, address
ORDER BY times_camera_id_appears
LIMIT 1;                                  -- CHI100 = 10

-- What are the top 10 dates with the most violations in 2022?     

SELECT 
    violation_date,
    SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY violation_date
ORDER BY total_violations DESC
LIMIT 10;
                             
-- What are the top 10 dates with the most violations in 2023?     

SELECT 
    violation_date,
    SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY violation_date
ORDER BY total_violations DESC
LIMIT 10;

-- Investigating months for total amount of violations in 2022 and 2023

WITH daily_totals AS (
    SELECT 
        violation_date,
        SUM(violations) AS total_violations
    FROM violations_copy
    GROUP BY violation_date
)

SELECT
    EXTRACT(MONTH FROM violation_date) AS month,
    SUM(CASE WHEN EXTRACT(YEAR FROM violation_date) = 2022 THEN total_violations END) AS total_2022,
    SUM(CASE WHEN EXTRACT(YEAR FROM violation_date) = 2023 THEN total_violations END) AS total_2023
FROM daily_totals
WHERE violation_date BETWEEN '2022-01-01' AND '2023-12-31'
GROUP BY month
ORDER BY month;

-- Let's sort violations from "low" to "very high" for 2022. What does the distribution of average violations per camera per day look like in 2022 when categorized into low, medium, high, and very high ranges?

SELECT 
    violation_date,
    COUNT(*) AS num_rows,
    ROUND(AVG(violations), 0) AS avg_violations,
    CASE
        WHEN ROUND(AVG(violations), 0) BETWEEN 0 AND 25 THEN 'low'
        WHEN ROUND(AVG(violations), 0) BETWEEN 26 AND 60 THEN 'medium'
        WHEN ROUND(AVG(violations), 0) BETWEEN 61 AND 100 THEN 'high'
        WHEN ROUND(AVG(violations), 0) > 100 THEN 'very_high'
    END AS violations_category
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY violation_date
ORDER BY violation_date;

-- Let's sort violations from "low" to "very high" for 2023. What does the distribution of average violations per camera per day look like in 2023 when categorized into low, medium, high, and very high ranges?

SELECT 
    violation_date,
    COUNT(*) AS num_rows,
    ROUND(AVG(violations), 0) AS avg_violations,
    CASE
        WHEN ROUND(AVG(violations), 0) BETWEEN 0 AND 25 THEN 'low'
        WHEN ROUND(AVG(violations), 0) BETWEEN 26 AND 60 THEN 'medium'
        WHEN ROUND(AVG(violations), 0) BETWEEN 61 AND 100 THEN 'high'
        WHEN ROUND(AVG(violations), 0) > 100 THEN 'very_high'
    END AS violations_category
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY violation_date
ORDER BY violation_date;

-- How many days in 2022 fall into the low, medium, high, and very high categories based on average violations per camera?

SELECT 
    violations_category,
    COUNT(*) AS num_days
FROM (
    SELECT 
        violation_date,
        ROUND(AVG(violations), 0) AS avg_violations,
        CASE
            WHEN ROUND(AVG(violations), 0) BETWEEN 0 AND 25 THEN 'low'
            WHEN ROUND(AVG(violations), 0) BETWEEN 26 AND 60 THEN 'medium'
            WHEN ROUND(AVG(violations), 0) BETWEEN 61 AND 100 THEN 'high'
            WHEN ROUND(AVG(violations), 0) > 100 THEN 'very_high'
        END AS violations_category
    FROM violations_copy
    WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY violation_date
) AS categorized_days
GROUP BY violations_category
ORDER BY num_days DESC;
 
-- How many days in 2023 fall into the low, medium, high, and very high categories based on average violations per camera? (noticed no very high in 2023; investigated)

SELECT 
    violations_category,
    COUNT(*) AS num_days
FROM (
    SELECT 
        violation_date,
        ROUND(AVG(violations), 0) AS avg_violations,
        CASE
            WHEN ROUND(AVG(violations), 0) BETWEEN 0 AND 25 THEN 'low'
            WHEN ROUND(AVG(violations), 0) BETWEEN 26 AND 60 THEN 'medium'
            WHEN ROUND(AVG(violations), 0) BETWEEN 61 AND 100 THEN 'high'
            WHEN ROUND(AVG(violations), 0) > 100 THEN 'very_high'
        END AS violations_category
    FROM violations_copy
    WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY violation_date
) AS categorized_days
GROUP BY violations_category
ORDER BY num_days DESC;

-- Investigate which cameras caused the spike in 2022.

SELECT 
    camera_id,
    ROUND(AVG(violations), 0) AS avg_per_camera_2022
FROM violations_copy
WHERE violation_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY camera_id
ORDER BY avg_per_camera_2022 DESC
LIMIT 10;

-- Checking 2023 to compare from previous question.

SELECT 
    camera_id,
    ROUND(AVG(violations), 0) AS avg_per_camera_2023
FROM violations_copy
WHERE violation_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY camera_id
ORDER BY avg_per_camera_2023 DESC
LIMIT 10;
