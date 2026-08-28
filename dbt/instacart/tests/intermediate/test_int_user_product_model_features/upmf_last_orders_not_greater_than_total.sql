SELECT *
FROM {{ ref('int_user_product_model_features') }}
WHERE last_3_orders > user_product_purchase_count
   OR last_6_orders > user_product_purchase_count
   OR last_9_orders > user_product_purchase_count
   OR last_12_orders > user_product_purchase_count