-- Chapter 13
-- Advanced Query Techniques

-- Anthony DeBarros. 9781718501072 (Kindle Location 6717). Kindle Edition. 

-- Listing 13-1: Using a subquery in a WHERE clause

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6747-6748). Kindle Edition. 

SELECT county_name,
	state_name,
	pop_est_2019
FROM us_counties_pop_est_2019
WHERE pop_est_2019 >= (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY pop_est_2019)
	FROM us_counties_pop_est_2019
)
ORDER BY pop_est_2019 DESC;

-- Listing 13-2: Using a subquery in a WHERE clause with DELETE

-- Anthony DeBarros. 9781718501072 (Kindle Location 6781). Kindle Edition. 

CREATE TABLE us_counties_2019_top10 AS

SELECT * FROM us_counties_pop_est_2019;

DELETE FROM us_counties_2019_top10
WHERE pop_est_2019 < (
	SELECT percentile_cont(.9) WITHIN GROUP (ORDER BY  pop_est_2019)
	FROM us_counties_2019_top10
);

select * from us_counties_2019_top10;

-- Listing 13-3: Subquery as a derived table in a FROM clause

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6801-6802). Kindle Edition. 

-- calc avg, calc median, subtract the two

SELECT round(calcs.average, 0) AS average,
	calcs.median,
	round(calcs.average - calcs.median, 0) AS median_average_diff
FROM (
	SELECT avg(pop_est_2019) AS average,
		percentile_cont(.5)
		WITHIN GROUP (ORDER BY pop_est_2019)::numeric AS median -- pop_est_2019 is an integer
	FROM us_counties_pop_est_2019
)

AS calcs;


select pop_est_2019
from us_counties_pop_est_2019;









