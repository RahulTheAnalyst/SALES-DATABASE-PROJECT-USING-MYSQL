-- CREATING DATABASE FOR SALES PROJECT
Create database SalesProject;
use SalesProject;

-- CREATING SALES TABLE WITH DETIALS OF SALES IN DIFFERENT TIME OF VARIOUS PRODUCT
CREATE TABLE sales 
(
id INT,
city_id VARCHAR(32),
product VARCHAR(32),
Month1 INT,
Year1 INT,
value1 INT
);

-- INSERTING VALUES OF SALES OF DIFFERENT PRODUCT
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (1,1,"P1",1,2021,400);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (2,2,"P2",1,2021,500); 
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (3,3,"P3",1,2021,600);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (1,1,"P1",2,2021,450);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (2,2,"P2",2,2021,550); 
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (3,3,"P3",2,2021,650);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (4,4,"P1",1,2021,700);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (4,4,"P2", 1,2021,800);
INSERT INTO sales (id,city_id,product,Month1,Year1,value1) VALUES (4,4,"P3",2,2021,800);

-- CREATING EMPLOYEES TABLE WITH DETIALS OF EMPLOYEES IN DIFFERENT TIME 
CREATE TABLE employee 
( 
emp_id INT, 
city_id VARCHAR(32),
Emp_name VARCHAR(32), 
Month1 INT,
Year1 INT,
manager_id INT
);

-- INSERTING VALUES OF DIFFERENT EMPLOYEES
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (1,1, "E2", 1,2021,13); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (2,1,"E1",1,2021,13); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (3,1,"E3", 1,2021,13);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (4,3, "E4", 1,2021,14); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (5,3,"E5", 1,2021,14);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (6,2, "E6", 1,2021,15);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (1,3, "E2", 1,2021,14);  
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (7,1, "E2",2,2021,13);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (8,1,"E1",2,2021,13);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (10,3,"E4",2,2021,14);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (11,3,"E5",2,2021,14); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (12,2, "E6",2,2021,15);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (9,2, "E3",2,2021,15); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (13,1, "M1",1,2021,NULL);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (14,2, "M2",1,2021,NULL);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (15,3, "M3",1,2021,NULL);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (13,1, "M1",2,2021,NULL); 
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (14,2,"M2",2,2021,NULL);
INSERT INTO employee (emp_id,city_id,Emp_name,Month1,Year1,manager_id) VALUES (15,3, "M3",2,2021,NULL); 


-- CREATING CITY TABLE WITH DETIALS OF VARIOUS CITY
CREATE TABLE city (
id INT,
city_name VARCHAR(32) );

INSERT INTO city (id,city_name) VALUES (1,"Mumbai");
INSERT INTO city (id,city_name) VALUES (2,"Delhi");
INSERT INTO city (id,city_name) VALUES (3,"Pune");
INSERT INTO city (id,city_name) VALUES (4,"Bangalore");
INSERT INTO city (id,city_name) VALUES (5,"chennai");

-- QUERY-1
-- Find top 2 highest selling product and their total value 
-- output columns=># | value

select product,value1 
from sales
group by product
order by product desc
limit 2;

-- QUERY-2
-- Find city wise, month wise total sales in descending order of sales
-- output columns=># city_id | city_name | Month | Year | Total_Sales

select sales.city_id,city.city_name,sales.Month1,sales.Year1,sales.value1 as total_sales
from sales
inner join city
on sales.city_id = city.id
order by sales.value1 desc;

select s.city_id,c.city_name,s.Month1,s.Year1,s.value1 as total_sales
from sales s
inner join city c
on s.city_id = c.id
order by s.value1 desc;

-- QUERY-3
-- employee wise total sales of each month and year excluding the manager 
-- output columns=># employee_id | total_sales

select employee.emp_id as employee_id,Sum(sales.value1) as total_sales
from employee
inner join sales
on employee.city_id = sales.city_id
where employee.manager_id != "null"
group by employee.emp_id
order by sales.value1 desc;

select e.emp_id as employee_id,Sum(s.value1) as total_sales
from employee e
inner join sales s
on e.city_id = s.city_id
where e.manager_id != "null"
group by e.emp_id
order by s.value1 desc;

-- QUERY-4
-- Find cities with no employees for given months
-- output columns=># city_id | city_name

Select id,city_name from city where id not in(Select s.city_id from sales s join (Select city_id, count(emp_id) 
From employee 
Group by city_id) k
On k.city_id = s.city_id);


-- QUERY-5
-- # Find cities with no sales                                                                                                                            
-- #output columns#city_name # constraints : do not use  any join

Select city_name from city where id not in(select city_id 
From sales
Group by city_id
Having sum(value1) >0);

-- QUERY-6
-- # find manager wise, city wise sales of each product for each month  	                                                                 
--  # output columns #manger_name | city_id | product | month | year | total_sales

select e.Emp_name,s.city_id,s.product,s.Month1,s.Year1,Sum(s.value1) as total_sales
from employee e
inner join sales s
on e.city_id = s.city_id
where e.manager_id is null
group by e.Emp_name
order by s.value1 desc;

select e.manager_id,e.city_id,
s.product,e.month1,
e.year1,sum(s.value1) as total_sales
from employee e 
join sales s
	on e.city_id=s.city_id
	and e.Month1=s.Month1
	and e.Year1=s.Year1
group by e.manager_id;
