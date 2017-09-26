/* Return to https://chinook.ml. Feel free to drop the existing tables, as you will use them in the afternoon project. */

--UPDATE
    -- Create a table or use one of the sql files to create a table. 
    CREATE TABLE food (
foodId integer primary key autoincrement,
name text,
cuisine text);
INSERT INTO food (name,cuisine) VALUES ('tacos', 'Mexican'), 
('hamburger','American'), ('curry','Thai');
SELECT * FROM food;
    -- Update one value in one row. 
UPDATE food
SET name='french fries'
WHERE cuisine="American";
SELECT * FROM food;
    -- Update multiple values in one row. 
UPDATE food
SET name='schnitzel', cuisine="German"
WHERE foodId=2;
SELECT * FROM food;
    -- Update multiple values in multiple rows.
UPDATE food
SET cuisine="Mexican", rating=4 WHERE cuisine="Latin";
SELECT * from food;
    -- Update values in rows using a subquery
        -- For example, set all country populations to 1000000 where the populations are larger than the population of South Africa
UPDATE food
SET name='pretzel' WHERE cuisine = (SELECT cuisine FROM food WHERE rating=3);
SELECT * FROM food;
--DELETE
    -- Delete a row from a table.
ALTER TABLE food
DROP rating;
SELECT * FROM food;
    -- Delete all rows from the table.
DROP TABLE IF EXISTS food;
    -- Undo the operation. (Just kidding--you can't undo a delete!)

--JOINS
    -- Now we're going to need related tables. Copy the statements from world.sql into chinook in order to get started.  

    -- You should see three tables. These tables share one value, the country code. We can use this code to join the tables and provide combined data. 

    -- Begin by joining the country table to the countrylanguage table. 
SELECT c.*, cl.* FROM country c
JOIN countrylanguage cl ON c.code = cl.countrycode;
    -- Now join the city table to the country table. 
SELECT c.*, ci.* FROM country c
JOIN city ci ON c.code = ci.countrycode;
    -- Finally, join all three (I'd just include one column from each) so you can see every language for every city in every country. (Note: this isn't exactly accurate. The country's langauges may not be spoken in every city.)
SELECT c.name, ci.name, cl.language FROM country c
JOIN city ci, countrylanguage cl ON c.code = ci.countrycode AND c.code= cl.countrycode;
--CALCULATIONS, AGGREGATIONS, and JOINS
    -- Okay, now that you have the mechanics down, let's see what we can find. 

    -- Find the most populous capital cities. 
SELECT c.name, ci.name, ci.population FROM country c
JOIN city ci ON c.capital = ci.id
ORDER BY ci.population DESC;
    -- Find the languages which have the most number of speakers in any one nation. 
select (cl.percentage*c.population) AS speakers, c.name, cl.language  from countrylanguage cl
JOIN country c ON c.code = cl.countrycode GROUP BY c.name HAVING MAX(speakers) ORDER BY countrycode ;
    -- Find the languages with the most number of speakers globally. 
SELECT cl.language, count(cl.language) AS spokenIn, (cl.percentage*c.population) AS speakers  FROM country c
JOIN countrylanguage cl ON c.code = cl.countrycode
GROUP BY cl.language HAVING MAX(speakers)
ORDER BY speakers DESC;
    -- List the countries with total_urban_population alongside their total population. For an extra challenge, try ranking the countries by the percentage of their population that is urban or rural.
SELECT c.name, SUM((cast (ci.population AS float) /cast (c.population AS float))) AS total_urban_population,
c.population
FROM country c
JOIN city ci ON (ci.countrycode = c.code) GROUP by c.name;
    