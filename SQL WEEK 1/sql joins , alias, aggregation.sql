use classicmodels;

# aliasing using as

select customerNumber as Number, city as City
from customers; 

#wild cards
#select customer names that start with mini

select *
from customers
where customerName lIKE "Mini%";

select *
from customers
where customerName like "%nad%";

#start with a c end with n
select*
from customers
where customerName like "c%d";

#match exactly x characters m,4,d
select*
from customers
where customerName like "m__d";

#case sensitive selection
select *
from customers
where customerName like binary "%v%";

#case statement
