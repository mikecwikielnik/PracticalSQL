-- Chapter 14 
-- Mining Text to Find Meaningful Data

-- Anthony DeBarros. 9781718501072 (Kindle Location 7336). Kindle Edition. 

-- Listing 14-1: Using regular expressions in a WHERE clause

-- Anthony DeBarros. 9781718501072 (Kindle Location 7510). Kindle Edition. 

SELECT county_name
FROM us_counties_pop_est_2019
WHERE county_name ~* '(lade|lare)'
ORDER BY county_name;

SELECT county_name
FROM us_counties_pop_est_2019
WHERE county_name ~* 'ash' AND county_name !~ 'Wash'
ORDER BY county_name;

-- Listing 14-2: Regular expression functions to replace and split text

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7531-7532). Kindle Edition. 

SELECT regexp_replace('05/12/2024', '\d{4}', '2023');

SELECT regexp_split_to_table('Four,score,and,seven,years,ago',','); -- notice the name of the fn's

SELECT regexp_split_to_array('Phil Mike Tony Steve', ''); -- again, notice the name of the fn's

-- regexp_replace(string, pattern, replacement text)
-- regexp_split_to_table(string, pattern)
-- regexp_split_to_array(string, pattern)

-- Listing 14-3: Finding an array length

-- Anthony DeBarros. 9781718501072 (Kindle Location 7553). Kindle Edition. 

SELECT array_length(regexp_split_to_array('Phil Mike Tony Steve', ''),1);

-- Listing 14-5: Creating and loading the crime_reports table

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7599-7600). Kindle Edition. 

CREATE TABLE crime_reports (
	crime_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	case_number text,
	date_1 timestamptz,
	date_2 timestamptz,
	street text,
	city text,
	crime_type text,
	description text,
	original_text text NOT NULL
);

COPY crime_reports(original_text)
FROM 'C:\Users\mikec\OneDrive\Google One Drive\Google Drive\SQL\Practical SQL, 2nd Ed\practical-sql-2-main\Chapter_14\crime_reports.csv'
WITH (FORMAT CSV, HEADER OFF, QUOTE '''');

SELECT original_text FROM crime_reports;

-- Listing 14-6: Using regexp_match() to find the first date

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7636-7637). Kindle Edition. 

SELECT crime_id,
	regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}')
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-7: Using the regexp_matches() function with the g flag

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7653-7654). Kindle Edition. 

SELECT crime_id,
	regexp_matches(original_text, '\d{1,2}\/\d{1,2}\/\d{2}', 'g')
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-8: Using regexp_match() to find the second date

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7671-7672). Kindle Edition. 

SELECT crime_id,
	regexp_match(original_text, '-\d{1,2}\/\d{1,2}\/\d{2}')
FROM crime_reports
ORDER BY crime_id;





