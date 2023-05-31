-- Chapter 17 
-- Saving Time with Views, Functions, and Triggers

-- Anthony DeBarros. 9781718501072 (Kindle Location 9739). Kindle Edition. 

-- Listing 17-1: Creating a view that displays Nevada 2019 counties

-- Anthony DeBarros. 9781718501072 (Kindle Location 9784). Kindle Edition. 

CREATE OR REPLACE VIEW nevada_counties_pop_2019 AS
SELECT county_name,
	state_fips,
	county_fips,
	pop_est_2019
FROM us_counties_pop_est_2019
WHERE state_name = 'Nevada';

-- Listing 17-2: Querying the nevada_counties_pop_2010 view

-- Anthony DeBarros. 9781718501072 (Kindle Location 9811). Kindle Edition. 

SELECT *
FROM nevada_counties_pop_2019
ORDER BY county_fips
LIMIT 5;






































































































