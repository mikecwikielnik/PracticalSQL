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
	residula_2019 AS residual
FROM us_counties_pop_est_2019;
	
-- Listing 6-5: Subtracting two columns in us_counties_pop_est_2019

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3177-3178). Kindle Edition. 



























