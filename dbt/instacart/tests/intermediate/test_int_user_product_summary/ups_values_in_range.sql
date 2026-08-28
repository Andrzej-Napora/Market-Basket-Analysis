SELECT *
FROM {{ ref('int_user_product_summary') }}
WHERE user_id <= 0
   OR product_id <= 0
   OR user_product_purchase_count < 0
   OR last_product_order_number < 0