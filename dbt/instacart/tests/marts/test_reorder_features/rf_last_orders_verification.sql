SELECT *
FROM {{ ref('reorder_features') }}
WHERE last_3_orders > last_6_orders
   OR last_6_orders > last_9_orders
   OR last_9_orders > last_12_orders