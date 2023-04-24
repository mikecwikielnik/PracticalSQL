-- Chapter 10

-- Inspecting and Modifying Data

-- Anthony DeBarros. 9781718501072 (Kindle Location 5017). Kindle Edition. 

CREATE TABLE meat_poultry_egg_establishments (
	establishment_number text CONSTRAINT est_number_key PRIMARY KEY,
	company text,
	street text,
	city text,
	st text,
	zip text,
	phone text,
	grant_date text,
	activities text,
	dbas text
);

COPY meat_poultry_egg_establishments
FROM 'path\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX company_idx ON meat_poultry_egg_establishments (company);








