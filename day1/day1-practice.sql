/* To answer the following questions, please run your queries in https://chinook.ml. You might also copy them here for your reference. */

--If you wish, drop the tables in the Chinook Database:
drop table if exists PlaylistTrack;
drop table if exists Playlist;
drop table if exists InvoiceLine;
drop table if exists Invoice;
drop table if exists Track;
drop table if exists Genre;
drop table if exists MediaType;
drop table if exists Album;
drop table if exists Artist;
drop table if exists Customer;
drop table if exists Employee;

-- Note: if you refresh, these tables will reappear and your tables will disappear.

--TABLE CREATION
-- Create a table with an id, a text column, and a numeric column.
CREATE TABLE newTable (
id integer primary key autoincrement,
name text,
age integer)

--ROW CREATION
-- Insert two rows of data into your table. 
INSERT INTO newTable (name,age) VALUES ('Natalie',25),('MC',25);

--SELECT BASICS
-- Retrieve your two rows of data. 
SELECT * FROM newTable

-- Filter the data to one row with a where clause.
SELECT name FROM newTable where name LIKE '%a%';

-- Take off the where clause and select all of the data again. 
-- Then order the data by one of the fields. 
SELECT * FROM newTable ORDER BY name DESC

-- Flip the order.
SELECT * FROM newTable ORDER BY name ASC

-- Limit the data to one row.
SELECT * FROM newTable ORDER BY name DESC LIMIT 1

--SELECT BASICS WITH REAL DATA 
-- Now drop your table with the following command: 
DROP TABLE table_name;

-- Import the city table by copying the statements from city.sql.

-- Select all of the cities with populations less than 1,000,000.
SELECT * FROM city WHERE population < 1000000;
-- Further filter the results with extra conditions.
SELECT * FROM city WHERE population < 1000000 AND countrycode !='BRA';
-- Select all of the cities from the United States.
SELECT * FROM city WHERE countrycode="USA";
-- Select all of the cities from North America.
SELECT * FROM city WHERE countrycode IN ("USA","MEX","CAN","JAM");
-- Select all of the cities that end with 'town' or 'ton'.
SELECT * FROM city WHERE name LIKE "%town" OR name LIKE "%ton";
-- Select the cities whose country codes contain a 'Z'.
SELECT * FROM city WHERE countrycode LIKE "%z%";
-- NEED MORE PRACTICE? 
-- Try importing the country database and selecting different rows and columns. 

-- CALCULATIONS AND AGGREGATIONS

-- Copy the statements from country.sql and run them in chinook. 

-- Calculate the population density of each country. 
SELECT name,(population/surfacearea) AS populationdensity FROM country
-- Which nation gained its independence first?
SELECT name, indepyear FROM country ORDER BY indepyear ASC LIMIT 1
-- Count the number of nations with 'stan' in their name (or 'Guinea' or 'land').
SELECT COUNT(name) AS nameCount FROM country 
WHERE name LIKE '%stan%' OR name LIKE '%land%' or name LIKE '%Guinea%';
-- Count the number of countries in Africa.
SELECT COUNT(name) AS africanNations FROM country 
WHERE continent="Africa";
-- Count the number of nations which gained their independence after 1960. 
SELECT COUNT(name) AS after1960 FROM country 
WHERE indepyear > 1960;
-- Find the average life expectancy for European and Asian nations. 
SELECT AVG(lifeexpectancy) AS avgLife FROM country 
WHERE continent in ("Europe", "Asia");

--MORE PRACTICE
-- Copy the countrylanguage table into chinook. 

-- How many distinct languages does this table contain? 
SELECT COUNT(DISTINCT(language)) AS totalLanguages FROM countrylanguage;
-- Which nation has the most recorded languages? 
SELECT countrycode,COUNT(language) AS mostlangs FROM countrylanguage GROUP BY countrycode ORDER BY mostlangs DESC LIMIT 1;
-- Which languages are spoken in the most nations? 
SELECT language,COUNT(language) AS mostspoken 
FROM countrylanguage GROUP BY language ORDER BY mostspoken DESC LIMIT 1;
-- Which language is most creolized? 
SELECT language,COUNT(language) AS mostspoken 
FROM countrylanguage WHERE language LIKE "%creole%" GROUP BY language ORDER BY mostspoken DESC LIMIT 1;


--ONE FOR THE MONEY
-- Drop the tables above if you wish:
drop table if exists country;
drop table if exists city;
drop table if exists countrylanguage;

-- Copy the computer_jobs table into chinook, and do a little job research. 

-- Which state, on average, pays computer workers the most? 
SELECT state,AVG(median_salary) AS avgPay FROM computerjobs 
GROUP BY state ORDER by avgPay DESC LIMIT 1;
-- Which field of computer science pays the most on average? 
SELECT title,AVG(median_salary) AS avgPay FROM computerjobs 
GROUP BY title ORDER by avgPay DESC LIMIT 1;
-- Which field has the most number of jobs? 
SELECT title,COUNT(jobs_per_1000) AS jobTotal FROM computerjobs 
GROUP BY title ORDER by jobTotal DESC LIMIT 1;
-- How much do web developers make in your state? 
SELECT title,state,AVG(median_salary) AS avgPay FROM computerjobs 
WHERE state="GA" AND title="Web Developers";
-- Which state employs the most web developers? 
SELECT title,state,number_employed AS employees FROM computerjobs
WHERE title="Web Developers" 
GROUP BY state ORDER BY employees DESC LIMIT 1;

--STILL WANT MORE? 
-- Find some data you want to play around with. These queries can be painfully rote if you're using fake data--you can look up only so many fake product orders before your mind begins to wander. See if you can find data for something you're interested in. If you can get the data into a spreadsheet, I'll help you convert it and insert it into chinook. I also have job data for all occupations in Dallas if you're interested.






