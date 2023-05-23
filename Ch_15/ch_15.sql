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








