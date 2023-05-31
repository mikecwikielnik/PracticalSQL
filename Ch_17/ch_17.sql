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

-- Listing 17-3: Creating a view showing population change for US counties

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9835-9836). Kindle Edition. 

CREATE OR REPLACE VIEW county_pop_change_2019_2010 AS
SELECT c2019.county_name,
	c2019.state_name,
	c2019.state_fips,
	c2019.county_fips,
	c2019.pop_est_2019 AS pop_2019,
	c2010.estimates_base_2010 AS pop_2010,
	round((c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
		 / c2010.estimates_base_2010 * 100, 1) AS pct_change_2019_2010
FROM us_counties_pop_est_2019 AS c2019
JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
AND c2019.county_fips = c2010.county_fips;

-- Listing 17-4: Selecting columns from the county_pop_change_2019_2010 view

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9847-9848). Kindle Edition. 

SELECT county_name,
	state_name,
	pop_2019,
	pct_change_2019_2010
FROM county_pop_change_2019_2010
WHERE state_name = 'Nevada'
ORDER BY county_fips
LIMIT 5;

-- Listing 17-5: Creating a materialized view

-- Anthony DeBarros. 9781718501072 (Kindle Location 9879). Kindle Edition. 

DROP VIEW nevada_counties_pop_2019;

CREATE MATERIALIZED VIEW nevada_counties_pop_2019 AS
SELECT county_name,
	state_fips,
	county_fips,
	pop_est_2019
FROM us_counties_pop_est_2019
WHERE state_name = 'Nevada';


























































































