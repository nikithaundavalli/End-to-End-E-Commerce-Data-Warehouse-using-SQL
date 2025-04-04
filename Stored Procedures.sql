-- Stored procedure to get order history of customers
DELIMITER $$  

CREATE PROCEDURE GetCustomerOrderHistory(IN customerID VARCHAR(50))
BEGIN
    SELECT 
        o.order_id, 
        o.order_status, 
        o.order_purchase_timestamp, 
        ROUND(SUM(p.payment_value), 2) AS total_spent
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE o.customer_id = customerID  
    GROUP BY o.order_id;
END $$ 

DELIMITER ;  

CALL GetCustomerOrderHistory('0001fd6190edaaf884bcaf3d49edf079');

