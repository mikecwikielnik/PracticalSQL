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
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_10\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX company_idx ON meat_poultry_egg_establishments (company);


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
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_10\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX company_idx ON meat_poultry_egg_establishments (company);

SELECT count(*) FROM meat_poultry_egg_establishments;

-- Listing 10-2: Finding multiple companies at the same address

-- Anthony DeBarros. 9781718501072 (Kindle Location 5084). Kindle Edition. 

SELECT company,
	street,
	city,
	st,
	count(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;







