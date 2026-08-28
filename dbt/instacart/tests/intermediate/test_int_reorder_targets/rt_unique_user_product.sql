SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_reorder_targets') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1