-- TYPES OF SQL COMMANDS
-- DDL 
CREATE DATABASE IF NOT EXISTS keshav1;
USE  keshav1;
CREATE TABLE IF NOT EXISTS users(
           user_id INT,
           name_ VARCHAR(70),
           email_id VARCHAR(70),
		   password_ VARCHAR(70)
)

-- TRUNCATE
-- DROP 


-- CONSTRAINT IN MY SQL 
-NOT NULL 
-UNIQUE 
-PRIMARY KEY 
-AUTO INCREMENT 
-CHECK
-DEFAULT 
-FOREIGN KEY 

CREATE TABLE IF NOT EXISTS users1(
           user_id INT NOT NULL UNIQUE,
           name_ VARCHAR(70) NOT NULL ,
           email_id VARCHAR(70) UNIQUE,
		   password_ VARCHAR(70)
           )

CREATE TABLE IF NOT EXISTS users2(
           user_id INT NOT NULL UNIQUE,
           name_ VARCHAR(70) NOT NULL ,
           email_id VARCHAR(70) UNIQUE,
		   password_ VARCHAR(70)
           )
 CREATE TABLE IF NOT EXISTS users3(
           user_id INT  ,
           name_ VARCHAR(70)  ,
           email_id VARCHAR(70) ,
		   password_ VARCHAR(70),
 CONSTRAINT users3_email_id_unique UNIQUE (name_ ,email_id)    
 CONSTRAINT users3_pk PRIMARY KEY (user_id) 
     )

 CREATE TABLE IF NOT EXISTS users4(
           user_id INT  AUTO_INCREMENT,
           name_ VARCHAR(70)  ,
           email_id VARCHAR(70) ,
		   password_ VARCHAR(70),
 CONSTRAINT users4_email_id_unique UNIQUE (name_ ,email_id) ,   
  CONSTRAINT users4_pk PRIMARY KEY (user_id)
     )
this above method of applying constraint  help to delete constraint later

CREATE TABLE IF NOT EXISTS students(
   student_id INT PRIMARY KEY AUTO_INCREMENT ,
   name_ VARCHAR(50) NOT NULL,
   age INT ,
   CONSTRAINT students_age_check CHECK (age >6 AND age<25)
    )
INSERT INTO 
students (student_id , name_ , age) 
VALUES
(1, "tyagi" ,15)

CREATE TABLE IF NOT EXISTS ticket (
ticket_id INT PRIMARY KEY ,
name_ varchar(50),
order_time DATETIME DEFAULT CURRENT_TIMESTAMP ) ;

INSERT INTO ticket ( ticket_id ,name_)
VALUES
(1, "tyagi") ;


CREATE TABLE customers(
cid INT PRIMARY KEY AUTO_INCREMENT ,
name_ VARCHAR(50) NOT NULL ,
emai_id VARCHAR(50) NOT NULL UNIQUE );

CREATE TABLE orders(
order_id INT PRIMARY KEY AUTO_INCREMENT ,
cid INT NOT NULL ,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT ordes_fk FOREIGN KEY (cid) REFERENCES customers(cid) 
  );
-- REFERECE ACTION   
  -- RESTRICT 
  -- CASCADE 
 -- SET NULL 
 -- SET DEFAULT 
 DROP TABLE 
 orders;
 CREATE TABLE orders(
order_id INT PRIMARY KEY AUTO_INCREMENT ,
cid INT NOT NULL ,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT ordes_fk FOREIGN KEY (cid) REFERENCES customers(cid)
ON DELETE CASCADE 
ON UPDATE CASCADE  
  );
   DROP TABLE 
 orders;
  CREATE TABLE orders(
order_id INT PRIMARY KEY AUTO_INCREMENT ,
cid INT  ,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT ordes_fk FOREIGN KEY (cid) REFERENCES customers(cid)
ON DELETE SET NULL 
ON UPDATE SET NULL 
  );
  
  