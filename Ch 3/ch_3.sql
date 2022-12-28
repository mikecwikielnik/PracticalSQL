-- Beginning Data Exploration with SELECT

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 29). No Starch Press. Kindle Edition. 

-- basic SELECT syntax

SELECT * FROM teachers;

-- a quick way to view the tables

TABLE type_of_animal; -- neato

-- querying a subset of columns

SELECT last_name, first_name, salary FROM teachers;

-- Sorting Data with ORDER BY

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 32). No Starch Press. Kindle Edition. 

SELECT first_name, last_name, salary
FROM teachers
ORDER BY salary DESC;

-- you can use numbers to id columns as well

SELECT first_name, last_name, salary
FROM teachers
ORDER BY 3 DESC;

--- ex: sorting on more than one column
-- this shows us the newest teachers at each school! 

SELECT last_name, school, hire_Date
FROM teachers
ORDER BY school ASC,hire_date DESC;

-- Using DISTINCT to Find Unique Values

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 33). No Starch Press. Kindle Edition. 

SELECT DISTINCT school
FROM teachers
ORDER BY school;

-- distinct works on more than one column

SELECT DISTINCT school, salary
FROM teachers
ORDER BY school, salary;

-- "for each x in the table, what are all the y-values?"
-- answers the "for each.." questions! 

-- Filtering Rows with WHERE

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 35). No Starch Press. Kindle Edition. 

-- where follows from

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

-- other examples of commonly used comparison operators

-- teachers named janet

SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet';

-- list all schools not named fd roosevelt

SELECT school
FROM teachers
WHERE school <> 'F.D. Roosevelt HS';

-- less operator to list teacheres hired BEFORE jan 1, 2000 (using yyyy-mm-dd)

SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';

--    Using LIKE and ILIKE with WHERE

SELECT first_name
FROM teachers WHERE first_name LIKE 'sam%'; 
SELECT first_name
FROM teachers WHERE first_name ILIKE 'sam%';

-- Combining Operators with AND and OR




































































































































