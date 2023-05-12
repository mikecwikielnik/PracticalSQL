-- Chapter 12
-- Working with Dates and Times

-- Anthony DeBarros. 9781718501072 (Kindle Location 6195). Kindle Edition. 

-- Listing 12-1: Extracting components of a timestamp value using date_part()

-- Anthony DeBarros. 9781718501072 (Kindle Locations 6249-6250). Kindle Edition. 

SELECT
	date_part('year', '2022-12-01 18:37:12 EST'::timestamptz) AS year,
	date_part('month', '2022-12-01 18:37:12 EST'::timestamptz) AS month,
	date_part('epoch', '2022-12-01 18:37:12 EST'::timestamptz) AS epoch;






