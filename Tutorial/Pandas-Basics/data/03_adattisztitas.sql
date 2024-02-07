/*CREATE TABLE movie_db ( 
	movies varchar, 
	year varchar, 
	genre varchar, 
	rating varchar, 
	one_line varchar, 
	stars varchar, 
	votes varchar, 
	runtime varchar, 
	gross varchar
);

COPY movie_db FROM 'c:/Users/Public/Documents/data/movies.csv' WITH CSV HEADER DELIMITER ','; */

--NÉZZÜNK BELE AZ ADATOKBA ÉS ÉRTELMEZZÜK ŐKET
SELECT * FROM movie_db
--WHERE runtime::integer > 200
ORDER BY 1,2,votes

--HÁNY KÜLÖNBÖZŐ MOZI VAN A LISTÁBAN?
SELECT COUNT(DISTINCT movies) FROM movie_db;

-- HÁNY FILMHEZ NINCS YEAR, RATING, VOTE?
SELECT COUNT(1) FROM movie_db
WHERE year IS NULL
AND rating IS NULL
AND votes IS NULL;

--MILYEN ÉRTÉKEK VANNAK A YEAR MEZŐBEN?
SELECT DISTINCT YEAR FROM movie_db
ORDER BY 1;

--MILYEN ÉRTÉKEK VANNAK A RUNTIME MEZŐBEN?
SELECT distinct runtime::integer FROM movie_db
ORDER BY 1;

--MILYEN ÉRTÉKEK VANNAK A GROSS MEZŐBEN?
SELECT distinct gross, gross_corrected FROM movie_db
ORDER BY 1;

--HOZZUNK LÉTRE EGY ÚJ MEZŐT A GROSS MÓDOSÍTÁSÁNAK
ALTER TABLE movie_db 
ADD COLUMN gross_corrected numeric;

UPDATE movie_db SET gross_corrected = TRIM(BOTH gross, '$M')::numeric
WHERE gross IS NOT NULL


SELECT count(1), movies FROM
	(SELECT movies, 
	 		year, 
	 		genre,
	 		one_line,
	 		stars,
	 		--MIN(rating) AS min_rating, 
	 		MAX(rating) AS max_rating, 
	 		--AVG(rating::numeric) AS avg_rating, 
	 		SUM(runtime::integer),
	 		SUM(gross_corrected) AS sum_gross
	 FROM movie_db
	 GROUP BY movies, year, genre, one_line, stars
	 ORDER BY movies, year, genre, one_line, stars) res
GROUP BY 2
HAVING count(1) > 1
--WHERE gross IS NOT NULL;

