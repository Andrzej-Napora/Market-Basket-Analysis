SELECT
    user_id,
    product_id,
    orders_since_last_purchase
FROM {{ ref('int_user_product_recency') }}
WHERE orders_since_last_purchase < 0