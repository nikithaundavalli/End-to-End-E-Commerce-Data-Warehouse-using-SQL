-- Average delivery time of orders
select round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) as avg_delivery_days
from orders
where order_status = "Delivered";

-- No.of late deliveries
SELECT COUNT(*) AS late_deliveries
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- Customer satisfaction distribution
SELECT review_score, COUNT(*) AS review_count
FROM review
GROUP BY review_score
ORDER BY review_score DESC;

-- Correlation between delivery time and customer reviews
SELECT 
    CASE 
        WHEN delivery_days <= 5 THEN 'Fast (0-5 days)'
        WHEN delivery_days BETWEEN 6 AND 10 THEN 'Moderate (6-10 days)'
        ELSE 'Slow (11+ days)'
    END AS delivery_category,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM (
    SELECT o.order_id, DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS delivery_days, r.review_score
    FROM orders o
    JOIN review r ON o.order_id = r.order_id
    WHERE order_status = 'delivered'
) subquery
GROUP BY delivery_category
ORDER BY avg_review_score DESC;

