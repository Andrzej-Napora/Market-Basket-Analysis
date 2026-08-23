select *
from {{ref('fct_reorder_features')}}
where 
last_product_order_number < 0 or
unique_product_reorder_rate_percent < 0 or
unique_reordered_products < 0 or
unique_products_purchased < 0 or
user_reorder_rate_percent < 0 or
avg_basket_size < 0 or
total_product_purchases < 0 or
product_purchases_per_order < 0 or
user_product_purchase_count < 0 or
target < 0 or
department_id < 0 or
product_id < 0 or
user_id < 0 or
avg_product_cart_position < 0 or
products_since_last_purchase < 0 or
orders_since_last_purchase < 0
limit 100