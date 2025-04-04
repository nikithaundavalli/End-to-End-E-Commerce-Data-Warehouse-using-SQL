-- Total no.of Customers
select count(distinct customer_unique_id) as no_of_customers
from customers;

-- Total no.of orders placed
select count(distinct order_id) as no_of_orders
from orders;

-- Total no.of product categories
select count(distinct product_category_name) as no_of_product_categories
from products;

-- Total Revenue generated
select round(sum(payment_value),2) as total_revenue
from payments;

-- Average order value
select round(sum(payment_value)/count(distinct order_id), 2) as avg_order_value
from payments;

-- Average no.of items per order
select round(sum(order_item_id)/count(distinct order_id),2) as avg_items_per_order
from order_items;

-- Highest purchase order
select *
from payments
where payment_value in (select max(payment_value) from payments);

