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

-- Listing 10-3: Grouping and counting states

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5108-5109). Kindle Edition. 

SELECT st,
	count(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;

-- Listing 10-4: Using IS NULL to find missing values in the st column

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5131-5132). Kindle Edition. 

SELECT establishment_number,
	company,
	city,
	st,
	zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;

-- Listing 10-5: Using GROUP BY and count() to find inconsistent company

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5158-5159). Kindle Edition. 

SELECT company,
	count(*) AS company_count
FROM meat_poultry_egg_establishments
GROUP BY company
ORDER BY company ASC;

-- Listing 10-6: Using length() and count() to test the zip column

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5184-5185). Kindle Edition. 

SELECT length(zip),
	count(*) AS length_count
FROM meat_poultry_egg_establishments
GROUP BY length(zip)
ORDER BY length(zip) ASC;

-- Listing 10-7: Filtering with length() to find short zip values

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5195-5196). Kindle Edition. 

SELECT st,
	count(*) AS st_count
FROM meat_poultry_egg_establishments
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

-- Listing 10-8: Backing up a table

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5299-5300). Kindle Edition. 

CREATE TABLE meat_poultry_egg_establishments_backup AS
SELECT * FROM meat_poultry_egg_establishments;

-- check that the rows match up

SELECT
	(SELECT count(*) FROM meat_poultry_egg_establishments) AS original,
	(SELECT count(*) FROM meat_poultry_egg_establishments_backup) AS backup;

-- Listing 10-9: Creating and filling the st_copy column with ALTER TABLE and UPDATE

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5330-5331). Kindle Edition. 

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN st_copy text;
UPDATE meat_poultry_egg_establishments
SET st_copy = st;

-- Listing 10-10: Checking values in the st and st_copy columns

-- Anthony DeBarros. 9781718501072 (Kindle Location 5343). Kindle Edition. 

SELECT st,
	st_copy
FROM meat_poultry_egg_establishments
WHERE st IS DISTINCT FROM st_copy
ORDER BY st;

-- Listing 10-11: Updating the st column for three establishments

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5364-5365). Kindle Edition. 

UPDATE meat_poultry_egg_establishments
SET st = 'MN'
WHERE establishment_number = 'V18677A';

UPDATE meat_poultry_egg_establishments
SET st = 'AL'
WHERE establishment_number = 'M45319+P45319';

UPDATE meat_poultry_egg_establishments
SET st= 'WI'
WHERE establishment_number = 'M263A+P263A+V263A'
RETURNING establishment_number, company, city, st, zip;

-- Listing 10-12: Restoring original st column values

-- Anthony DeBarros. 9781718501072 (Kindle Location 5382). Kindle Edition. 

-- restore from backup column
UPDATE meat_poultry_egg_establishments
SET st = st_copy;

-- restore from backup table
UPDATE meat_poultry_egg_establishments original
SET st = backup.st
FROM meat_poultry_egg_establishments_backup backup
WHERE original.establishment_number = backup.establishment_number;

-- Listing 10-13: Creating and filling the company_standard column

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5401-5402). Kindle Edition. 

-- copy the names in company into the new column, and work in the new column.

-- Anthony DeBarros. 9781718501072 (Kindle Location 5397). Kindle Edition. 

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN company_standard text;

UPDATE meat_poultry_egg_establishments
SET company_standard = company;

-- Listing 10-14: Using an UPDATE statement to modify column

-- Anthony DeBarros. 9781718501072 (Kindle Location 5409). Kindle Edition. 

UPDATE meat_poultry_egg_establishments 
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%'
RETURNING company, company_standard;

-- Listing 10-15: Creating and filling the zip_copy column

-- Anthony DeBarros. 9781718501072 (Kindle Location 5436). Kindle Edition. 

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN zip_copy text;

UPDATE meat_poultry_egg_establishments 
SET zip_copy = zip;

-- Listing 10-16: Modifying codes in the zip column missing two leading zeros

-- Anthony DeBarros. 9781718501072 (Kindle Locations 5441-5442). Kindle Edition. 

UPDATE meat_poultry_egg_establishments
SET zip = '00' || zip
WHERE st IN('PR', 'VT') AND length(zip) = 3; -- the best part is the length(zip) argument






