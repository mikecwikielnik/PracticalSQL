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

-- Listing 19-3: Inserting 500,000 rows into vacuum_test

-- Anthony DeBarros. 9781718501072 (Kindle Location 11077). Kindle Edition. 

INSERT INTO vacuum_test
SELECT * FROM generate_series(1, 500000);

-- Listing 19-4: Updating all rows in vacuum_test

-- Anthony DeBarros. 9781718501072 (Kindle Location 11089). Kindle Edition. 

UPDATE vacuum_test
SET integer_column = integer_column + 1;

-- Listing 19-5: Viewing autovacuum statistics for vacuum_test

-- Anthony DeBarros. 9781718501072 (Kindle Locations 11112-11113). Kindle Edition. 

SELECT relname,
	last_vacuum,
	last_autovacuum,
	vacuum_count,
	autovacuum_count,
FROM pg_stat_all_tables
WHERE relname = 'vacuum_test';

-- Listing 19-6: Running VACUUM manually

-- Anthony DeBarros. 9781718501072 (Kindle Location 11141). Kindle Edition. 

VACUUM vacuum_test;

-- Listing 19-7: Using VACUUM FULL to reclaim disk space

-- Anthony DeBarros. 9781718501072 (Kindle Location 11154). Kindle Edition. 

VACUUM FULL vacuum_test;

-- Listing 19-8: Showing the location of postgresql.conf

-- Anthony DeBarros. 9781718501072 (Kindle Location 11170). Kindle Edition. 

SHOW config_file;













