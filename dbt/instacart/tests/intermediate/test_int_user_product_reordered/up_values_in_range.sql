SELECT *
FROM {{ ref('int_user_product_reordered') }}
WHERE user_id <= 0
   OR product_id <= 0
   OR reorder_count < 0