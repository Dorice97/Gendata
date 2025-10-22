#daily practice 
create database  ABC_DATA ;
use ABC_DATA;

create table customers (
customer_id int,
first_name varchar(100),
last_name varchar(100),
email varchar(255) UNIQUE
);

alter table customers
add constraint pk_customers PRIMARY KEY (customer_id);

insert into customers ( customer_id, first_name, last_name, email)
values
    (14, 'John', 'Doe', 'johndoe@email.com'),
    (15, 'Jane', 'Smith', 'janesmith@email.com'),
    (3, 'Bob', 'Johnson', 'bobjohnson@email.com'),
    (4, 'Alice', 'Brown', 'alicebrown@email.com'),
    (5, 'Charlie', 'Davis', 'charliedavis@email.com'),
    (6, 'Eva', 'Fisher', 'evafisher@email.com'),
    (7, 'George', 'Harris', 'georgeharris@email.com'),
    (8, 'Ivy', 'Jones', 'ivyjones@email.com'),
    (9, 'Kevin', 'Miller', 'kevinmiller@email.com'),
    (10, 'Lily', 'Nelson', 'lilynelson@email.com'),
    (11, 'Oliver', 'Patterson', 'oliverpatterson@email.com'),
    (12, 'Quinn', 'Roberts', 'quinnroberts@email.com'),
    (13, 'Sophia', 'Thomas', 'sophiathomas@email.com');

create table product (
product_id int,
item_name varchar (255),
price int
);

alter table product
add constraint pk_product PRIMARY KEY (product_id);

insert into product ( product_id, item_name, price)
values
    (14, 'Product A', 10.00),
    (15, 'Product B', 15.00),
    (3, 'Product C', 20.00),
    (4, 'Product D', 25.00),
    (5, 'Product D', 30.00),
    (6, 'Product F', 35.00),
    (7, 'Product G', 40.00),
    (8, 'Product H', 45.00),
    (9, 'Product I', 50.00),
    (10, 'Product J', 55.00),
    (11, 'Product K', 60.00),
    (12, 'Product L', 65.00),
    (13, 'Product M', 70.00);


create table orders (
oeder_id int ,
oder_date date,
customer_id int
);

INSERT INTO orders (oeder_id, customer_id, oder_date) 
VALUES
    (1, 1, '2023-05-01'),
    (2, 2, '2023-05-02'),
    (3, 3, '2023-05-03'),
    (4, 1, '2023-05-04'),
    (5, 2, '2023-05-05'),
    (6, 3, '2023-05-06'),
    (7, 4, '2023-05-07'),
    (8, 5, '2023-05-08'),
    (9, 6, '2023-05-09'),
    (10, 7, '2023-05-10'),
    (11, 8, '2023-05-11'),
    (12, 9, '2023-05-12'),
    (13, 10, '2023-05-13'),
    (14, 11, '2023-05-14'),
    (15, 12, '2023-05-15'),
    (16, 13, '2023-05-16');
    
alter table orders
add constraint pk_orders PRIMARY KEY (oeder_id);

ALTER TABLE orders
RENAME COLUMN oeder_id TO order_id;

create table order_items(
order_id int,
product_id int,
quantity int
);

  INSERT INTO order_items (order_id, product_id, quantity) VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 2, 1),
    (2, 3, 3),
    (3, 1, 1),
    (3, 3, 2),
    (4, 2, 4),
    (4, 3, 1),
    (5, 1, 1),
    (5, 3, 2),
    (6, 2, 3),
    (6, 1, 1),
    (7, 4, 1),
    (7, 5, 2),
    (8, 6, 3),
    (8, 7, 1),
    (9, 8, 2),
    (9, 9, 1),
    (10, 10, 3),
    (10, 11, 2),
    (11, 12, 1),
    (11, 13, 3),
    (12, 4, 2),
    (12, 5, 1),
    (13, 6, 3),
    (13, 7, 2),
    (14, 8, 1),
    (14, 9, 2),
    (15, 10, 3),
    (15, 11, 1),
    (16, 12, 2),
    (16, 13, 3); 

# daily practice 3
# which product has the highest price
select * 
from product
order by price desc
limit 1; 

# Which order_id had the highest number of items in terms of quantity

select order_id, SUM(quantity) AS total_items
from order_items
Group by order_id
order by total_items desc
limit 1;

# daily practice 4
# Which customer has made the most orders?

   WITH order_counts AS (
       SELECT customer_id, COUNT(order_id) AS order_count
       FROM orders
       GROUP BY customer_id
  ),
  max_order_count AS (
      SELECT MAX(order_count) AS max_count
      FROM order_counts
  )
  SELECT c.first_name, c.last_name
  FROM customers  c
  JOIN order_counts oc ON c.customer_id = oc.customer_id
  JOIN max_order_count moc ON oc.order_count = moc.max_count;
   
#What’s the total revenue per product?
SELECT 
    p.item_name,
    p.price * SUM(oi.quantity) AS total_revenue
FROM 
    product p
JOIN 
    order_items oi ON oi.product_id = p.product_id
GROUP BY 
    p.item_name, p.price
ORDER BY 
    total_revenue DESC;

 #Find the first order (by date) for each customer.
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.oder_date
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.oder_date = (
        SELECT MIN(oder_date)
        FROM orders
        WHERE customer_id = c.customer_id
    )
ORDER BY 
    c.customer_id;

# Find the day with the highest revenue
SELECT 
    o.oder_date,
    SUM(p.price * oi.quantity) AS total_revenue
FROM 
    orders o
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    product p ON oi.product_id = p.product_id
GROUP BY 
    o.oder_date
ORDER BY 
    total_revenue DESC
LIMIT 1;