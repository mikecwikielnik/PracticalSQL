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

-- Listing 17-10: Deleting a row via the employees_tax_dept view

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10009-10010). Kindle Edition. 

DELETE FROM employees_tax_dept
WHERE emp_id = 5;

-- Listing 17-11: Creating a percent_change() function A lot is happening in this code, but it’s not as

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10042-10043). Kindle Edition. 

CREATE OR REPLACE FUNCTION
percent_change(new_value numeric,
			   old_value numeric,
			   decimal_places integer DEFAULT 1)
RETURNS numeric AS
'SELECT round(
	((new_value - old_value) / old_value) * 100, decimal_places);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

-- Listing 17-12: Testing the percent_change() function

-- Anthony DeBarros. 9781718501072 (Kindle Location 10067). Kindle Edition. 

SELECT percent_change(110, 108, 2);

-- Listing 17-13: Testing percent_change() on census data

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10085-10086). Kindle Edition. 

SELECT c2019.county_name,
	c2019.state_name,
	c2019.pop_est_2019 AS pop_2019,
	percent_change(c2019.pop_est_2019,
				   c2010.estimates_base_2010) AS pct_chg_func,
	round((c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
		  / c2010.estimates_base_2010 * 100, 1) AS pct_change_formula
FROM us_counties_pop_est_2019 AS c2019
JOIN us_counties_pop_est_2010 As c2010
ON c2019.state_fips = c2010.state_fips
AND c2019.county_fips = c2010.county_fips
ORDER BY pct_chg_func DESC
LIMIT 5;

-- Listing 17-14: Adding a column to the teachers table and seeing the data

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10119-10120). Kindle Edition. 

ALTER TABLE teachers ADD COLUMN personal_days integer;

SELECT first_name,
	last_name,
	hire_date,
	personal_days
FROM teachers;

-- Listing 17-15: Creating an update_personal_days() function

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10148-10149). Kindle Edition. 

CREATE OR REPLACE PROCEDURE update_personal_days()
AS $$
BEGIN
	UPDATE teachers
	SET personal_days = 
		CASE 
			WHEN (now() - hire_date) >= '10 years'::interval
				AND (now() - hire_date) < '15 years'::interval THEN 4
			WHEN (now() - hire_date) >= '15 years'::interval
				AND (now() - hire_date) < '20 years'::interval THEN 5
			WHEN (now() - hire_date) >= '20 years'::interval 
				AND (now() - hire_date) < '25 years'::interval THEN 6
			WHEN (now() - hire_date) >= '25 years'::interval THEN 7
			ELSE 3
		END;
	RAISE NOTICE 'personal_days updated!';
END;	
$$
LANGUAGE plpgsql;

CALL update_personal_days();

-- Listing 17-16: Enabling the PL/ Python procedural language

-- Anthony DeBarros. 9781718501072 (Kindle Location 10192). Kindle Edition. 

CREATE EXTENSION plpython3u;

-- Listing 17-17: Using PL/ Python to create the trim_county() function

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10204-10205). Kindle Edition. 

CREATE OR REPLACE FUNCTION trim_county(input_string text)
RETURNS text AS $$ 
		import re2
		cleaned = re.sub(r' County', '', input_string)
		return cleaned
	$$
LANGUAGE plpython3u;	

-- Listing 17-18: Testing the trim_county() function

-- Anthony DeBarros. 9781718501072 (Kindle Location 10218). Kindle Edition. 

SELECT county_name,
	trim_county(county_name)
FROM us_counties_pop_est_2019
ORDER BY state_fips, county_fips
LIMIT 5;

-- Listing 17-19: Creating the grades and grades_history tables

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10252-10253). Kindle Edition. 

CREATE TABLE grades (
	student_id bigint,
	course_id bigint,
	course text NOT NULL,
	grade text NOT NULL,
	PRIMARY KEY (student_id, course_id)
);

INSERT INTO grades
VALUES 
	(1, 1, 'Biology 2', 'F'),
	(1, 2, 'English 11B', 'D'),
	(1, 3, 'World History 11B', 'C'),
	(1, 4, 'Trig 2', 'B');
	
CREATE TABLE grades_history (
	student_id bigint NOT NULL,
	course_id bigint NOT NULL,
	change_time timestamp with time zone NOT NULL,
	course text NOT NULL,
	old_grade text NOT NULL,
	new_grade text NOT NULL,
	PRIMARY KEY (student_id, course_id, change_time)
);

-- Listing 17-20: Creating the record_if_grade_changed() function

-- Anthony DeBarros. 9781718501072 (Kindle Location 10272). Kindle Edition. 

CREATE OR REPLACE FUNCTION record_if_grade_changed()
RETURNS trigger AS
$$
BEGIN 
	IF NEW.grade <> OLD.grade THEN
	INSERT INTO grades_history(
		student_id,
		course_id,
		change_time,
		course,
		old_grade,
		new_grade)
	VALUES
		(OLD.student_id,
		OLD.course_id,
		now(),
		OLD.course,
		OLD.grade,
		NEW.grade);
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Listing 17-21: Creating the grades_update trigger

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10298-10299). Kindle Edition. 

CREATE TRIGGER grades_update
	AFTER UPDATE
	ON grades
	FOR EACH ROW
	EXECUTE PROCEDURE record_if_grade_changed();

-- Listing 17-22: Testing the grades_update trigger

-- Anthony DeBarros. 9781718501072 (Kindle Location 10326). Kindle Edition. 

UPDATE grades
SET grade = 'C'
WHERE student_id = 1 AND course_id = 1;

-- Listing 17-23: Creating a temperature_test table

-- Anthony DeBarros. 9781718501072 (Kindle Location 10355). Kindle Edition. 

CREATE TABLE temperature_test (
	station_name text,
	observation_date date,
	max_temp integer,
	min_temp integer,
	max_temp_group text,
	PRIMARY KEY (station_name, observation_date)
);

-- Listing 17-24: Creating the classify_max_temp() function

-- Anthony DeBarros. 9781718501072 (Kindle Locations 10371-10372). Kindle Edition.  

CREATE OR REPLACE FUNCTION classify_max_temp()
	RETURNS trigger as
$$
BEGIN
	CASE
	WHEN NEW.max_temp >= 90 THEN
		NEW.max_temp_group := 'Hot';
	WHEN NEW.max_temp >= 70 AND NEW.max_temp < 90 THEN
		NEW.max_temp_group := 'Warm';
	WHEN NEW.max_temp >= 50 AND NEW.max_temp < 70 THEN
		NEW.max_temp_group := 'Pleasant';
	WHEN NEW.max_temp >= 33 AND NEW.max_temp < 50 THEN
		NEW.max_temp_group := 'Cold';
	WHEN NEW.max_temp >= 20 AND NEW.max_temp < 33 THEN
		NEW.max_temp_group := 'Frigid';
	WHEN NEW.max_temp < 20 THEN
		NEW.max_temp_group := 'Inhumane';
	ELSE NEW.max_temp_group := 'No reading';
	END CASE;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;










