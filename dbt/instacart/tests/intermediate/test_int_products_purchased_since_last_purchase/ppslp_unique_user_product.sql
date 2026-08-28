SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_products_purchased_since_last_purchase') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1