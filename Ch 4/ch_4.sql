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



























