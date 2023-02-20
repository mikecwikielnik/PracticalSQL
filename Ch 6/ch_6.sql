-- Basic Math and Stats with SQL

-- Anthony DeBarros. 9781718501072 (Kindle Location 3027). Kindle Edition. 

-- Listing 6-1: Basic addition, subtraction, and multiplication with SQL

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3083-3084). Kindle Edition. 


SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4.0;

SELECT 5 * 5 AS result;

-- Listing 6-2: Integer and decimal division with SQL

-- Anthony DeBarros. 9781718501072 (Kindle Location 3100). Kindle Edition. 

SELECT 11 / 6;
SELECT 11 % 6;
SELECT 11.0 / 6;
SELECT CAST(11 AS numeric(3,1)) / 6; --numeric(3,1) mean 3 significant digits, 1 digit after decimal point
							 		 --above shows 11.0
									 									 
-- Listing 6-3: Exponents, roots, and factorials with SQL

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3122-3123). Kindle Edition. 

SELECT 3 ^ 4;
SELECT |/ 10;
	SELECT sqrt(10);
SELECT ||/ 10;
SELECT factorial(4);
SELECT 4!;

-- Listing 6-4: Selecting census population estimate columns with aliases

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3165-3166). Kindle Edition. 

SELECT county_name AS county,
	state_name AS state,
	pop_est_2019 AS pop,
	births_2019 AS births,
	deaths_2019 AS deaths,
	international_migr_2019 AS int_migr,
	domestic_migr_2019 AS dom_migr,
	residual_2019 AS residual
FROM us_counties_pop_est_2019;
	
-- Listing 6-5: Subtracting two columns in us_counties_pop_est_2019

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3177-3178). Kindle Edition. 

SELECT county_name AS county,
	state_name AS state,
	births_2019 AS births,
	deaths_2019 AS deaths,
	births_2019 - deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
ORDER BY state_name, county_name;

-- Listing 6-6: Checking census data totals

-- Anthony DeBarros. 9781718501072 (Kindle Location 3203). Kindle Edition. 

SELECT county_name AS county,
	state_name AS state,
	pop_est_2019 AS pop,
	pop_est_2018 + births_2019 - deaths_2019 +
		international_migr_2019 + domestic_migr_2019 +
		residual_2019 AS components_total,
	pop_est_2019 - (pop_est_2018 + births_2019 - deaths_2019 +
				   international_migr_2019 + domestic_migr_2019 + 
				   residual_2019) AS difference
FROM us_counties_pop_est_2019
ORDER BY difference DESC;

-- Listing 6-7: Calculating the percent of a county’s area that is water

-- Anthony DeBarros. 9781718501072 (Kindle Location 3230). Kindle Edition. 

SELECT county_name AS county,
	state_name AS state,
	area_water::numeric/(area_land + area_water) * 100 AS pct_water
FROM us_counties_pop_est_2019
ORDER BY pct_water DESC;

-- Listing 6-8: Calculating percent change

-- Anthony DeBarros. 9781718501072 (Kindle Location 3268). Kindle Edition. 

CREATE TABLE percent_change(
	department text,
	spend_2019 numeric(10,2),
	spend_2022 numeric(10,2)
);

INSERT INTO percent_change
	VALUES
	('Assessor', 178556, 179500),
	('Building', 250000, 289000),
	('Clerk', 451980, 650000),
	('Library', 87777, 90001),
	('Parks', 250000, 223000),
	('Water', 199000, 195000);
	
SELECT department,
	spend_2019,
	spend_2022,
	round((spend_2022 - spend_2019) / spend_2019 * 100, 1) AS pct_change
FROM percent_change;

-- Listing 6-9: Using the sum() and avg() aggregate functions

-- Anthony DeBarros. 9781718501072 (Kindle Location 3295). Kindle Edition. 

SELECT sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019), 0) AS county_average
FROM us_counties_pop_est_2019;

-- Listing 6-10: Testing SQL percentile functions

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3347-3348). Kindle Edition. 

-- we make a test table with six numbers and find the percentiles

CREATE TABLE percentile_test(
	numbers integer
);

INSERT INTO percentile_test(numbers) VALUES
	(1), (2), (3), (4), (5), (6);
	
SELECT 
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY numbers),
	percentile_disc(.5)
	WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;

-- Listing 6-11: Using sum(), avg(), and percentile_cont() aggregate functions

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3363-3364). Kindle Edition. 

SELECT sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019), 0) AS county_average,
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY pop_est_2019) AS county_median
FROM us_counties_pop_est_2019;

-- Listing 6-12 shows how to calculate all four quartiles at once.

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3379-3380). Kindle Edition. 
	
SELECT percentile_cont(ARRAY[.25, .5, .75])
	WITHIN GROUP (ORDER BY pop_est_2019) AS quartiles
FROM us_counties_pop_est_2019;

-- Listing 6-13: Using unnest() to turn an array into rows (readability)

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3406-3407). Kindle Edition. 

SELECT unnest(
	percentile_cont(ARRAY[.25, .5, .75])
	WITHIN GROUP (ORDER BY pop_est_2019)
	) AS quartiles
FROM us_counties_pop_est_2019;

-- Listing 6-14: Finding the most frequent value with mode()

-- Anthony DeBarros. 9781718501072 (Kindle Location 3417). Kindle Edition. 













































