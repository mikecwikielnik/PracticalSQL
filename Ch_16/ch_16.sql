-- Chapter 16 
-- Working with JSON Data

-- Anthony DeBarros. 9781718501072 (Kindle Location 8953). Kindle Edition. 

-- Listing 16-2: Creating a table to hold JSON data and adding an index

-- Anthony DeBarros. 9781718501072 (Kindle Location 9068). Kindle Edition. 

CREATE TABLE films(
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	film jsonb NOT NULL
);

COPY films(film)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_16\films.json';

CREATE INDEX idx_film ON films USING GIN (film);

SELECT * FROM films;

-- Listing 16-3: Retrieving a JSON key value with field extraction operators

-- Anthony DeBarros. 9781718501072 (Kindle Location 9115). Kindle Edition. 

SELECT id, film -> 'title' AS title
FROM films
ORDER BY id;

SELECT id, film ->> 'title' AS title
FROM films
ORDER BY id;

SELECT id, film -> 'genre' AS genre
FROM films
ORDER BY id;

-- Listing 16-4: Retrieving a JSON array value with element extraction operators

-- Anthony DeBarros. 9781718501072 (Kindle Location 9142). Kindle Edition. 

SELECT id, film -> 'genre' -> 0 AS genres
FROM films
ORDER BY id;

SELECT id, film -> 'genre' -> 1 AS genres
FROM films
ORDER BY id;

SELECT id, film -> 'genre' -> 2 AS genres
FROM films
ORDER BY id;

SELECT id, film -> 'genre' ->> 0 AS genres
FROM films
ORDER BY id;

-- Listing 16-5: Retrieving a JSON key value with path extraction operators

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9190-9191). Kindle Edition. 

SELECT id, film #> '{rating, MPAA}' AS mpaa_rating
FROM films
ORDER BY id;

SELECT id, film #> '{characters, 0, name}' AS name
FROM films
ORDER BY id;

SELECT id, film #>> '{characters, 0, name}' AS name
FROM films
ORDER BY id;

-- Listing 16-6: Demonstrating the @> containment operator

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9236-9237). Kindle Edition. 

SELECT id, film ->> 'title' AS title,
	film @> '{"title": "The Incredibles"}'::jsonb AS is_incredible
FROM films
ORDER by id;

-- Listing 16-7: Using a containment operator in a WHERE clause

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9251-9252). Kindle Edition. 

SELECT film ->> 'title' AS title,
	film ->> 'year' AS year
FROM films
WHERE film @> '{"title":"The Incredibles"}'::jsonb;

-- Listing 16-8: Demonstrating the <@ containment operator

-- Anthony DeBarros. 9781718501072 (Kindle Location 9262). Kindle Edition. 

SELECT film ->> 'title' AS title,
	film ->> 'year' AS year
FROM films
WHERE '{"title":"The Incredibles"}'::jsonb <@ film;

-- Listing 16-9: Demonstrating existence operators

-- Anthony DeBarros. 9781718501072 (Kindle Location 9274). Kindle Edition. 

SELECT film ->> 'title' AS title
FROM films
WHERE film ? 'rating';

SELECT film ->> 'title' AS title,
	film ->> 'rating' AS rating,
	film ->> 'genre' AS genre
FROM films
where film ?| '{rating, genre}';

SELECT film ->> 'title' AS title,
	film ->> 'rating' AS rating,
	film ->> 'genre' AS genre
FROM films 
WHERE film ?& '{rating, genre}';

-- Listing 16-11: Creating and loading an earthquakes table

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9326-9327). Kindle Edition. 

CREATE TABLE earthquakes (
	id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	earthquake jsonb NOT NULL
);

COPY earthquakes (earthquake)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_16\earthquakes.json';

CREATE INDEX idx_earthquakes ON earthquakes USING GIN (earthquake);

-- Listing 16-12: Retrieving the earthquake time

-- Anthony DeBarros. 9781718501072 (Kindle Location 9336). Kindle Edition. 

SELECT id, earthquake #>> '{properties, time}' AS time
FROM earthquakes
ORDER BY id LIMIT 5;

-- Listing 16-13: Converting the time value to a timestamp

-- Anthony DeBarros. 9781718501072 (Kindle Location 9350). Kindle Edition. 

SELECT id, earthquake #>> '{properties, time}' as time,
	to_timestamp(
		(earthquake #>> '{properties, time}')::bigint / 10002
			) AS time_formatted
FROM earthquakes
ORDER BY id LIMIT 5;

-- Listing 16-14: Finding the minimum and maximum earthquake times

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9369-9370). Kindle Edition. 

SELECT min (to_timestamp(
	(earthquake #>> '{properties, time}')::bigint / 1000
		)) AT TIME ZONE 'UTC' AS min_timestamp,
	max(to_timestamp(
		(earthquake #>> '{properties, time}')::bigint / 1000
		)) AT TIME ZONE 'UTC' AS max_timestammp
FROM earthquakes;			

-- Listing 16-15: Finding the five earthquakes with the largest magnitude

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9390-9391). Kindle Edition. 

SELECT earthquake #>> '{properties, place}' AS place,
	to_timestamp((earthquake #>> '{properties, time}')::bigint / 1000)
		AT TIME ZONE 'UTC' AS time,
	(earthquake #>> '{properties, mag}')::numeric AS magnitude
FROM earthquakes
ORDER BY (earthquake #>> '{properties, mag}')::numeric DESC NULLS LAST
LIMIT 5;

-- Listing 16-16: Finding earthquakes with the most Did You Feel It? reports

-- Anthony DeBarros. 9781718501072 (Kindle Locations 9415-9416). Kindle Edition. 

SELECT earthquake #>> '{properties, place}' AS place,
	to_timestamp((earthquake #>> '{properties, time}')::bigint / 1000)
		AT TIME ZONE 'UTC' AS time,
	(earthquake #>> '{properties, mag}')::numeric AS magnitude,
	(earthquake #>>  '{properties, felt}')::integer AS felt
FROM earthquakes
ORDER BY (earthquake #>> '{properties, felt}')::integer DESC NULLS LAST
LIMIT 5;














