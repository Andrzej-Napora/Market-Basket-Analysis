select * from dbt_dev.reorder_features limit 100;



select * from analytics.reorder_features
where 
last_product_order_number is null or
unique_product_reorder_rate_percent is null or
unique_reordered_products is null or
unique_products_purchased is null or
user_reorder_rate_percent is null or
avg_basket_size is null or
total_product_purchases is null or
product_purchases_per_order is null or
user_product_purchase_count is null or
target is null or
department is null or
department_id is null or
product_name is null or
product_id is null or
user_id is null or
avg_product_cart_position is null or
products_since_last_purchase is null or
orders_since_last_purchase is null
limit 100;


select
user_id,
product_id,
count(*) is_unique
from dbt_dev.reorder_features
group by user_id,
product_id
having count(*)>1
limit 100

select *
from dbt_dev.reorder_features
where target not in (0,1)
limit 100

