-- Understanding Data Types

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 41). No Starch Press. Kindle Edition. 

-- Listing 4-1: Character data types in action

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 43). No Starch Press. Kindle Edition. 

CREATE TABLE char_data_types (
	char_column varchar(10), 
	varchar_column varchar(10), 
	text_column text
);

INSERT INTO char_data_types 
VALUES ('abc', 'abc', 'abc'), ('defghi', 'defghi', 'defghi');

TABLE char_data_types

COPY char_data_types TO 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_04/typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Listing 4-2: Number data types in action

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 49). No Starch Press. Kindle Edition. 

CREATE TABLE number_data_types (
	numeric_column numeric(20,5),
	real_column real, 
	double_column double precision
);

INSERT INTO number_data_types
VALUES (.7, .7, .7), (2.13579, 2.13579, 2.13579), (2.1357987654,
												  2.1357987654, 
												  2.1357987654);
												  
SELECT * FROM number_data_types;

-- Listing 4-3: Rounding issues with float columns

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 50). No Starch Press. Kindle Edition. 

SELECT numeric_column*10000000 AS fixed, real_column*10000000 AS floating
FROM number_data_types
WHERE numeric_column = .7;

-- Listing 4-4: The timestamp and interval types in action

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 52). No Starch Press. Kindle Edition. 

CREATE TABLE date_time_types (timestamp_column timestamp with time zone, 
							  interval_column interval);
INSERT INTO date_time_types
VALUES ('2022-12-31 01:00 EST','2 days'), ('2022-12-31 01:00 -8','1 month'), ('2022-12-31 01:00 Australia/Melbourne','1 century'), (now(),'1 week');

SELECT * FROM date_time_types;

-- Listing 4-5: Using the interval data type

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 53). No Starch Press. Kindle Edition. 

SELECT timestamp_column, interval_column, timestamp_column - interval_column AS new_date
FROM date_time_types;

-- Listing 4-6: Three CAST() examples

-- DeBarros, Anthony. Practical SQL, 2nd Edition (p. 55). No Starch Press. Kindle Edition. 

SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types; 
SELECT numeric_column, CAST(numeric_column AS integer), CAST(numeric_column AS text)
FROM number_data_types; 
SELECT CAST(char_column AS integer)
FROM char_data_types;













