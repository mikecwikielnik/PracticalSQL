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

-- Listing 17-6: Refreshing a materialized view

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9889-9890). Kindle Edition. 

REFRESH MATERIALIZED VIEW nevada_counties_pop_2019;

-- Listing 17-7: Creating a view on the employees table

-- Anthony DeBarros. 9781718501072 (Kindle Location 9928). Kindle Edition. 

CREATE OR REPLACE VIEW employees_tax_dept WITH (security_barrier) AS
SELECT emp_id,
	first_name,
	last_name,
	dept_id
FROM employees
WHERE dept_id = 1
WITH LOCAL CHECK OPTION;

-- Listing 17-8: Successful and rejected inserts via the employees_tax_dept view

-- Anthony DeBarros. 9781718501072 (Kindle Location 9958). Kindle Edition. 

INSERT INTO employees_tax_dept (emp_id, first_name, last_name, dept_id)
VALUES (5, 'Suzanne', 'Legere', 1);

INSERT INTO employees_tax_dept (emp_id, first_name, last_name, dept_id)
VALUES (6, 'Jamil', 'White', 2);

SELECT * FROM employees_tax_dept ORDER BY emp_id;

SELECT * FROM employees ORDER BY emp_id;

-- Listing 17-9: Updating a row via the employees_tax_dept view

-- Anthony DeBarros. 9781718501072 (Kindle Location 9992). Kindle Edition. 

UPDATE employees_tax_dept
SET last_name = 'Le Gere'
WHERE emp_id = 5;

SELECT * FROM employees_tax_dept ORDER BY emp_id;








































































