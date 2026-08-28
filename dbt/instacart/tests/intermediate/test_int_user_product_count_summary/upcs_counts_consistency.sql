SELECT *
FROM {{ ref('int_user_product_count_summary') }}
WHERE unique_reordered_products > unique_products_purchased