#which customer made more orders

use abc_data;

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
FROM customers c
JOIN order_counts oc ON c.customer_id = oc.customer_id
JOIN max_order_count moc ON oc.order_count = moc.max_count;


#What’s the total revenue per product?

SELECT 
    p.product_name,
    p.price * SUM(oi.quantity) AS total_revenue
FROM abc.products p
JOIN abc.order_items oi 
    ON oi.product_id = p.product_id
GROUP BY p.product_name, p.price
ORDER BY total_revenue DESC;



