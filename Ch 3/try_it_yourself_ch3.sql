-- try it yourself

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 40). No Starch Press. Kindle Edition. 

table teachers;

-- 1 

SELECT school, last_name
FROM teachers
ORDER BY school asc, last_name asc;

-- 2

SELECT first_name, last_name, salary
FROM teachers
WHERE first_name LIKE 'S%' and salary > '40000';

-- 3

SELECT first_name, last_name, salary
FROM teachers
WHERE hire_date > '2010-01-01'
ORDER BY salary desc;

