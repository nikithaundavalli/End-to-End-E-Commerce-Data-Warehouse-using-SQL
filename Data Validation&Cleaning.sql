-- Checking duplicates in customer_id
select customer_id, count(*)
from customers
group by customer_id
having count(*) > 1;

-- Checking duplicates in order_id
select order_id, count(*)
from orders
group by order_id
having count(*) > 1;

-- Foreign key integrity 
-- Checking orders from order_items which are not listed in orders
select oi.order_id
from order_items oi
left join orders o
on oi.order_id=o.order_id
where o.order_id is NULL;

-- Checking payments for order_id those are not listed in orders
select p.order_id
from payments p
left join orders o
on p.order_id=o.order_id
where o.order_id is null;

-- Ensuring important columns does not contains null values
SELECT * FROM orders WHERE customer_id IS NULL;
SELECT * FROM order_items WHERE order_id IS NULL OR product_id IS NULL;
SELECT * FROM products WHERE product_category_name IS NULL;
-- Products are found having empty product names, so replacing them with "Unknown"
update products
set product_category_name = "Unknown"
where product_category_name is null;

-- Ensuring consistency over data
SET SQL_SAFE_UPDATES = 0;
update payments
set payment_type = lower(payment_type);

UPDATE products 
SET product_category_name = TRIM(LOWER(product_category_name));
SET SQL_SAFE_UPDATES = 1;

