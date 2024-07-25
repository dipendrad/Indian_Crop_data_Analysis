-- || INDIAN FARMER CROP DATA ANAYSIS || 

create database indianfarmer;

use indianfarmer;

-- Create Tables

CREATE TABLE farmers (
    farmer_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    state VARCHAR(50),
    district VARCHAR(50)
);

CREATE TABLE crops (
    crop_id VARCHAR(10) PRIMARY KEY,
    crop_name VARCHAR(50)
);

CREATE TABLE crop_data (
    data_id VARCHAR(10) PRIMARY KEY,
    farmer_id VARCHAR(10),
    crop_id VARCHAR(10),
    year YEAR,
    yield FLOAT,
    FOREIGN KEY (farmer_id) REFERENCES farmers(farmer_id),
    FOREIGN KEY (crop_id) REFERENCES crops(crop_id)
);

-- Insert Sample Data Farmers table
INSERT INTO farmers (farmer_id, name, state, district) VALUES
('f1', 'Ramesh', 'Maharashtra', 'Pune'),
('f2', 'Suresh', 'Punjab', 'Ludhiana'),
('f3', 'Anita', 'Bihar', 'Patna'),
('f4', 'Rajesh', 'Karnataka', 'Bangalore'),
('f5', 'Sunita', 'Gujarat', 'Ahmedabad');

-- Crops table

INSERT INTO crops (crop_id, crop_name) VALUES
('c1', 'Wheat'),
('c2', 'Rice'),
('c3', 'Sugarcane'),
('c4', 'Maize'),
('c5', 'Cotton');

-- Crop Data table

INSERT INTO crop_data (data_id, farmer_id, crop_id, year, yield) VALUES
('d1', 'f1', 'c1', 2020, 30.5),
('d2', 'f2', 'c2', 2020, 25.4),
('d3', 'f3', 'c3', 2020, 40.1),
('d4', 'f4', 'c4', 2020, 20.2),
('d5', 'f5', 'c5', 2020, 50.0),
('d6', 'f1', 'c2', 2021, 32.8),
('d7', 'f2', 'c3', 2021, 27.9),
('d8', 'f3', 'c4', 2021, 45.0),
('d9', 'f4', 'c5', 2021, 22.3),
('d10', 'f5', 'c1', 2021, 55.0),
('d11', 'f1', 'c3', 2020, 28.0),
('d12', 'f2', 'c4', 2020, 30.5),
('d13', 'f3', 'c5', 2020, 33.0),
('d14', 'f4', 'c1', 2020, 24.5),
('d15', 'f5', 'c2', 2020, 26.0);

-- SQL Analysis Queries

-- 1. List all farmers

SELECT * FROM farmers;

-- 2. List all crops

SELECT * FROM crops;

-- 3. List all crop data records

SELECT * FROM crop_data;

-- 4. Total yield of each crop

SELECT crops.crop_name, SUM(crop_data.yield) AS total_yield
FROM crop_data
JOIN crops ON crop_data.crop_id = crops.crop_id
GROUP BY crops.crop_name;

-- 5. Average yield per year for each crop

SELECT crops.crop_name, crop_data.year, AVG(crop_data.yield) AS average_yield
FROM crop_data
JOIN crops ON crop_data.crop_id = crops.crop_id
GROUP BY crops.crop_name, crop_data.year;

-- 6. Yield of each crop by state

SELECT farmers.state, crops.crop_name, SUM(crop_data.yield) AS total_yield
FROM crop_data
JOIN farmers ON crop_data.farmer_id = farmers.farmer_id
JOIN crops ON crop_data.crop_id = crops.crop_id
GROUP BY farmers.state, crops.crop_name;

-- 7. Highest yielding farmer for each crop

SELECT crops.crop_name, farmers.name AS farmer_name, MAX(crop_data.yield) AS max_yield
FROM crop_data
JOIN farmers ON crop_data.farmer_id = farmers.farmer_id
JOIN crops ON crop_data.crop_id = crops.crop_id
GROUP BY crops.crop_name, farmers.name
ORDER BY max_yield DESC;

-- 8. Yearly yield trends for a specific crop

SELECT crop_data.year, SUM(crop_data.yield) AS total_yield
FROM crop_data
JOIN crops ON crop_data.crop_id = crops.crop_id
WHERE crops.crop_name = 'Wheat'
GROUP BY crop_data.year
ORDER BY crop_data.year;

-- 9. Comparison of crop yield by district

SELECT farmers.district, crops.crop_name, SUM(crop_data.yield) AS total_yield
FROM crop_data
JOIN farmers ON crop_data.farmer_id = farmers.farmer_id
JOIN crops ON crop_data.crop_id = crops.crop_id
GROUP BY farmers.district, crops.crop_name;


-- 10. Farmers with yield above a certain threshold for a specific crop

SELECT farmers.name, crops.crop_name, crop_data.yield
FROM crop_data
JOIN farmers ON crop_data.farmer_id = farmers.farmer_id
JOIN crops ON crop_data.crop_id = crops.crop_id
WHERE crops.crop_name = 'Rice' AND crop_data.yield > 30;

-- 11. Total yield by state and year

SELECT farmers.state, crop_data.year, SUM(crop_data.yield) AS total_yield
FROM crop_data
JOIN farmers ON crop_data.farmer_id = farmers.farmer_id
GROUP BY farmers.state, crop_data.year;
