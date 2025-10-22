#create a table

create database affiliates;
use affiliates;

#drop database affiliates

#create a table employees; id, name, dept

create table employees (
employee_id int ,
name varchar(100),
department varchar (100)
);

#populate the table
insert into employees (employee_id,name,department)
values
(001, "Alice", "Mathematics"),
(002, "Jane", "English"),
(003, "Lucy", "Science");

select * from employees;
select name from employees;

#amend table
alter table employees
add column age int;

update employees
set age = 23
where employee_id = 001;

set SQL_SAFE_UPDATES = 0


