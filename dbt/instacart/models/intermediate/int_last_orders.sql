WITH cte AS (
    SELECT
        user_id,
        MAX(order_number) AS last_order
    FROM {{ref('stg_orders')}}
    WHERE eval_set = 'prior'
    GROUP BY user_id
)
SELECT
    cte.user_id,
    opp.product_id,
    COUNT(*)filter(where order_number>cte.last_order-3) AS last_3_orders,
    COUNT(*)filter(where order_number>cte.last_order-6) AS last_6_orders,
    COUNT(*)filter(where order_number>cte.last_order-9) AS last_9_orders,
    COUNT(*)filter(where order_number>cte.last_order-12) AS last_12_orders
FROM cte
JOIN {{ref('stg_orders')}} AS o
    ON o.user_id = cte.user_id
JOIN {{ref('stg_order_products__prior')}} AS opp
    ON o.order_id = opp.order_id
WHERE o.eval_set = 'prior'
GROUP BY
    cte.user_id,
    opp.product_id