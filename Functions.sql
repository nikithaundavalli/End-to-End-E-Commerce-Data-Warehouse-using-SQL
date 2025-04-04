-- Function to get delivery time of an order
DELIMITER $$

CREATE FUNCTION GetDeliveryTime(orderID VARCHAR(50)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE delivery_days INT;
    
    SELECT DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)
    INTO delivery_days
    FROM orders
    WHERE order_id = orderID AND order_status = "Delivered";
    
    RETURN delivery_days;
END $$

DELIMITER ;

SELECT order_id, GetDeliveryTime(order_id) AS delivery_days FROM orders;

