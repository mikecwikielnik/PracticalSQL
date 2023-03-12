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

-- Listing 8-5: Declaring a bigint column as a surrogate key using IDENTITY

-- Anthony DeBarros. 9781718501072 (Kindle Locations 4229-4230). Kindle Edition. 

CREATE TABLE surrogate_key_example (
	order_number bigint GENERATED ALWAYS AS IDENTITY,
	product_name text,
	order_time timestamp with time zone,
	CONSTRAINT order_number_key PRIMARY KEY (order_number)
);

INSERT INTO surrogate_key_example (product_name, order_time)
VALUES  ('Beachball Polish', '2020-03-15 09:21-07'),
		('Wrinkle De-Atomizer', '2017-05-22 14:00-07'),
		('Flux Capacitor', '1985-10-26 01:18:00-07');
		
SELECT * FROM surrogate_key_example;

-- Listing 8-6: Restarting an IDENTITY sequence

-- Anthony DeBarros. 9781718501072 (Kindle Location 4263). Kindle Edition. 

INSERT INTO surrogate_key_example 
OVERRIDING SYSTEM VALUE
VALUES (4, 'Chicken Coop', '2021-09-03 10:33:-07');

ALTER TABLE surrogate_key_example ALTER COLUMN order_number RESTART WITH 5;

INSERT INTO surrogate_key_example (product_name, order_time)
VALUES ('Aloe Plant', '2020-03-15 10:09-07');

SELECT * FROM surrogate_key_example;

















