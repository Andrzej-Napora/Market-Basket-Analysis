SELECT *
FROM {{ ref('int_user_product_model_features') }}
WHERE user_id <= 0
   OR product_id <= 0
   OR user_product_purchase_count <= 0
   OR last_product_order_number <= 0
   OR orders_since_last_purchase < 0
   OR products_since_last_purchase < 0