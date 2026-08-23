SELECT
    o.user_id,

    COUNT(opp.product_id) AS total_product_purchases,

    COUNT(opp.product_id) FILTER (
        WHERE opp.reordered = 1
    ) AS total_reordered_purchases,

    COUNT(opp.product_id) FILTER (
        WHERE opp.reordered = 1
    ) * 100.0
        / NULLIF(COUNT(opp.product_id), 0)
        AS user_reorder_rate_percent

FROM {{ref('stg_orders')}} AS o

JOIN {{ref('stg_order_products__prior')}} AS opp
    ON o.order_id = opp.order_id

WHERE o.eval_set = 'prior'

GROUP BY
    o.user_id