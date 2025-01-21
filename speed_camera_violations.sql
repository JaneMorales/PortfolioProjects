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
WHERE TRIM(camera_id) = ''; # found empty camera_id rows
	
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
SET camera_id = 'CHI121'
WHERE TRIM(camera_id) = ''
	AND address = '3542 E 95TH ST';
    
UPDATE violations_copy
SET camera_id = 'CHI121'
WHERE TRIM(camera_id) = ''
	AND address = '2513 W 55TH';

UPDATE violations_copy
SET camera_id = 'CHI121'
WHERE TRIM(camera_id) = ''
	AND address = '1274 E 83RD ST';

-- Recheck to see if blanks are gone

SELECT camera_id, address
FROM violations_copy
WHERE TRIM(camera_id) = '';  -- good to go

# DATA ANALYSIS

-- How many camera_id's are listed for 2022?

SELECT COUNT(DISTINCT camera_id) AS total_num_of_camera_ids
FROM violations_copy
WHERE violation_date <= '2022-12-31';   

-- How many camera_id's are listed for 2023?

SELECT COUNT(DISTINCT camera_id) AS total_num_of_camera_ids
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31';  
    
-- How many times does each camera_id appear in 2022?

SELECT camera_id, COUNT(camera_id) AS total_times_camera_id_appears
FROM violations_copy
WHERE violation_date <= '2022-12-31'
GROUP BY camera_id
ORDER BY camera_id;

-- How many times does each camera_id appear in 2023?

SELECT camera_id, COUNT(camera_id) AS total_times_camera_id_appears
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31'
GROUP BY camera_id
ORDER BY camera_id;

-- What is the camera_id and address that has the highest number of appearances in 2022?

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date <= '2022-12-31'
GROUP BY camera_id
ORDER BY COUNT(camera_id) DESC
LIMIT 1;                                    

-- What is the camera_id and address that has the highest number of appearances in 2023?

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31'
GROUP BY camera_id
ORDER BY COUNT(camera_id) DESC
LIMIT 1;                                   

-- What is the camera_id and address that has the lowest number of appearances in 2022?

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date <= '2022-12-31'
GROUP BY camera_id
ORDER BY COUNT(camera_id)
LIMIT 1;                                      

-- What is the camera_id and address that has the lowest number of appearances in 2023?

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31'
GROUP BY camera_id
ORDER BY COUNT(camera_id)
LIMIT 1;                                        

-- Let's look at whether the camera_id CHI078 appeared more or less in 2023 than in 2022.

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date >= '2023-01-01'
	AND violation_date <= '2023-12-31'
    AND camera_id = 'CHI078'
ORDER BY COUNT(camera_id)
LIMIT 1;                                   

-- Let's look at whether the camera_id CHI100 appeared more or less in 2022 than in 2023.

SELECT camera_id, address, COUNT(camera_id) AS times_camera_id_appears
FROM violations_copy
WHERE violation_date <= '2022-12-31'
    AND camera_id = 'CHI100'
GROUP BY camera_id
ORDER BY COUNT(camera_id)
LIMIT 1;  

-- What is the total amount of violations in 2022?

SELECT SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date <= '2022-12-31';            

-- What is the total amount of violations in 2023?

SELECT SUM(violations) AS total_violations
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31';          

-- What are the top 10 dates with the most violations in 2022?    (this finds the row with the most violations)

SELECT camera_id, address, violation_date, MAX(violations) AS max_violations
FROM violations_copy
WHERE violation_date <= '2022-12-31'
GROUP BY camera_id
ORDER BY MAX(violations) DESC
LIMIT 10;                                   

-- What are the top 10 dates with the most violations in 2023?    (this finds the row with the most violations)

SELECT camera_id, address, violation_date, MAX(violations) AS max_violations
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31'
GROUP BY camera_id
ORDER BY MAX(violations) DESC
LIMIT 10;       

-- Let's sort violations from "low" to "very high" for 2022.

SELECT *,
CASE
	WHEN violations BETWEEN 1 AND 50 THEN 'low'
	WHEN violations BETWEEN 51 AND 200 THEN 'medium'
	WHEN violations BETWEEN 201 AND 500 THEN 'high'
	WHEN violations > 500 THEN 'very_high'
END AS violations_category
FROM violations_copy
WHERE violation_date <= '2022-12-31'
ORDER BY violations DESC;

-- How many violation_dates have "very high" violations for camera_id CHI079?

SELECT 
  camera_id,
  COUNT(camera_id) AS times_camera_id_appears_in_very_high_category
FROM
  (SELECT *,
     CASE
       WHEN violations BETWEEN 1 AND 50 THEN 'low'
       WHEN violations BETWEEN 51 AND 200 THEN 'medium'
       WHEN violations BETWEEN 201 AND 500 THEN 'high'
       WHEN violations > 500 THEN 'very_high'
     END AS violations_category
   FROM 
     violations_copy
   WHERE 
     violation_date <= '2022-12-31'
     AND camera_id = 'CHI079' 
  ) AS subquery
WHERE 
  violations_category = 'very_high'
GROUP BY 
  camera_id;
  
SELECT camera_id, address, COUNT(camera_id) AS total_times_camera_id_appears
FROM violations_copy
WHERE violation_date <= '2022-12-31'
	AND camera_id = 'CHI079';

-- Let's sort violations from "low" to "very high" for 2023.

SELECT *,
CASE
	WHEN violations BETWEEN 1 AND 50 THEN 'low'
	WHEN violations BETWEEN 51 AND 200 THEN 'medium'
	WHEN violations BETWEEN 201 AND 500 THEN 'high'
	WHEN violations > 500 THEN 'very_high'
END AS violations_category
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	AND violation_date <= '2023-12-31'
ORDER BY violations DESC;
  
  -- How many violation_dates have "high" violations for camera_id CHI189?

SELECT 
  camera_id,
  COUNT(camera_id) AS times_camera_id_appears_in_high_category
FROM
  (SELECT *,
     CASE
       WHEN violations BETWEEN 1 AND 50 THEN 'low'
       WHEN violations BETWEEN 51 AND 200 THEN 'medium'
       WHEN violations BETWEEN 201 AND 500 THEN 'high'
       WHEN violations > 500 THEN 'very_high'
     END AS violations_category
   FROM 
     violations_copy
   WHERE 
     violation_date >= '2023-01-01' 
	 AND violation_date <= '2023-12-31'
     AND camera_id = 'CHI189' 
  ) AS subquery
WHERE 
  violations_category = 'high'
GROUP BY 
  camera_id;
  
SELECT camera_id, address, COUNT(camera_id) AS total_times_camera_id_appears
FROM violations_copy
WHERE violation_date >= '2023-01-01' 
	 AND violation_date <= '2023-12-31'
	 AND camera_id = 'CHI189';
