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

-- Listing 12-5: Showing time zone abbreviations and names

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6388-6389). Kindle Edition. 

SELECT * FROM pg_timezone_abbrevs ORDER BY abbrev; 
SELECT * FROM pg_timezone_names ORDER BY name;

-- Listing 12-6: Setting the time zone for a client session

-- Anthony DeBarros. 9781718501072 (Kindle Location 6418). Kindle Edition. 

SET TIME ZONE 'US/Pacific';

CREATE TABLE time_zone_test (
	test_date timestamptz
);

INSERT INTO time_zone_test VALUES ('2023-01-01 4:00');

SELECT test_date
FROM time_zone_test;

SET TIME ZONE 'US/Eastern';

SELECT test_date
FROM time_Zone_test;

SELECT test_date AT TIME ZONE 'Asia/Seoul'
FROM time_zone_test;

-- Listing 12-7: Creating a table and importing NYC yellow taxi data

-- Anthony DeBarros. 9781718501072 (Kindle Location 6494). Kindle Edition. 

CREATE TABLE nyc_yellow_taxi_trips (
	trip_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	vendor_id text NOT NULL,
	tpep_pickup_datetime timestamptz NOT NULL,
	tpep_dropoff_datetime timestamptz NOT NULL,
	passenger_count integer NOT NULL,
	trip_distance numerIC(8, 2) NOT NULL,
	pickup_longitude numeric(18, 15) NOT NULL,
	pickup_latitude numeric(18, 15) NOT NULL,
	rate_code_id text NOT NULL,
	store_and_fwd_flag text NOT NULL,
	dropoff_longitude numeric(18, 15) NOT NULL,
	dropoff_latitude numeric(18, 15) NOT NULL,
	payment_type text NOT NULL,
	fare_amount numeric(9, 2) NOT NULL,
	extra numeric(9, 2) NOT NULL,
	mta_tax numeric(5, 2) NOT NULL,
	tip_amount numeric(9, 2) NOT NULL,
	tolls_amount numeric(9, 2) NOT NULL,
	improvement_surcharge numeric(9, 2) NOT NULL,
	total_amount numeric(9, 2) NOT NULL
);

COPY nyc_yellow_taxi_trips (
	vendor_id,
	tpep_pickup_datetime,
	tpep_dropoff_datetime, 
	passenger_count,
	trip_distance,
	pickup_longitude,
	pickup_latitude,
	rate_code_id,
	store_and_fwd_flag,
	dropoff_longitude,
	dropoff_latitude,
	payment_type,
	fare_amount,
	extra,
	mta_tax,
	tip_amount,
	tolls_amount,
	improvement_surcharge,
	total_amount
)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_12\nyc_yellow_taxi_trips.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX tpep_pickup_idx
ON nyc_yellow_taxi_trips (tpep_pickup_datetime);

select * from nyc_yellow_taxi_trips;

-- Listing 12-8: Counting taxi trips by hour

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6519-6520). Kindle Edition. 

SELECT 
	date_part('hour', tpep_pickup_datetime) AS trip_hour, -- super interesting line of code
	count(*)
FROM nyc_yellow_taxi_trips
GROUP BY trip_hour
ORDER BY trip_hour;

-- Listing 12-9: Exporting taxi pickups per hour to a CSV file

-- Anthony DeBarros. 9781718501072 (Kindle Location 6546). Kindle Edition. 

COPY
	(SELECT
		date_part('hour', tpep_pickup_datetime) AS trip_hour,
		count(*)
	FROM nyc_yellow_taxi_trips
	GROUP BY trip_hour
	ORDER BY trip_hour
	)
TO 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_12\hourly_taxi_pickups.csv'
WITH (FORMAT CSV, HEADER);










