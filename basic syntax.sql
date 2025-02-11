CREATE DATABASE tutorial ;
USE  tutorial ;

CREATE TABLE  IF NOT EXISTS  customers(
customer_id INT PRIMARY KEY ,
first_name VARCHAR(50) NOT NULL ,
last_name VARCHAR(50) NOT NULL ,
country VARCHAR(50)  ,
score INT )

CREATE TABLE  IF NOT EXISTS  orders(
order_id INT PRIMARY KEY ,
customer_id INT  ,
order_date  VARCHAR(50),
quantity INT )

INSERT INTO customers (customer_id, first_name ,last_name ,country ,score)
VALUES (1,"Maria","cramer","germany",350);
INSERT INTO customers (customer_id, first_name ,last_name ,country ,score)
VALUES (2,"john","steel","usa",900);
INSERT INTO customers (customer_id, first_name ,last_name ,country ,score)
VALUES (3,"georg","pippa","uk",750);
INSERT INTO customers (customer_id, first_name ,last_name ,country ,score)
VALUES (4,"Martin","muller","germany",500);
INSERT INTO customers (customer_id, first_name ,last_name ,country ,score)
VALUES (5,"peter","franken","usa",350);


INSERT INTO orders (order_id ,customer_id ,order_date,quantity)
VALUES (1001,1,2021-01-21,250);
INSERT INTO orders (order_id ,customer_id ,order_date,quantity)
VALUES (1002,2,2021-04-05,1150);
INSERT INTO orders (order_id ,customer_id ,order_date,quantity)
VALUES (1003,3,2021-06-16,500);
INSERT INTO orders (order_id ,customer_id ,order_date,quantity)
VALUES (1004,4,2021-08-31,750);
INSERT INTO orders (order_id ,customer_id ,order_date,quantity)
VALUES (1006,6,2021-08-30,650);

SELECT * 
FROM customers;
SELECT * 
FROM orders;

SELECT 
      first_name , 
      country 
FROM customers;

SELECT 
DISTINCT country 
FROM customers;
--- use order by 
SELECT *
FROM customers 
ORDER BY country  ASC,score  DESC ;

SELECT *
FROM customers 
ORDER BY 4 ASC,5 DESC ;

SELECT *
FROM customers 
WHERE country = "germany" ;

SELECT *
FROM customers 
WHERE score >=500 ;

--- comparison operator 
SELECT *
FROM customers 
WHERE score <=500 ;

SELECT * 
FROM customers
WHERE country != "germany";

--- logical operator 
SELECT * 
FROM customers
WHERE country ="germany"
AND   score <400; 

SELECT * 
FROM customers
WHERE country ="germany"
OR   score <400; 

SELECT * 
FROM customers
WHERE  NOT score <400; 
 
 --- BETWEEN 
 
SELECT * 
FROM customers
WHERE  score BETWEEN 100 AND 500;

SELECT * 
FROM customers
WHERE score >=100 AND score <=500 ;


--- IN
SELECT * 
FROM customers
WHERE  customer_id IN  (1,2,5) ;

SELECT * 
FROM customers
WHERE customer_id=1
OR customer_id=2
OR customer_id=5;

--- LIKE OPERATOR ( RETURN TRUE IF A VALUE MATCHES A PATTERN )

SELECT * 
FROM customers
WHERE first_name LIKE 'm%' ;

SELECT * 
FROM customers
WHERE first_name LIKE '%r%' ;

SELECT * 
FROM customers
WHERE first_name LIKE '__r%' ;

--- SQL JOINS 

--- INNER JOINS 
--- list customer ID ,first name , order id , quantity 
--- exclude the customers who have  not placed any orders 
SELECT 
     c.customer_id, -- always give from which table we have to select 
     c.first_name,
     o.order_id ,
     o.quantity 
FROM customers AS c 
INNER JOIN ORDERS AS o -- join type 
ON c.customer_id = o.customer_id ; -- join key 

-- LEFT JOIN 

SELECT 
     c.customer_id, -- always give from which table we have to select 
     c.first_name,
     o.order_id ,
     o.quantity 
FROM customers AS c 
LEFT JOIN ORDERS AS o -- join type 
ON c.customer_id = o.customer_id ; -- join key

SELECT 
     c.customer_id, -- always give from which table we have to select 
     c.first_name,
     o.order_id ,
     o.quantity 
FROM customers AS c 
RIGHT  JOIN ORDERS AS o -- join type 
ON c.customer_id = o.customer_id ; -- join key

