SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_last_orders') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1