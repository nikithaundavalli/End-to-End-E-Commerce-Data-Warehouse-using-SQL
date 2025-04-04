create view product_details as
select p.product_id, pt.product_category_name_english as product_cat, p.product_weight_g, p.product_length_cm, p.product_height_cm, p.product_width_cm
from products p
left join product_translation pt
on p.product_category_name = pt.product_category_name;

create view customer_orders_view as
select c.customer_id, c.customer_unique_id, o.order_id
from customers c
join orders o on c.customer_id = o.customer_id;

CREATE VIEW late_deliveries AS
SELECT order_id, customer_id, 
       DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delay_days
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;
