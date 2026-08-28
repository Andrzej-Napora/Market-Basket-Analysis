SELECT
    user_id,
    product_id,
    COUNT(*) AS row_count
FROM {{ ref('int_user_product_avg_days_since_prior_order') }}
GROUP BY
    user_id,
    product_id
HAVING COUNT(*) > 1