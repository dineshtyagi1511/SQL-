CREATE DATABASE IF NOT EXISTS keshav_joins;
select * 
FROM  membership;

SELECT * 
FROM  keshav_joins.groups;

SELECT *
FROM keshav_joins.users AS u
CROSS JOIN keshav_joins.groups AS g ;

SELECT *
FROM keshav_joins.users1;
select * 
FROM  membership;

SELECT 
      u.user_id,
      u.name, 
      u.age,
      u.emergency_contact,
      m.membership_id
FROM keshav_joins.users1 AS u 
INNER JOIN membership AS m
ON u.user_id = m.user_id;

SELECT * 
FROM membership AS m
LEFT JOIN keshav_joins.users1 AS u 
ON m.user_id = u.user_id;

SELECT * 
FROM membership AS m
RIGHT JOIN keshav_joins.users1 AS u 
ON m.user_id = u.user_id;

-- UNION 
-- UNION ALL 
-- INTERSECT 
-- EXCEPT 

-- SELF JOIN 

SELECT * 
FROM keshav_joins.users1 AS t1 
JOIN keshav_joins.users1 AS t2
ON t1.emergency_contact = t2.user_id;


-- multiple join 

SELECT * 
FROM students AS s 
JOIN class AS c
ON s.class_id = c.class_id 
AND s.enrollment_year = c.class_year;


-- join on multiple table 

CREATE DATABASE IF NOT EXISTS flipkart;
SELECT * 
FROM users;

USE flipkart;

-- order_details + name_

SELECT *
FROM order_details AS t1
JOIN orders AS t2 
ON t1.order_id = t2.order_id 
JOIN users AS t3 
ON t2.user_id = t3.user_id ;


