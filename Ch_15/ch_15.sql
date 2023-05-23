-- Chapter 15 
-- Analyzing Spatial Data with PostGIS

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8185-8186). Kindle Edition. 

-- Listing 15-1: Loading the PostGIS extension

-- Anthony DeBarros. 9781718501072 (Kindle Location 8211). Kindle Edition. 

CREATE EXTENSION postgis;

SELECT postgis_full_version();

-- Listing 15-2: Retrieving the WKT for SRID 4326

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8302-8303). Kindle Edition. 

SELECT srtext
FROM spatial_ref_sys
WHERE srid = 4326;

-- Listing 15-3: Using ST_GeomFromText() to create spatial objects

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8357-8358). Kindle Edition. 

SELECT ST_GeomFromText('POINT(-74.9233606 42.699992)', 4326);

SELECT ST_GeomFromText('LINESTRING(-74.49 42.7, -75.1 42.7)', 4326);

SELECT ST_GeomFromText('POLYGON((-74.9 42.7, -75.1 42.7, -75.1 42.6, -74.9 42.7))', 4362);

SELECT ST_GeomFromText('MULTIPOINT(-74.9 42.7, -75.1 42.7)', 4326);

SELECT ST_GeomFromText('MULTILINESTRING((-76.27 43.1, -76.06 43.08),
					  (-76.2 43.3, -76.2 43.4,
					  -76.4 43.1))', 4326);
					  
SELECT ST_GeomFromText('MULTIPOLYGON((
					  (-74.92 42.7, -75.06 42.71,
					  -75.07 42.64, -74.92 42.7),
					  (-75.0 42.66, -75.0 42.64,
					  -74.98 42.64, -74.98 42.66,
					  -75.0 42.66)))', 4326);

-- Listing 15-4: Using ST_GeogFromText() to create spatial objects

-- Anthony DeBarros. 9781718501072 (Kindle Location 8385). Kindle Edition. 

SELECT ST_GeogFromText('SRID = 4326; MULTIPOINT(-74.9 42.7, -75.1 42.7, -74.924 42.6)')

-- Listing 15-5: Functions specific to making Points

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8397-8398). Kindle Edition. 

SELECT ST_PointFromText('POINT(-74.9233606 42.699992)', 4326);

SELECT ST_MakePoint(-74.9233606, 42.699992);
SELECT ST_SetSRID(ST_MakePoint(-74.9233606, 42.699992), 4326);

-- Listing 15-6: Functions specific to making LineStrings

-- Anthony DeBarros. 9781718501072 (Kindle Location 8415). Kindle Edition. 

SELECT ST_LineFromText('LINESTRING(-105.90 35.67, -105.91 35.67)', 4326);

SELECT ST_MakeLine(ST_MakePoint(-74.9, 42.7), ST_MakePoint(-74.1, 42.4));

-- Listing 15-7: Functions specific to making Polygons

-- Anthony DeBarros. 9781718501072 (Kindle Location 8440). Kindle Edition. 

SELECT ST_PolygonFromText('POLYGON((-74.9 42.7, -75.1 42.7, -75.1 42.6, -74.9 42.7))', 4326);

SELECT ST_MakePolygon(ST_GeomFromText('LINESTRING(-74.92 42.7, -75.06 42.71, -75.07 42.64, -74.92 42.7)', 4326));

SELECT ST_MPolyFromText('MULTIPOLYGON((
					   (-74.92 42.7, -75.06 42.71,
					   -75.07 42.64, -74.92 42.7),
					   (-75.0 42.66, -75.0 42.64,
					   -74.98 42.64, -74.98 42.66,
					   -75.0 42.66)
					   ))', 4326);

-- Listing 15-8: Creating and loading the farmers_markets table

-- Anthony DeBarros. 9781718501072 (Kindle Location 8465). Kindle Edition. 

CREATE TABLE farmers_markets (
	fmid bigint PRIMARY KEY,
	market_name text NOT NULL,
	street text,
	city text,
	county text,
	st text NOT NULL,
	zip text,
	longitude numeric(10, 7),
	latitude numeric(10, 7),
	organic text NOT NULL
);

COPY farmers_markets
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_15\farmers_markets.csv'
WITH (FORMAT CSV, HEADER);

-- Listing 15-9: Creating and indexing a geography column

-- Anthony DeBarros. 9781718501072 (Kindle Location 8483). Kindle Edition. 

ALTER TABLE farmers_markets ADD COLUMN geog_point geography(POINT, 4326);

UPDATE farmers_markets
SET geog_point =
	ST_SetSRID(
		ST_MakePoint(longitude, latitude)::geography, 4326);
		
CREATE INDEX market_pts_idx ON farmers_markets USING GIST (geog_point);

SELECT longitude,
	latitude,
	geog_point,
	ST_AsEWKT(geog_point)
FROM farmers_markets
WHERE longitude IS NOT NULL
LIMIT 5;

-- Listing 15-10: Using ST_DWithin() to locate farmers’ markets within 10 km of a point

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8534-8535). Kindle Edition. 

SELECT market_name, 
	city,
	st,
	geog_point
FROM farmers_markets
WHERE ST_DWithin(geog_point,
				ST_GeogFromText('POINT(-93.6204386 41.5853202)'),
				10000)
ORDER BY market_name;				

-- Listing 15-11: Using ST_Distance() to calculate the miles between Yankee Stadium and Citi Field

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8573-8574). Kindle Edition. 

SELECT ST_Distance(
	ST_GeogFromText('POINT(-73.9283685 40.8296466)'),
	ST_GeogFromText('POINT(-73.8480153 40.7570917)')
	)/1609.344 AS mets_to_yanks;

-- Listing 15-12: Using ST_Distance() for each row in farmers_markets

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8587-8588). Kindle Edition. 

SELECT market_name,
	city,
	round(
		(ST_Distance(geog_point,
					ST_GeogFromText('POINT(-93.6204386 41.5853202)')
					)/1609.344)::numeric, 2
		) AS miles_from_dt
FROM farmers_markets
WHERE ST_DWithin(geog_point,
				ST_GeogFromText('POINT(-93.6204386 41.5853202)'),
				10000)
ORDER BY miles_from_dt ASC;				

-- Listing 15-13: Using the <-> distance operator for a nearest neighbors search

-- Anthony DeBarros. 9781718501072 (Kindle Locations 8628-8629). Kindle Edition. 

SELECT market_name,
	city,
	st,
	round(
		(ST_Distance(geog_point,
					ST_GeogFromText('POINT(-68.2041607 44.3876414)')
					)/1609.344)::numeric, 2
		) AS miles_from_bh
FROM farmers_markets
ORDER BY geog_point <-> ST_GeogFromText('POINT(-68.2041607 44.3876414)')
LIMIT 3;	












