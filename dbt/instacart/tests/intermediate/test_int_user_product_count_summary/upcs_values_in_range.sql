SELECT *
FROM {{ ref('int_user_product_count_summary') }}
WHERE user_id <= 0
   OR unique_products_purchased <= 0
   OR unique_reordered_products < 0
   OR unique_product_reorder_rate_percent NOT BETWEEN 0 AND 100