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







