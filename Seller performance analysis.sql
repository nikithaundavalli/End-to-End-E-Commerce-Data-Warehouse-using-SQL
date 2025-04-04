-- Top 10 sellers by revenue
SELECT s.seller_id, ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Seller with highest average review score
SELECT s.seller_id, ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
JOIN review r ON oi.order_id = r.order_id
GROUP BY s.seller_id
ORDER BY avg_review_score DESC
LIMIT 3;

-- Sellers who processed more than 100 orders
SELECT seller_id, COUNT(order_id) AS total_orders, dense_rank() over(order by count(order_id) desc) as ranks
FROM order_items
GROUP BY seller_id
HAVING total_orders > 100  
ORDER BY total_orders DESC;

-- Average delay per seller
SELECT s.seller_id, ROUND(AVG(ld.delay_days), 2) AS avg_delay
FROM late_deliveries ld
JOIN order_items oi ON ld.order_id = oi.order_id
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY avg_delay desc; 


