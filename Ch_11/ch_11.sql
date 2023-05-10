-- Chapter 11

-- Statistical Functions in SQL

-- Anthony DeBarros. 9781718501072 (Kindle Location 5688). Kindle Edition. 

-- Listing 11-1: Creating a 2014– 2018 ACS 5-Year Estimates table and importing data

-- Anthony DeBarros. 9781718501072 (Kindle Location 5712). Kindle Edition. 

CREATE TABLE acs_2014_2018_stats (
	geoid text CONSTRAINT geoid_key PRIMARY KEY,
	county text NOT NULL,
	st text NOT NULL, 
	pct_travel_60_min numeric(5, 2),
	pct_bachelors_higher numeric(5, 2),
	pct_masters_higher numeric(5, 2),
	median_hh_income integer,
	CHECK (pct_masters_higher <= pct_bachelors_higher)
);

COPY acs_2014_2018_stats
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_11\acs_2014_2018_stats.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM acs_2014_2018_stats;

-- Listing 11-2: Using corr( Y, X) to measure the relationship between education and income

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5789-5790). Kindle Edition. 

SELECT corr(median_hh_income, pct_bachelors_higher) as bachelors_income_r
FROM acs_2014_2018_stats;

-- Listing 11-3: Using corr( Y, X) on additional variables

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5812-5813). Kindle Edition. 

-- lets calculate the remaining variable pairs 

SELECT
	round(
		corr(median_hh_income, pct_bachelors_higher)::numeric, 2) as bachelors_income_r,
	round(
		corr(pct_travel_60_min, median_hh_income)::numeric, 2) as income_travel_r,
	round(
		corr(pct_travel_60_min, pct_bachelors_higher)::numeric, 2) as bachelors_travel_r
FROM acs_2014_2018_stats;

-- Listing 11-4: Regression slope and intercept functions

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5869-5870). Kindle Edition. 

-- linear regression in sql!

SELECT 
	round(
		regr_slope(median_hh_income, pct_bachelors_higher)::numeric, 2) as slope,
	round(
		regr_intercept(median_hh_income, pct_bachelors_higher)::numeric, 2) as y_intercept
FROM acs_2014_2018_stats;

-- Listing 11-5: Calculating the coefficient of determination, or r-squared

-- Anthony DeBarros. 9781718501072 (Kindle Location 5899). Kindle Edition. 

-- r-squared is the coefficient of determination! 

SELECT 
	round(
		regr_r2(median_hh_income, pct_bachelors_higher)::numeric, 3) as r_squared
FROM acs_2014_2018_stats;

-- Listing 11-6: Using the rank() and dense_rank() window functions

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5962-5963). Kindle Edition. 

CREATE TABLE widget_companies (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	company text NOT NULL,
	widget_output integer NOT NULL
);

INSERT INTO widget_companies (company, widget_output)
VALUES
	('Dom Widgets', 125000),
	('Ariadne Widget Masters', 143000),
	('Saito Widget Co.', 201000),
	('Mal Inc.', 133000),
	('Dream Widget Inc.', 196000),
	('Miles Amalgamated', 620000),
	('Arthur Industries', 244000),
	('Fischer Worldwide', 201000);
	
SELECT 
	company,
	widget_output,
	rank() OVER (ORDER BY widget_output DESC),
	dense_rank() OVER (ORDER BY widget_output DESC)
FROM widget_companies
ORDER BY widget_output DESC;

-- dense rank 123345
-- rank 	  123356





