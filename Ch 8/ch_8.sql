-- Chapter 8
-- Table Design That Works for You

-- Anthony DeBarros. 9781718501072 (Kindle Location 4002). Kindle Edition. 

-- Listing 8-1: Declaring a single-column natural key as a primary key

-- Anthony DeBarros. 9781718501072 (Kindle Location 4160). Kindle Edition. 

CREATE TABLE natural_key_example (
	license_id text CONSTRAINT license_key PRIMARY KEY,
	first_name text,
	last_name text,
);

DROP TABLE natural_key_example;

CREATE TABLE natural_key_example (
	license_id text,
	first_name text,
	last_name text,
	CONSTRAINT license_key PRIMARY KEY (license_id)
);

