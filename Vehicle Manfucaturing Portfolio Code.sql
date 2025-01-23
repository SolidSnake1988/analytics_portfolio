## SQL Portfolio Project: Vehicle Data Analysis
/*
This portfolio project demonstrates my SQL skills through a comprehensive analysis of a dataset (`car_data.csv`).
The project covers various aspects of SQL, including data definition, data manipulation, data aggregation,
filtering, sorting, and more advanced techniques like window functions and correlated subqueries.
*/

-- 1. Data Definition:
/*
Table Creation: The `vehicle_info` table was created to store the car data, with appropriate data types
and a primary key constraint on `Car_ID`.  This ensures data integrity and efficient querying
*/

CREATE TABLE vehicle_info (
    Car_ID INT PRIMARY KEY,
    Brand VARCHAR(20),
    Model VARCHAR(20),
    Year INT,
    Color VARCHAR(20),
    Mileage INT,
    Price INT,
    Location VARCHAR(30)
);

/*
Data Import: The CSV file (car_data.csv) was imported into the vehicle_info table using the LOAD DATA INFILE command.
The command was configured correctly to handle delimiters, enclosures, and header rows.
*/

LOAD DATA INFILE 'C://ProgramData//MySQL//MySQL Server 9.0//Uploads//car_data.csv'
INTO TABLE vehicle_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- 2. Data Exploration and Aggregation:

/*
Basic Aggregation: Queries were written to calculate the average, minimum, and maximum prices of cars,
grouped by brand. This provides a general overview of price ranges for each car manufacturer.
The use of ROUND improves readability.
*/

SELECT 
    Brand,
    ROUND(AVG(Price), 2) AS 'Avg Price of Cars',
    MIN(Price) AS 'Minimum Price of Cars',
    MAX(Price) AS 'Maximum Price of Cars'
FROM
    vehicle_info
GROUP BY Brand;

-- Average Mileage and Price by Brand: This query provides insight into the relationship between mileage and price for each brand.

SELECT 
    Brand, ROUND(AVG(Price), 2) AS 'Avg Price'
FROM
    vehicle_info
GROUP BY Brand;

-- Top 5 Most Expensive Cars: This query returns the top 5 most expensive cars from the dataset.

SELECT
    Model, Price AS 'Highest Price'
FROM
    vehicle_info
ORDER BY Price DESC
LIMIT 5;

-- Average Price by Year: This query reveals price trends over time.

SELECT 
    Year, ROUND(AVG(Price), 2) as 'Price Trend Over Time'
FROM
    vehicle_info
GROUP BY Year
ORDER BY Year;

-- 3. Data Filtering and Sorting:
/*
Filtering by Mileage and Price: This demonstrates filtering data based on multiple criteria and sorting the results.
*/

SELECT 
    Model, Mileage, Price, Year
FROM
    vehicle_info
WHERE
    Mileage < 40000 AND Price > 15000
ORDER BY Year;

/*
Filtering by Location: This showcases filtering using the IN operator for multiple locations.
*/

SELECT 
    model, location
FROM
    vehicle_info
WHERE
    location IN ('Chicago' , 'Miami');

-- Filtering by Model (Starting Letter and Ending Letter): This example uses the LIKE operator for pattern matching.

SELECT 
    Model
FROM
    vehicle_info
WHERE
    Model LIKE 'C%';-- this query finds out where the car model starts with the letter c.

SELECT 
    model
FROM
    vehicle_info
WHERE
    model LIKE '%a';-- this query finds out where the car model ends with the letter a


-- 4. Data Modification (Backup and Update):

CREATE TABLE vehicle_info_backup AS SELECT * FROM
    vehicle_info;

-- Updating Price: This example updates a specific record based on the Car_ID.

UPDATE vehicle_info_backup 
SET 
    price = 20000
WHERE
    car_id = 10;

/*
Deleting Records: Demonstrates deleting records based on a condition (mileage). Note: The provided code attempts
to delete from vehicle_info_backup where Mileage > 100000. This is fine, but it's important to be clear that
no rows meet this condition in the sample data.
*/


DELETE FROM backup_vehicle_info 
WHERE
    Mileage > 100000;

/*
Intermediate to Advanced Queries
*/

-- Filter & Aggregate: Average Price of Cars by Brand and Location:
/*
Purpose: This query determines the average price of cars for each brand within each specific location.
It combines filtering (by brand and location) with aggregation (average price).
*/

SELECT 
    brand, location, ROUND(AVG(price), 2) AS 'Avg Price'
