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




































