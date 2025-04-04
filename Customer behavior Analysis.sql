-- Top 10 customers by total spend
select c.customer_unique_id, sum(payment_value) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join payments p on o.order_id = p.order_id
group by c.customer_unique_id
order by total_spent desc
LIMIT 10;

-- Repeat Customers vs One time Customers(using customer_orders_view)
select count(customer_unique_id) as total_customers,
	   sum(case when order_count = 1 then 1 else 0 end) as one_time_customers,
       sum(case when order_count >1 then 1 else 0 end) as repeat_customers
from(
	select customer_unique_id, count(order_id) as order_count
    from customer_orders_view
    group by customer_unique_id
)subquery;

-- Customer retention rate(using customer_orders_view)
select round((sum(case when order_count > 1 then 1 else 0 end)/count(customer_unique_id))*100,2) as customer_retention_rate
from(
	select customer_unique_id, count(order_id) as order_count
    from customer_orders_view
    group by customer_unique_id
)subquery;

-- Customer preferred payment method
select p.payment_type, count(c.customer_unique_id) as no_of_users
from customers c
join orders o on c.customer_id = o.customer_id
join payments p on o.order_id = p.order_id
group by p.payment_type
order by no_of_users desc
limit 1;

-- Payment installments vs Single payment
select
	case
		when payment_installments = 1 then "Single Payment"
        else "Installments"
	end as payment_category,
    count(*) as transaction_count
from payments
group by payment_category;

-- Top 3 states from where most orders are placed
select c.customer_state, count(o.order_id) as no_of_orders_placed
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_state
order by no_of_orders_placed desc
limit 5;

-- Customers with highest average order values
SELECT 
    c.customer_unique_id, 
    SUM(p.payment_value) AS total_spent, 
    COUNT(o.order_id) AS order_count, 
    ROUND(SUM(p.payment_value) / COUNT(o.order_id), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY avg_order_value DESC
LIMIT 10;
