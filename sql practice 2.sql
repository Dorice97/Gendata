#Filtering output
# use of WHERE "allows filter of items that meet a certain condition ie; specific columns"

use ABC_DATA

SELECT * 
FROM customers
WHERE first_name = "john" ;

# WHERE---IN "pass in more than one condition"

select * from customers
where first_name IN ("john", "bob", "Eva", "George");

# WHERE---IN---AND ; based on more than one column

select * from customers
WHERE first_name IN ("john", "bob", "Eva", "George") AND customer_id < 5;


# WHERE --- OR if either  of the conditions are met

select * from customers
where (first_name = "John" or last_name = "Fisher");

# WHERE ---- BETWEEN---AND ; range condition ;handles floats and integers

SELECT * FROM product
WHERE price BETWEEN 30 AND 80;

# WHERE---OR---AND
SELECT * FROM product
WHERE (item_name = 'Product B' OR item_name = 'Product C')
AND price >15;

# Order By

select * from customers
where first_name = "john"
order by customer_id  desc;


# multiple order by

select * from product
order by item_name, price;


# LIMIT
select * from product
order by item_name, price
limit  3 ;


select *from product
where price >= 50
order by item_name asc
limit 2;

# AS
