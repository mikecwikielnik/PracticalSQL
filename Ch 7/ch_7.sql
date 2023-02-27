-- Joining Tables in a Relational Database

-- Anthony DeBarros. 9781718501072 (Kindle Location 3435). Kindle Edition. 

-- Listing 7-1: Creating the departments and employees tables

-- Anthony DeBarros. 9781718501072 (Kindle Locations 3484-3485). Kindle Edition. 

CREATE TABLE departments (
	dept_id integer,
	dept text,
	city text,
CONSTRAINT dept_key PRIMARY KEY (dept_id),
CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
	emp_id integer,
	first_name text,
	last_name text,
	salary numeric(10, 2),
	dept_id integer REFERENCES departments(dept_id),
CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

INSERT INTO departments
VALUES
	(1, 'Tax', 'New York'),
	(2, 'IT', 'New York');
	
INSERT INTO employees
VALUES
	(1, 'Juliana', 'Marie', 110000, 1),
	(2, 'Veronica', 'King', 98000, 1),
	(3, 'George', 'Pappas', 72500, 2),
	(4, 'Michael', 'Arthur', 250000, 2);
	
-- Listing 7-2: Joining the employees and departments tables

-- Anthony DeBarros. 9781718501072 (Kindle Location 3554). Kindle Edition. 

SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;

-- Listing 7-3: Creating two tables to explore JOIN types

-- Anthony DeBarros. 9781718501072 (Kindle Location 3608). Kindle Edition. 

CREATE TABLE district_2020 (
	id integer CONSTRAINT id_key_2020 PRIMARY KEY,
	school_2020 text
);

CREATE TABLE district_2035 (
	id integer CONSTRAINT id_key_2035 PRIMARY KEY,
	school_2035 text
);

INSERT INTO district_2020 VALUES
	(1, 'Oak Street School'),
	(2, 'Roosevelt High School'),
	(5, 'Dover Middle School'),
	(6, 'Webutuck High School');
	
INSERT INTO district_2035 VALUES
	(1, 'Oak Street School'),
	(2, 'Roosevelt High School'),
	(3, 'Morrison Elementary'),
	(4, 'Chase Magnet Academy'),
	(6, 'Webutuck High School');
	
-- Listing 7-4: Using JOIN

-- Anthony DeBarros. 9781718501072 (Kindle Location 3621). Kindle Edition. 

SELECT *
FROM district_2020 JOIN district_2035
ON district_2020.id = district_2035.id 	-- the on statement col have to match
ORDER BY district_2020.id

-- Listing 7-5: JOIN with USING

-- Anthony DeBarros. 9781718501072 (Kindle Location 3638). Kindle Edition. 

SELECT *
FROM district_2020 JOIN district_2035
USING (id)
ORDER BY district_2020.id;

-- Listing 7-6: Using LEFT JOIN

-- Anthony DeBarros. 9781718501072 (Kindle Location 3654). Kindle Edition. 

SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id 	-- null values!
ORDER BY district_2020.id;






















