-- Chapter 19 
-- Maintaining Your Database

-- Anthony DeBarros. 9781718501072 (Kindle Locations 11007-11008). Kindle Edition. 

-- Listing 19-1: Creating a table to test vacuuming

-- Anthony DeBarros. 9781718501072 (Kindle Locations 11047-11048). Kindle Edition. 

CREATE TABLE vacuum_test (
	integer_column integer
);

-- Listing 19-2: Determining the size of vacuum_test

-- Anthony DeBarros. 9781718501072 (Kindle Locations 11057-11058). Kindle Edition. 

-- find the size of the table via a query

SELECT pg_size_pretty(
	pg_total_relation_size('vacuum_test')
);


















