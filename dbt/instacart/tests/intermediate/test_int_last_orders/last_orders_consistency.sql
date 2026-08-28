SELECT
    user_id,
    product_id,
    last_3_orders,
    last_6_orders,
    last_9_orders,
    last_12_orders
FROM {{ ref('int_last_orders') }}
WHERE last_3_orders > last_6_orders
   OR last_6_orders > last_9_orders
   OR last_9_orders > last_12_orders