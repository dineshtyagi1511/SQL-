-- SUBQUERY 

CREATE DATABASE IF NOT EXISTS subquery;
USE subquery;
SELECT * 
FROM movies;

SELECT * 
FROM movies 
WHERE score = (SELECT 
                     MAX(score) 
			   FROM movies);
               
-- INDEPENDENT SUBQUERY -SCALER SUBQUERY 

-- Q1 
SELECT * 
FROM movies 
WHERE gross-budget  =(SELECT MAX(gross-budget ) AS "profit" 
                       FROM movies);
-- Q2                       
SELECT * 
FROM movies 
WHERE score >(SELECT AVG(score) 
              FROM movies);                      

             
SELECT count(*) 
FROM movies 
WHERE score >(SELECT AVG(score) 
              FROM movies); 
-- Q3 
SELECT * 
FROM movies 
WHERE score =(SELECT MAX(score) from movies WHERE year ="2000") AND year  =2000 ;


-- FIND THE HIGHEST RATED MOVIE AMONG ALL MOVIES WHOSE NO OF VOTERS ARE > THE DATASET AVG VOTES 
SELECT *
FROM movies
WHERE votes >(SELECT AVG(votes) 
               FROM movies) 
ORDER BY score DESC LIMIT 1;

-- OR 
SELECT * 
FROM movies 
WHERE score=(SELECT MAX(score)
			FROM movies
			WHERE votes >(SELECT AVG(votes) 
                          FROM movies));
				
							
CREATE DATABASE IF NOT EXISTS zomato;                
Use zomato;

SELECT * 
FROM users ;
SELECT * 
FROM orders;

SELECT * 
FROM users 
WHERE user_id NOT IN ( SELECT DISTINCT o.user_id 
                       FROM users AS u 
                       INNER JOIN orders AS  O 
                       ON u.user_id = o.user_id);
                       
-- FIND ALL THE MOVIES MADE BY TOP 3 DIRECTORS (IN TERM OF TOTAL GROSS INCOME )

USE subquery;
SELECT *
FROM movies 
WHERE director IN ( SELECT director
                   FROM movies 
				   GROUP BY director 
				   ORDER BY SUM(gross) DESC LIMIT 3 );
-- USING CTE 
WITH top_director AS (SELECT director
                   FROM movies 
				   GROUP BY director 
				   ORDER BY SUM(gross) DESC LIMIT 3)
SELECT * FROM movies 
WHERE director IN (SELECT * FROM top_director);

-- Q3 
USE subquery ;
SELECT *
FROM movies 
WHERE star IN (SELECT star
               FROM  movies 
               where votes >25000
               GROUP BY star 
               HAVING AVG(score) >8.5)
AND votes > 25000 ;

-- Q1
SELECT * 
FROM movies 
WHERE (year,gross-budget ) IN (SELECT year , MAX(gross-budget)
                                FROM movies 
                                GROUP BY year );
-- Q2
SELECT * 
FROM movies 
where (genre ,score ) IN (SELECT genre , MAX(score)
                          FROM movies
                          WHERE votes >25000
                          GROUP BY genre)
AND votes >25000; 

-- Q3
WITH top_duos AS (
SELECT star,director,MAX(gross) 
FROM movies 
GROUP BY star , director  
ORDER by SUM(gross)  DESC LIMIT 5 )
SELECT * FROM MOVIES 
WHERE (star,director,gross) IN (SELECT * FROM top_duos); 

-- CORRELATED SUBQUERY                        
-- Q1
 USE subquery;
SELECT *
FROM movies m1 
WHERE score > (SELECT AVG(score) FROM movies m2 WHERE m2.genre =m1.genre);

-- Q2 
USE zomato;

WITH fav_food AS (
    SELECT t2.user_id ,name ,f_name ,COUNT(*) AS "frequency"
    FROM users t1 
    JOIN orders t2 ON  t1.user_id = t2.user_id 
    JOIN order_details t3 ON t2.order_id = t3.order_id 
	JOIN food t4 ON t3.f_id = t4.f_id 
    GROUP BY t2.user_id, t3.f_id)

SELECT * FROM fav_food f1
WHERE frequency = (SELECT MAX(frequency)
                   FROM fav_food f2 
                   where f2.user_id =f1.user_id);
                   
                   
WITH fav_food AS (
    SELECT t2.user_id, name AS user_name, t4.f_name AS food_name, COUNT(*) AS frequency
    FROM users t1 
    JOIN orders t2 ON t1.user_id = t2.user_id 
    JOIN order_details t3 ON t2.order_id = t3.order_id 
    JOIN food t4 ON t3.f_id = t4.f_id 
    GROUP BY t2.user_id, t3.f_id
)
SELECT user_id, user_name, food_name, frequency
FROM fav_food f1
WHERE frequency = (SELECT MAX(frequency)
                   FROM fav_food f2 
                   WHERE f2.user_id = f1.user_id);

-- Usage with select 
USE subquery;
-- Q1
SELECT name ,(votes/(SELECT SUM(votes) FROM movies))*100 FROM movies ;

-- Q2 
SELECT name , genre ,score, (SELECT AVG(score) FROM movies m2 WHERE m2.genre =m1.genre)
FROM movies m1 ;

-- usage with from 
-- Q1 
USE zomato;
SELECT r_name,avg_rating 
FROM (SELECT r_id ,avg(restaurant_rating)  AS "avg_rating"
      FROM orders 
      GROUP BY r_id) t1
JOIN restaurants t2 
ON t1.r_id =t2.r_id ;


-- usage with having 
-- Q1
USE subquery;
SELECT genre ,avg(score)
FROM movies 
GROUP BY genre 
HAVING AVG(SCORE)> (select AVG(score) FROM movies );

-- usage with insert 






                   

                   
                   
