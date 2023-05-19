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












