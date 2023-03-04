-- Chapter 8
-- Table Design That Works for You

-- Anthony DeBarros. 9781718501072 (Kindle Location 4002). Kindle Edition. 

-- Listing 8-1: Declaring a single-column natural key as a primary key

-- Anthony DeBarros. 9781718501072 (Kindle Location 4160). Kindle Edition. 

CREATE TABLE natural_key_example (
	license_id text CONSTRAINT license_key PRIMARY KEY,
	first_name text,
	last_name text
);

DROP TABLE natural_key_example;

CREATE TABLE natural_key_example (
	license_id text,
	first_name text,
	last_name text,
	CONSTRAINT license_key PRIMARY KEY (license_id)
);

-- Listing 8-2: An example of a primary key violation

-- Anthony DeBarros. 9781718501072 (Kindle Location 4179). Kindle Edition. 

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Gem', 'Godfrey');

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'John', 'Mitchell');

-- Listing 8-3: Declaring a composite primary key as a natural key

-- Anthony DeBarros. 9781718501072 (Kindle Locations 4196-4197). Kindle Edition. 

CREATE TABLE natural_key_composite_example (
	student_id text,
	school_day date,
	present boolean,
	CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);

-- Listing 8-4: Example of a composite primary key violation

-- Anthony DeBarros. 9781718501072 (Kindle Location 4205). Kindle Edition. 

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES (775, '2022-01-22', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES (775, '2022-01-23', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES (775, '2022-01-23', 'N');


























