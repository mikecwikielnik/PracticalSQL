-- Chapter 12
-- Working with Dates and Times

-- Anthony DeBarros. 9781718501072 (Kindle Location 6195). Kindle Edition. 

-- Listing 12-1: Extracting components of a timestamp value using date_part()

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6249-6250). Kindle Edition. 

SELECT
	date_part('year', '2022-12-01 18:37:12 EST'::timestamptz) AS year,
	date_part('month', '2022-12-01 18:37:12 EST'::timestamptz) AS month,
	date_part('epoch', '2022-12-01 18:37:12 EST'::timestamptz) AS epoch;

-- Listing 12-2: Three functions for making datetimes from components

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6313-6314). Kindle Edition. 

SELECT make_date(2022, 2, 22);
SELECT make_time(18, 4, 30.3);
SELECT make_timestamptz(2022, 2, 22, 18, 4, 30.3, 'Europe/Lisbon');

-- Bonus: Retrieving the current date and time

SELECT
    current_timestamp,
    localtimestamp,
    current_date,
    current_time,
    localtime,
    now();


-- Listing 12-3: Comparing current_timestamp and clock_timestamp() during row insert

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6347-6348). Kindle Edition. 

CREATE TABLE current_time_example (
	time_id integer GENERATED ALWAYS AS IDENTITY,
	current_timestamp_col timestamptz,
	clock_timestamp_col timestamptz
);

INSERT INTO current_time_example
		(current_timestamp_col, clock_timestamp_col)
	(SELECT current_timestamp,
		clock_timestamp()
	FROM generate_series(1, 1000));

SELECT * FROM current_time_example;

-- Listing 12-4: Viewing your current time zone setting

-- Anthony DeBarros. 9781718501072 (Kindle Location 6373). Kindle Edition. 

SHOW timezone;
SELECT current_setting('timezone');





