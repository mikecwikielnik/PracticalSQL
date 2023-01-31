-- Importing and Exporting Data

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 59). No Starch Press. Kindle Edition. 

-- Using COPY to Import Data

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 62). No Starch Press. Kindle Edition. 

-- COPY table_name
-- FROM 'C:/YourDirectory/your_file.csv' WITH (FORMAT CSV, HEADER);

-- Creating the us_counties_pop_est_2019 Table

-- Anthony DeBarros. 9781718501072 (Kindle Locations 2718-2719). Kindle Edition. 

CREATE TABLE us_counties_pop_est_2019 (
state_fips text,
	county_fips text,
region smallint,
state_name text,
	county_name text,
area_land bigint,
	area_water bigint,
internal_point_lat numeric(10,7),
	internal_point_lon numeric(10,7),
pop_est_2018 integer,
	pop_est_2019 integer,
	births_2019 integer,
	deaths_2019 integer,
	international_migr_2019 integer,
	domestic_migr_2019 integer,
	residula_2019 integer,
CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)
);


select * From us_counties_pop_est_2019;

-- Performing the Census Import with COPY

-- Anthony DeBarros. 9781718501072 (Kindle Locations 2798-2799). Kindle Edition. 

COPY us_counties_pop_est_2019
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_05\us_counties_pop_est_2019.csv'
;

SELECT * FROM us_counties_pop_est_2019;

-- Performing the Census Import with COPY

-- Anthony DeBarros. 9781718501072 (Kindle Locations 2798-2799). Kindle Edition. 


COPY us_counties_pop_est_2019
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_05\us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER);

-- Inspecting the import 

SELECT * FROM us_counties_pop_est_2019;

SELECT county_name, state_name, area_land
FROM us_counties_pop_est_2019
ORDER BY area_land ASC
LIMIT 3;

SELECT county_name, state_name, internal_point_lat, internal_point_lon
FROM us_counties_pop_est_2019
ORDER BY internal_point_lon DESC
LIMIT 5;

-- Importing a Subset of Columns with COPY

-- Anthony DeBarros. 9781718501072 (Kindle Location 2850). Kindle Edition. 

CREATE TABLE supervisor_salaries(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	town text,
	county text,
	supervisor text,
	state_date date,
	salary numeric(10,2),
	benefits numeric(10,2)
);

COPY supervisor_salaries (town, supervisor, salary)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_05\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

select * from supervisor_salaries LIMIT 2;

-- Importing a Subset of Rows with COPY

-- Anthony DeBarros. 9781718501072 (Kindle Locations 2888-2889). Kindle Edition. 

DELETE FROM supervisor_salaries;

COPY supervisor_salaries (town, supervisor, salary)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_05\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';
  
SELECT * FROM supervisor_salaries;

-- Adding a Value to a Column During Import

-- Anthony DeBarros. 9781718501072 (Kindle Location 2907). Kindle Edition. 





