USE keshav1;
-- GROUPING AND SORTING 
-- SORTING 

SELECT 
      model,
      screen_size
FROM smartphones 
WHERE brand_name = "samsung"
ORDER BY screen_size DESC limit 5 ;


SELECT * 
FROM smartphones;

SELECT 
      model,
      num_rear_cameras + num_front_cameras AS total_camera
FROM smartphones
ORDER BY total_camera DESC;

SELECT 
      model,
      ROUND(SQRT(resolution_width*resolution_width +resolution_height*resolution_height)/screen_size) AS "PPI"
FROM smartphones 
ORDER BY "PPI" DESC ; 
SELECT 
     model,
     battery_capacity
FROM smartphones 
ORDER BY battery_capacity DESC LIMIT 4,1 ; -- important 

SELECT 
     model,
     battery_capacity
FROM smartphones 
ORDER BY battery_capacity ASC LIMIT 4,1 ;


SELECT 
      brand_name,
      model,
      rating
FROM smartphones 
WHERE brand_name= "apple"
ORDER BY rating ASC LIMIT 1;

SELECT *
FROM smartphones
ORDER BY brand_name ASC , price ASC ;

SELECT *
FROM smartphones
ORDER BY brand_name ASC , rating DESC ;

-- GROUPING 
-- ( use on the bases of categorical data)
 
 SELECT 
       brand_name ,
       count(*) AS "num_phones"
 FROM smartphones
 GROUP BY brand_name
 ORDER BY num_phones DESC ;

 SELECT 
       brand_name ,
       count(*) AS "num_phones",
       ROUND(AVG(price)) AS "avg_price",
       MAX(rating) AS "max_rating",
       ROUND(AVG(screen_size),2) AS "avg_screen_size",
	   ROUND(AVG(battery_capacity),2) AS "avg_battery_capacity"
 FROM smartphones
 GROUP BY brand_name
 ORDER BY num_phones DESC ;
 
-- ( WHERE FOR SELECT IS SAME AS HAVING FOR GROUP BY )
 
SELECT 
      has_nfc,
      AVG(price) AS "avg_price",
      ROUND(AVG(rating),2) AS "avg_rating"
FROM smartphones 
GROUP BY has_nfc ;

-- (GROUP BY ON MULTIPLE COLUMNS )      

SELECT 
      brand_name,
      processor_brand,
      count(model),
      ROUND(AVG(primary_camera_rear),2)
FROM smartphones
GROUP BY brand_name ,processor_brand
ORDER BY brand_name ASC  ;

SELECT
     brand_name,
     AVG(price) AS "AVG_PRICE"
FROM smartphones 
GROUP BY brand_name 
ORDER BY AVG_PRICE DESC LIMIT 5 ; 
 
SELECT
     brand_name,
     AVG(screen_size) AS "avg_screen_size"
FROM smartphones 
GROUP BY brand_name 
ORDER BY avg_screen_size  ASC LIMIT 1 ; 

SELECT 
      has_5g,
	  ROUND(AVG(price),2) AS "AVG_PRICE"
FROM smartphones 
GROUP BY  has_5g; 

-- group smartphones by the brand and find the brand with 
-- the highest no of models that have both NFC and an IR BLASTER  
SELECT 
	   brand_name ,
	   COUNT(*) AS "COUNT"
FROM smartphones 
WHERE has_nfc = "True" AND has_ir_blaster = "True" 
GROUP BY brand_name 
ORDER BY COUNT  DESC LIMIT 10 ;

SELECT  
      has_nfc,
      ROUND(avg(price))
FROM smartphones
WHERE brand_name = "samsung" AND has_5g ='True'
GROUP BY has_nfc;


SELECT 
      model,
      price 
FROM smartphones 
ORDER BY price DESC LIMIT 1 ;

-- ( WHERE FOR SELECT IS SAME AS HAVING FOR GROUP BY )


SELECT 
      brand_name,
	  COUNT(*) AS "COUNT",
      AVG(price) AS "avg_price"
FROM smartphones 
GROUP BY brand_name 
HAVING  COUNT > 20 
ORDER BY avg_price DESC ; 

SELECT 
      brand_name ,
      COUNT(*) AS "COUNT",
      ROUND(AVG(rating),2) AS "avg_rating"
FROM smartphones 
GROUP BY brand_name 
HAVING COUNT > 20 ;

SELECT 
      brand_name,
      COUNT(*) AS "COUNT",
      AVG(ram_capacity) AS "ram_capacity_avg"
FROM smartphones 
WHERE  fast_charging_available = 1 AND refresh_rate > 90  
GROUP BY  brand_name
HAVING COUNT > 10
ORDER BY ram_capacity_avg DESC LIMIT 3 ; 
SELECT *
FROM smartphones;

SELECT 
      brand_name ,
      ROUND(AVG(price),2) AS "avg_price"
FROM smartphones 
WHERE   has_5g ='True' 
GROUP BY brand_name 
HAVING COUNT(*) > 10 AND AVG(rating) > 70   ;
      
-- HAVING GENERALLY INVOLVES AGGREGATE FILTERNING 
-- WHEREAS WHERE DON'T   


-- WHERE USED TO FILTER IN ROWS 
-- AND HAVING USED TO FILTER IN GROUP BY ON THE BASES OF AGGREGATE FUNCTION 