-- FULL JOIN 
SELECT 
     c.customer_id, -- always give from which table we have to select 
     c.first_name,
     o.order_id ,
     o.quantity 
FROM customers AS c 
LEFT JOIN ORDERS AS o -- join type 
ON c.customer_id = o.customer_id  -- join key
UNION
SELECT 
     c.customer_id, -- always give from which table we have to select 
     c.first_name,
     o.order_id ,
     o.quantity 
FROM customers AS c 
RIGHT  JOIN ORDERS AS o -- join type 
ON c.customer_id = o.customer_id ; -- join key


 -- UNION 

CREATE TABLE  IF NOT EXISTS  employees(
first_name  VARCHAR(50),
last_name VARCHAR(50),
emp_country  VARCHAR(50))

INSERT INTO employees(first_name , last_name,emp_country )
VALUES ("john","steel","usa");
INSERT INTO employees(first_name , last_name,emp_country )
VALUES ("ann","labrune","france");
INSERT INTO employees(first_name , last_name,emp_country )
VALUES ("marie","bertrand","brazil");
INSERT INTO employees(first_name , last_name,emp_country )
VALUES ("georg","afonso","uk");
INSERT INTO employees(first_name , last_name,emp_country )
VALUES ("marie","steel","uk");


SELECT 
     first_name,
     last_name,
     country
FROM customers
UNION ALL 
SELECT 
      first_name,
     last_name,
     emp_country   
 FROM employees  
 
 
 SELECT 
     first_name,
     last_name,
     country
FROM customers
UNION  
SELECT 
      first_name,
     last_name,
     emp_country   
 FROM employees  
 
 -- SQL AGGREGATE FUNCTION 
 SELECT count(*) AS total_customers 
 FROM customers;
 
  SELECT sum(score) AS sum_score
 FROM customers;
 
   SELECT AVG(score) AS avg_score
 FROM customers;  -- nulls are ignored 
 
 SELECT MAX(score) AS MAX_score
 FROM customers;
 
  SELECT Min(score) AS Min_score
 FROM customers;
 
--  SQL STRING FUNCTION 

--CONCAT
SELECT 
CONCAT(first_name,'-',last_name) AS customer_name
FROM customers; 

--uppercase --lowercase 

SELECT 
UPPER(first_name) AS upper_first_name,
LOWER(last_name) AS lower_last_name
FROM customers;

SELECT 
TRIM(last_name) AS clean_last_name
FROM customers;

SELECT 
TRIM(last_name) AS clean_last_name,
LENGTH(last_name) AS LEN_last_name
FROM customers;

--SUBSTRING
SELECT 
last_name,
SUBSTRING(last_name,2,3) as sub_last_name
FROM customers;


-- group by (group rows based on column values )


SELECT 
     COUNT(*) AS total_customers,
     country
FROM customers
GROUP BY country ;

SELECT 
     COUNT(*) AS total_customers,
     country
FROM customers
GROUP BY country 
ORDER BY COUNT(*) ASC;

 SELECT 
      MAX(score) AS max_score,
      country 
FROM customers
GROUP BY country ;


--HAVING CLAUSE (filters the groups returned by group by )

SELECT 
      COUNT(*) AS total_customers,
      country 
FROM customers 
GROUP BY country 
HAVING COUNT(*) > 1 ;

 --having works with group by and where can works with column
 --having is used to filter aggregate function whereas  where is used to filter column 
 
 
 
 
 --subquery (IN , EXISTS)
 
 find all orders placed from customers whose score highter than 500 using the customerID
 -- IN 
SELECT * 
FROM orders
WHERE customer_id 
IN 
(SELECT customer_id 
FROM customers 
WHERE score > 500 )

-- EXISTS 
 
 SELECT * 
 FROM orders AS o 
 WHERE EXISTS (
 SELECT 1 
 FROM customers AS c 
 WHERE c.customer_id= o.customer_id   -- do like join in exists 
 AND score> 500
 )
 
 DESCRIBE customers;
 
 
 UPDATE customers 
 SET country= "germany"
 WHERE customer_id = 5
 
UPDATE customers 
SET score =1000,
     country ="usa"
WHERE customer_id = 5
 
DELETE FROM customers 
WHERE customer_id=5 
 
 DELETE FROM customers 
WHERE customer_id IN (5,6)

TRUNCATE employees;

ALTER TABLE customers
ADD email VARCHAR(15);

DROP TABLE employees;
 