SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_user_product_recency') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1