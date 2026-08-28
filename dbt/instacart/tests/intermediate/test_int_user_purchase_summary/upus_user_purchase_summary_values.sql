SELECT
    user_id,
    total_product_purchases,
    total_reordered_purchases,
    user_reorder_rate_percent
FROM {{ ref('int_user_purchase_summary') }}
WHERE total_product_purchases < 0
   OR total_reordered_purchases < 0
   OR total_reordered_purchases > total_product_purchases
   OR user_reorder_rate_percent NOT BETWEEN 0 AND 100