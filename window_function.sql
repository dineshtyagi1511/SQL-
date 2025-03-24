-- WINDOW FUNCTION 
-- GROUP BY VS WINDOW FUNCTION

CREATE DATABASE IF NOT EXISTS window_function ;
USE window_function;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

SELECT * 
FROM marks;

SELECT * ,
      ROUND(AVG(marks) OVER(PARTITION BY branch),2)
FROM marks;

SELECT branch,
       AVG(marks) 
FROM marks
GROUP BY branch;

SELECT * ,
MIN(marks) OVER(),
MAX(marks) OVER(PARTITION BY branch )
FROM marks;

-- FIND ALL THE STUDENTS WHO HAVE MARKS HIGHER THAN 
-- THE AVG MARKS OF THEIR RESPECTIVE BRANCH ??
SELECT * FROM (SELECT *,
      AVG(marks) OVER(PARTITION BY branch) AS "branch_avg"
	  FROM marks) AS t 
WHERE t.marks > t.branch_avg ;

-- RANK/DENSE_RANK/ROW_NUMBER

SELECT *,
        RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
        DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

SELECT *,
   CONCAT(branch,'-',ROW_NUMBER() OVER(PARTITION BY branch))      
FROM marks;

-- Q1 
USE zomato ;

SELECT * 
FROM (SELECT 
        MONTHNAME(date) AS "MONTH",
        user_id ,
        SUM(amount) AS "TOTAL" ,
        RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) AS "RANK_MONTH"
	FROM orders 
    GROUP BY MONTHNAME(date),user_id ) t 
WHERE t.rank_month < 3
ORDER BY month DESC, rank_month ASC;

-- FIRST_VALUE / LAST_VALUE / NTH_VALUE 
USE window_function ;
SELECT *,
       FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS "topper"
FROM marks ;

SELECT *,
       LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) 
FROM marks ;


SELECT *,
       NTH_VALUE(NAME,2) OVER(PARTITION BY branch ORDER BY marks DESC
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) 
FROM marks ;

-- Q1 
SELECT name, branch, marks FROM (SELECT *,
       FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS "topper_name",
       FIRST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC)AS "topper_marks"
	   FROM marks ) t
WHERE t.name =t.topper_name AND t.marks =t.topper_marks;

-- Q2 

SELECT name, branch, marks FROM (SELECT *,
       LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "last_name",
       LAST_VALUE(marks) OVER(PARTITION BY branch ORDER BY marks DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)AS "last_marks"
	   FROM marks ) t
WHERE t.name =t.last_name AND t.marks =t.last_marks;


-- Q4
 SELECT name, branch, marks FROM (SELECT *,
       LAST_VALUE(name) OVER w AS "last_name",
       LAST_VALUE(marks) OVER w AS "last_marks"
	   FROM marks ) t
WHERE t.name =t.last_name AND t.marks =t.last_marks
WINDOW w AS (PARTITION BY branch ORDER BY marks DESC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);


-- LEAD /LAG 

USE window_function;
SELECT * ,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks ;

USE zomato;
SELECT * 
FROM orders ;

SELECT MONTH(date) , 
         SUM(amount) ,
        ((SUM(AMOUNT)-LAG(SUM(amount)) OVER(ORDER BY MONTH(date)))/SUM(AMOUNT))*100 AS"GROWTH_PERCENTAGE"
FROM orders 
GROUP BY MONTH(date);

CREATE DATABASE IF NOT EXISTS ipl;
USE ipl;
-- SELECT TOP 5 BATSMAN FROM EACH TEAM 
-- ranking 
SELECT * FROM ( SELECT BattingTeam,
              batter, 
              SUM(batsman_run) AS "total_runs",
              DENSE_RANK() OVER(PARTITION BY BattingTeam ORDER BY SUM(batsman_run) DESC ) AS "rank_within_team"
              FROM matches
              GROUP BY BattingTeam , batter ) AS t 
WHERE t.rank_within_team < 6
ORDER BY t.BattingTeam,t.rank_within_team;


-- CUMULATIVE SUM
-- virat kholi carrer run after 50th ,100th ,200th match 
SELECT * 
FROM (SELECT 
      CONCAT("MATCH:",ROW_NUMBER() OVER(ORDER BY ID)) AS "match_no",
	  SUM(batsman_run) AS "runs_scored",
	  SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS "carrer_run" 
	  FROM matches 
	  WHERE batter = 'V Kohli'
	  GROUP BY ID) t
WHERE t.match_no = 'MATCH:50' OR t.match_no = 'MATCH:100' OR t.match_no = 'MATCH:200';


