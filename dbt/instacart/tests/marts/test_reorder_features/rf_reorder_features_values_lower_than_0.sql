select *
from {{ref('reorder_features')}}
where 
user_id < 0 or
product_id < 0 or
department_id < 0 or
department_reordered_rate < 0 or
aisle_id < 0 or
aisle_reordered_rate < 0 or
days_since_prior_order < 0 or
user_product_purchase_count < 0 or
product_purchases_per_order < 0 or
total_prior_orders < 0 or
total_product_purchases < 0 or
avg_basket_size < 0 or
user_reorder_rate_percent < 0 or
unique_products_purchased < 0 or
unique_reordered_products < 0 or
unique_product_reorder_rate_percent < 0 or
last_product_order_number < 0 or
orders_since_last_purchase < 0 or
products_since_last_purchase < 0 or
user_aisle_reordered_rate < 0 or
user_department_reordered_rate < 0 or
percentage_of_orders_including_product < 0 or
user_product_reordered_rate < 0 or
last_3_orders < 0 or
last_6_orders < 0 or
last_9_orders < 0 or
last_12_orders < 0 or
product_reordered_rate < 0