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











