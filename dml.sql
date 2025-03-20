-- DML 
USE keshav1;
CREATE TABLE IF NOT EXISTS users5(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name_ VARCHAR(50) NOT NULL ,
    email VARCHAR(50) NOT NULL UNIQUE ,
    password_ VARCHAR(50) NOT NULL
    );

INSERT INTO users5 (user_id,name_,email ,password_)
VALUES (NULL, "keshav","keshav123@gmail.com","tyagi123@")

INSERT INTO users5 (user_id,name_,email ,password_)
VALUES (NULL, "urvashi","urvashi123@gmail.com","tyagi1234@");
    
SELECT * 
FROM users5 ;

select * 
from smartphones 
WHERE 1;

SELECT 
      model AS md,
	  price , 
      rating 
FROM smartphones;

SELECT 
      model,
      SQRT(resolution_width*resolution_width +resolution_height*resolution_height)/screen_size AS "PPI"
FROM smartphones ;   
   
   
SELECT 
      model ,
      rating/10
FROM smartphones;

SELECT 
      model,
      "SMARTPHONE" AS "TYPE"
FROM smartphones;

SELECT 
DISTINCT(brand_name) AS "ALL BRANDS"
FROM smartphones;

SELECT 
DISTINCT(os) AS "ALL BRANDS"
FROM smartphones;

SELECT 
DISTINCT brand_name, processor_brand 
FROM smartphones;

-- WHERE CLAUSE 

SELECT * 
FROM smartphones 
WHERE brand_name= "samsung"; 

SELECT * 
FROM smartphones 
WHERE price > 50000;

SELECT * 
FROM smartphones 
WHERE price < 25000 AND rating > 80;

SELECT DISTINCT brand_name 
FROM smartphones
WHERE price > 20000;

-- IN AND NOT IN 

SELECT * 
FROM smartphones 
WHERE processor_brand IN ( "snapdragon","bionic");

SELECT * 
FROM smartphones 
WHERE processor_brand NOT IN ( "snapdragon","bionic");


-- UPDATE 

SELECT * 
FROM smartphones
WHERE  processor_brand = "mediatek";

UPDATE smartphones
SET processor_brand = "dimensity "
WHERE processor_brand = "mediatek";

UPDATE users5
SET email = "tyagi123@gmail.com" , password_ = "123"
WHERE user_id =1 ;

SELECT * 
FROM users5;

-- DELETE
 
DELETE 
FROM smartphones
WHERE price > 200000;

SELECT * 
FROM smartphones
WHERE primary_camera_rear >100 AND brand_name = "samsung";

DELETE 
FROM smartphones
WHERE primary_camera_rear >100 AND brand_name = "samsung";

--  FUNCTION 
-- AGRREGATE FUNCTION 


--MAX/MIN 

SELECT MAX(price) 
FROM smartphones;


