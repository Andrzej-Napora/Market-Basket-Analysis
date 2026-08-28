SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_percentage_of_orders_including_product') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1