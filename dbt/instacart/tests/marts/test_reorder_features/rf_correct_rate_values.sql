SELECT *
FROM {{ ref('reorder_features') }}
WHERE product_reordered_rate NOT BETWEEN 0 AND 1
   OR user_product_reordered_rate NOT BETWEEN 0 AND 1
   OR aisle_reordered_rate NOT BETWEEN 0 AND 1
   OR user_aisle_reordered_rate NOT BETWEEN 0 AND 1
   OR department_reordered_rate NOT BETWEEN 0 AND 1
   OR user_department_reordered_rate NOT BETWEEN 0 AND 1
