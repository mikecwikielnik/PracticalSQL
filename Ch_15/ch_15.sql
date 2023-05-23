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
























