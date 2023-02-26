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

















