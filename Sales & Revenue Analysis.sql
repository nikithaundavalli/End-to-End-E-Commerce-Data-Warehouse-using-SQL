-- Monthly revenue trend
select date_format(order_purchase_timestamp, "%Y-%m") as months, round(sum(payment_value),2) as revenue
from orders o
join payments p on o.order_id = p.order_id
group by months
order by months;

-- Top selling product categories and their top selling products
with topCategories as(
	select p.product_category_name, count(o.order_id) as total_orders
	from order_items o
	join products p on o.product_id = p.product_id
	group by p.product_category_name
	order by total_orders desc
	limit 10
),
rankedProducts as(
	select 
		p.product_category_name, 
		o.product_id, 
		count(o.order_id) as product_orders,
		rank() over(partition by p.product_category_name order by count(o.order_id) desc) as rank_pos
	from order_items o
	join products p on o.product_id = p.product_id
	where p.product_category_name in (select product_category_name from topCategories)
	group by p.product_category_name, o.product_id
)
select product_category_name, product_id, product_orders
from rankedProducts
where rank_pos <= 3
order by product_category_name, rank_pos; 

-- Top 3 ordered products per category
SELECT product_category_name, product_id, total_orders, rank_order
FROM (
    SELECT 
        p.product_category_name, 
        oi.product_id, 
        COUNT(oi.order_id) AS total_orders,
        RANK() OVER (PARTITION BY p.product_category_name ORDER BY COUNT(oi.order_id) DESC) AS rank_order
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name, oi.product_id
) ranked_products
WHERE rank_order <= 3;

-- Most profitable product categories
select p.product_category_name_english, s.revenue
from (
	select p.product_category_name, round(sum(o.price),2) as revenue
	from order_items o
	join products p on o.product_id = p.product_id
	group by p.product_category_name
	order by revenue desc
	limit 10
) as s
join product_translation p on s.product_category_name = p.product_category_name;