FROM
    vehicle_info
GROUP BY brand , location;

-- Nested Queries: Brand with the Most Expensive Car:
/*
Purpose: This query finds the brand that manufactures the most expensive car in the entire dataset.
It uses a nested query to first determine the maximum price and then retrieves the brand associated with that price.
*/

SELECT 
    brand
FROM
    vehicle_info
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            vehicle_info);

-- Subqueries: Cars Priced Above Average for Their Brand:
/*
Purpose: This query identifies cars that are priced higher than the average price for their respective brands.
It uses a correlated subquery, which means the subquery is executed repeatedly for each row in the outer query.
*/

SELECT 
    brand, model, price
FROM
    vehicle_info v
WHERE
    price > (SELECT 
            AVG(price)
        FROM
            vehicle_info
        WHERE
            brand = v.brand
        GROUP BY brand);


-- Window Functions: Rank Cars by Price within Brand and Location:
/*
Purpose: This query ranks cars based on their price within each combination of brand and location.
It showcases the use of window functions, specifically the RANK() function, to provide ranking without
grouping the results.
*/

select v.*,
rank() over (partition by brand, location order by price desc) as rnk
from
vehicle_info v;

-- Grouping: Number of Cars by Color and City:
/*
Purpose: This query calculates the number of cars available in each color within each city.
It's a simple example of grouping using two columns and applying the COUNT() aggregate function.
*/

SELECT 
    color,
    location,
    COUNT(*) AS 'total number of cars in each color and city'
FROM
    vehicle_info
GROUP BY color , location;

-- Date-Based Analysis: Age of Cars and Oldest Cars:
/*
Purpose: Calculates the age of each car using the current date and determines the oldest cars in the dataset.
This example uses date functions and demonstrates how to derive calculated columns.
*/

SELECT 
    model, year, (YEAR(CURDATE()) - year) AS 'Age Of Car'
FROM
    vehicle_info
ORDER BY `Age Of Car` DESC;

-- Case Statements: Car Price Categories:
/*
Purpose: This query classifies cars into different price categories ("Budget," "Mid-Range," or "Luxury")
based on their price. It shows the practical use of CASE statements for conditional logic.
*/

SELECT 
    model,
    price,
    CASE
        WHEN price BETWEEN 12000 AND 18000 THEN 'Budget'
        WHEN price BETWEEN 18001 AND 23000 THEN 'Mid-Range'
        ELSE 'Luxury'
    END AS 'Vehicle Category'
FROM
    vehicle_info;

-- CTEs: Common Table Expressions:
/*
Purpose: This query calculates the total mileage for each brand and then identifies the brands with a total mileage
greater than 1 million. It uses a Common Table Expression (CTE) to make the query more readable and organized.
*/


WITH BrandMileage AS (
    SELECT Brand, SUM(Mileage) AS 'Total Mileage'
    FROM vehicle_info
    GROUP BY Brand
)
SELECT Brand, `Total Mileage`
FROM BrandMileage
WHERE `Total Mileage` > 1000000;

-- Updating Data: Price Increase for Cars 2018 and Later (Conditional):
/*
Purpose: Demonstrates updating data based on multiple conditions (year and mileage).
Again, the backup table is used for update purposes.
*/

-- updating price
UPDATE backup_vehicle_info 
SET 
    price = price + (price * 0.10)
WHERE
    year = 2018 AND mileage < 40000; -- the updated table now has 10% increased prices based on the provided conditions

-- Dynamic Aggregation: City with Highest Average Car Price (Improved - using window function):
/*
Purpose: This query effectively uses a window function to find the highest average car price for each
brand and the city where that highest average occurs.
*/

WITH RankedPrices AS (
    SELECT Brand, Location, ROUND(AVG(Price), 2) AS AvgPrice,
           ROW_NUMBER() OVER (PARTITION BY Brand ORDER BY AVG(Price) DESC) AS rn
    FROM vehicle_info
    GROUP BY Brand, Location
)
SELECT Brand, Location, AvgPrice AS HighestAvgPrice
FROM RankedPrices
WHERE rn = 1;

-- Correlated Subqueries: Cars Priced Above Average for Color and Location:
/*
Purpose: Identifies cars priced above the average for cars of the same color in the same location. This uses
a correlated subquery that depends on values from the outer query.
*/

SELECT Model, Color, Price
FROM vehicle_info v
WHERE Price > (SELECT AVG(Price)
               FROM vehicle_info
               WHERE Color = v.Color AND Location = v.Location);  -- Correlated subquery