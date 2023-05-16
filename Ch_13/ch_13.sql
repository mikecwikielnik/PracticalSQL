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

-- Listing 13-4: Joining two derived tables

-- Anthony DeBarros. 9781718501072 (Kindle Location 6828). Kindle Edition. 

SELECT census.state_name AS st,
	census.pop_est_2018,
	est.establishment_count,
	round((est.establishment_count/census.pop_est_2018::numeric) * 1000, 1)
	AS estabs_per_thousand
FROM (
	SELECT st,
		sum(establishments) AS establishment_count
	FROM cbp_naics_72_establishments
	GROUP BY st
	) AS est
JOIN (
	SELECT state_name, 
		sum(pop_est_2018) AS pop_est_2018
	FROM us_counties_pop_est_2019
	GROUP BY state_name
	) AS census
ON est.st = census.state_name
ORDER BY estabs_per_thousand DESC;

-- Listing 13-5: Adding a subquery to a column list

-- Anthony DeBarros. 9781718501072 (Kindle Location 6866). Kindle Edition. 

SELECT county_name,
	state_name AS st,
	pop_est_2019,
	(SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY pop_est_2019)
	FROM us_counties_pop_est_2019) AS us_median
FROM us_counties_pop_est_2019;

-- Listing 13-6: Using a subquery in a calculation

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6888-6889). Kindle Edition. 

SELECT county_name,
	state_name AS st,
	pop_est_2019,
	pop_est_2019 - (SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY pop_est_2019)
				   FROM us_counties_pop_est_2019) AS diff_from_median
FROM us_counties_pop_est_2019
WHERE (pop_est_2019 - (SELECT percentile_cont(.5) WITHIN GROUP (ORDER BY pop_est_2019)
					   FROM us_counties_pop_est_2019))
BETWEEN -1000 and 1000;

-- Listing 13-7: Creating and filling a retirees table

-- Anthony DeBarros. 9781718501072 (Kindle Location 6919). Kindle Edition. 

CREATE TABLE retirees (
	id int,
	first_name text,
	last_name text
);

INSERT INTO retirees
VALUES 
	(2, 'Janet', 'King'),
	(4, 'Michael', 'Taylor');
	

-- Listing 13-8: Generating values for the IN operator

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6929-6930). Kindle Edition. 

SELECT first_name, last_name
FROM employees
WHERE emp_id IN (
	SELECT id
	FROM retirees)
ORDER BY emp_id;

-- Listing 13-9: Using a correlated subquery with WHERE EXISTS

-- Anthony DeBarros. 9781718501072 (Kindle Location 6949). Kindle Edition. 

SELECT first_name, last_name
FROM employees
WHERE EXISTS (
	SELECT id
	FROM retirees
	WHERE id = employees.emp_id
);

-- Listing 13-10: Using a correlated subquery with WHERE NOT EXISTS

-- Anthony DeBarros. 9781718501072 (Kindle Location 6957). Kindle Edition. 

SELECT first_name, last_name
FROM employees
WHERE NOT EXISTS (
	SELECT id
	FROM retirees
	WHERE id = employees.emp_id);













