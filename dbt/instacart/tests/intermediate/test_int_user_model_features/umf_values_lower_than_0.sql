select *
from {{ref('int_user_model_features')}}
where user_id<0 or
total_prior_orders<0 or
total_product_purchases<0 or
total_reordered_purchases<0 or
avg_basket_size<0 or
user_reorder_rate_percent<0 or
unique_products_purchased<0 or
unique_reordered_products<0 or
unique_product_reorder_rate_percent<0
