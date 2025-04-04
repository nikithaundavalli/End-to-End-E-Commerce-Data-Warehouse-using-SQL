create index idx_cst_id on orders(customer_id);

create index pay_val on payments(payment_value);

create index itm_id on order_items(order_item_id);

create index pro_cat on products(product_category_name);

create index product_cat on product_translation(product_category_name);