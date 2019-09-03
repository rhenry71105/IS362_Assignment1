
# IS 362 Week 1 - Part # 1
# Author: Rickardo Henry

# Q1: How many airplanes have listed speeds? What is the minimun & max lsited speed? 
SELECT * FROM planes;
SELECT COUNT(speed) AS 'Airplane_Listed_Speed',
 MIN(speed) AS 'Min_Speed',
 MAX(speed) AS 'Max_Speed'
 FROM planes;
 
# Q2: What is the total distance flown by all of the planes in Jan 2013?
# What is the total distance flown by all planes in Jan 2013 where tailnum is missing?
SELECT * FROM flights; 
SELECT SUM(distance) AS 'Total_Distance_2013'
FROM flights
WHERE year = 2013
AND month = 1;

SELECT SUM(distance) AS 'NULL_Distance'
FROM flights
WHERE year = 2013
AND month = 1
AND tailnum IS NULL;

#Q3: What is total distance flown for all planes on July 5, 2013 by aircraft manufacturer? Resuts are using INNER & LEFT OUTER JOINs
#The LEFT OUTER JOIN results include NULL values in the results. The INNER JOIN does not include NULL values in the results. 
SELECT * FROM planes;
SELECT SUM(distance) AS 'Total_Distance', planes.manufacturer
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE (flights.month = 7) AND (flights.day = 5) AND (flights.year = 2013)
GROUP BY planes.manufacturer;

SELECT * FROM planes;
SELECT SUM(distance) AS 'Total_Distance', planes.manufacturer
FROM flights 
LEFT OUTER JOIN planes 
ON flights.tailnum = planes.tailnum
WHERE (flights.month = 7) AND (flights.day = 5) AND (flights.year = 2013)
GROUP BY planes.manufacturer;

#Q4: What airport had the top 3 longest air_time in 2009 grouped by aircraft manufacturer in 2009? Answer: EWR
SELECT air_time AS 'Longest Air_time', flights.origin
FROM flights 
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE planes.year = 2009
ORDER BY  air_time desc limit 3;

# Part 2 - Tableau Comparison
# What airport had the highest departure delay in 2013 grouped by aircraft manufacturer. 
SELECT flights.origin AS 'Flights_Delayed',
flights.year, flights.dep_delay, flights.carrier, flights.tailnum, planes.manufacturer
INTO OUTFILE 'C:/Users/RickardoHenry/Desktop/MySQL/IS-362/Assignments/IS_362_Assignment_1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE planes.year = 2013
ORDER BY dep_delay DESC LIMIT 20;
