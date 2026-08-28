SELECT *
FROM {{ ref('reorder_features') }}
WHERE user_reorder_rate_percent NOT BETWEEN 0 AND 100
   OR unique_product_reorder_rate_percent NOT BETWEEN 0 AND 100
   OR percentage_of_orders_including_product NOT BETWEEN 0 AND 100