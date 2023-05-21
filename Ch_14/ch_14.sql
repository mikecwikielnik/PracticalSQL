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
WITH (FORMAT CSV, HEADER OFF, QUOTE """");

DELETE FROM crime_reports;

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

-- Listing 14-9: Using a capture group to return only the date

-- Anthony DeBarros. 9781718501072 (Kindle Location 7685). Kindle Edition. 

SELECT crime_id,
	regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{2})')
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-10: Matching case number, date, crime type, and city

-- Anthony DeBarros. 9781718501072 (Kindle Location 7749). Kindle Edition. 

SELECT 
	regexp_match(original_text, '(?:C0|SO)[0-9]+') AS case_number,
	regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}') AS date_1,
	regexp_match(original_text, '\n(?:\w+\w+|\w+)\n(.*):') AS crime_type,
	regexp_match(original_text, '(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+\w+|\w+)\n') AS city
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-11: Retrieving a value from within an array

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7776-7777). Kindle Edition. 

SELECT
	crime_id,
	(regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1] AS case_number
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-12: Updating the crime_reports date_1 column

-- Anthony DeBarros. 9781718501072 (Kindle Locations 7794-7795). Kindle Edition. 

UPDATE crime_reports
SET date_1 = 
	(
	(regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
		||''||
	(regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1]
		||'US/Eastern'
	)::timestamptz
RETURNING crime_id, date_1, original_text;

-- Listing 14-13: Updating all crime_reports columns

-- Anthony DeBarros. 9781718501072 (Kindle Location 7861). Kindle Edition. 

UPDATE crime_reports
SET date_1 = 
	(
	(regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
		||''||
	(regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1]
		||'US/Eastern'
	)::timestamptz,
	
	date_2 =
	CASE
		WHEN (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{2})')IS NULL)
			AND (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})')IS NOT NULL)
		THEN 
		((regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
		 ||''||
		(regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
		 ||'US/Eastern'
		)::timestamptz
		
		WHEN (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{2})')IS NOT NULL)
			AND (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})')IS NOT NULL)
		THEN
		((regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})'))[1]
		 ||''||
		(regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
		 ||'US/Eastern'
		)::timestamptz
	END,
	street = (regexp_match(original_text, 'hrs.\n(\d+ .+(?:Sq.|Plz.|Dr.|Ter.|Rd.))'))[1],
	city = (regexp_match(original_text,
						'(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+\w+|\w+)\n'))[1],
	crime_type = (regexp_match(original_text, '\n(?:\w+\w+|\w+)\n(.*):'))[1],
	description = (regexp_match(original_text, ':\s(.+)(?:C0|SO)'))[1],
	case_number = (regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1];

-- Listing 14-14: Viewing selected crime data

-- Anthony DeBarros. 9781718501072 (Kindle Location 7892). Kindle Edition. 

SELECT date_1,
	street,
	city,
	crime_type
FROM crime_reports
ORDER BY crime_id;

-- Listing 14-15: Converting text to tsvector data

-- Anthony DeBarros. 9781718501072 (Kindle Location 7934). Kindle Edition. 

SELECT to_tsvector('english', 'I am walking across the sitting room to sit with you.');

-- Listing 14-16: Converting search terms to tsquery data

-- Anthony DeBarros. 9781718501072 (Kindle Location 7954). Kindle Edition. 

SELECT to_tsquery('english', 'walking & sitting');