-- CUMULATIVE AVERAGE 
SELECT * 
FROM (SELECT 
      CONCAT("MATCH:",ROW_NUMBER() OVER(ORDER BY ID)) AS "match_no",
	  SUM(batsman_run) AS "runs_scored",
	  SUM(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS "carrer_run",
      AVG(SUM(batsman_run)) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS "carrer_AVG"
	  FROM matches 
	  WHERE batter = 'V Kohli'
	  GROUP BY ID) t
WHERE t.match_no = 'MATCH:50' OR t.match_no = 'MATCH:100' OR t.match_no = 'MATCH:200';

-- ANOTHER WAY TO WRITE WINDOW FUNCTION 
SELECT * 
FROM (SELECT 
      CONCAT("MATCH:",ROW_NUMBER() OVER(ORDER BY ID)) AS "match_no",
	  SUM(batsman_run) AS "runs_scored",
	  SUM(SUM(batsman_run)) OVER w AS "carrer_run",
      AVG(SUM(batsman_run)) OVER w AS "carrer_AVG"
	  FROM matches 
	  WHERE batter = 'V Kohli'
	  GROUP BY ID
      WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) ) t;
	
-- RolliNG AVERAGE  OR moving average 

--  rolling average (also known as a moving average)
-- a rolling average calculates the average over a specific window of rows (e.g., the last 3 matches, last 5 matches, etc.).

SELECT * 
FROM (SELECT 
      CONCAT("MATCH:",ROW_NUMBER() OVER(ORDER BY ID)) AS "match_no",
	  SUM(batsman_run) AS "runs_scored",
	  SUM(SUM(batsman_run)) OVER w AS "carrer_run",
      AVG(SUM(batsman_run)) OVER w AS "carrer_AVG",
	  AVG(SUM(batsman_run)) OVER (ROWS BETWEEN  9 PRECEDING AND CURRENT ROW ) AS "rolling _AVG"
	  FROM matches 
	  WHERE batter = 'V Kohli'
	  GROUP BY ID
      WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) ) t;


SELECT 
    CONCAT('MATCH:', ROW_NUMBER() OVER (ORDER BY ID)) AS match_no,
    SUM(batsman_run) AS runs_scored,
    SUM(SUM(batsman_run)) OVER w AS career_run,
    AVG(SUM(batsman_run)) OVER w AS career_avg,
    AVG(SUM(batsman_run)) OVER (ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM matches
WHERE batter = 'V Kohli'
GROUP BY ID
WINDOW w AS (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);

-- PERCENT OF TOTAL 
USE zomato;
SELECT f_name,
(total_value/SUM(total_value) OVER())*100 AS 'percent_of_total'
FROM (SELECT f_id ,SUM(amount) AS 'total_value' FROM orders t1 
JOIN order_details t2 
ON t1.order_id = t2.order_id 
WHERE r_id = 2
GROUP BY f_id) t 
JOIN food t3 
ON t.f_id = t3.f_id 
ORDER BY 'percent_of_total' DESC  ;


-- PERCENT CHANGE 
-- PERCENT CHANGE =((NEW_VALUE-OLD_VALUE)/OLD_VALUE)*100 
SELECT YEAR(Date),QUARTER(Date),SUM(views) AS 'views',
((SUM(views) - LAG(SUM(views)) OVER(ORDER BY YEAR(Date),QUARTER(Date)))/LAG(SUM(views)) OVER(ORDER BY YEAR(Date),QUARTER(Date)))*100 AS 'Percent_change'
FROM youtube_views
GROUP BY YEAR(Date),QUARTER(Date)
ORDER BY YEAR(Date),QUARTER(Date);


SELECT *,
((Views - LAG(Views,7) OVER(ORDER BY Date))/LAG(Views,7) OVER(ORDER BY Date))*100 AS 'weekly_percent_change'
FROM youtube_views;


-- percent and quantiles 

-- Q1 FIND THE MEDIAN MARKS OF ALL THE STUDENTS ?
-- Q2 FIND BRANCH WISE MEDIAN OF STUDENT MARKS 

-- median 
USE window_function ;
SELECT * 
FROM marks;
SELECT *,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks',
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY marks) OVER(PARTITION BY branch) AS 'median_marks_cont'
FROM marks;



SELECT * FROM (SELECT *,
PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY marks) OVER() AS 'Q1',
PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY marks) OVER() AS 'Q3'
FROM marks) t
WHERE t.marks <= t.Q1 - (1.5*(t.Q3 - t.Q1));


-- SEGMENTATION USING NTILE 
SELECT *,
NTILE(3) OVER(ORDER BY marks DESC) AS 'buckets'
FROM marks;

USE keshav1;
SELECT brand_name,model,price, 
CASE  -- CASE IS LIKE (IF STATEMENT)  IN SQL 
	WHEN bucket = 1 THEN 'budget'
    WHEN bucket = 2 THEN 'mid-range'
    WHEN bucket = 3 THEN 'premium'
END AS 'phone_type'
FROM (SELECT brand_name,model,price,
NTILE(3) OVER(PARTITION BY brand_name ORDER BY price) AS 'bucket' 
FROM smartphones) t;

-- CUMULATIVE DISTRIBUTION 
SELECT * FROM (SELECT *,
CUME_DIST() OVER(ORDER BY marks) AS 'Percentile_Score'
FROM marks) t
WHERE t.Percentile_Score > 0.90;





