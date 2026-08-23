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
    COUNT(*) AS last_12_orders
FROM cte
JOIN {{ref('stg_orders')}} AS o
    ON o.user_id = cte.user_id
JOIN {{ref('stg_order_products__prior')}} AS opp
    ON o.order_id = opp.order_id
WHERE o.eval_set = 'prior' AND
    o.order_number > cte.last_order - 12
GROUP BY
    cte.user_id,
    opp.product_id