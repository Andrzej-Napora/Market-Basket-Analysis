SELECT
    o.user_id,
    opp.product_id,

    COUNT(opp.product_id) AS user_product_purchase_count,

    MAX(o.order_number) AS last_product_order_number,

    AVG(opp.add_to_cart_order)
        AS avg_product_cart_position

FROM {{ref('stg_orders')}} AS o

JOIN {{ref('stg_order_products__prior')}} AS opp
    ON o.order_id = opp.order_id

WHERE o.eval_set = 'prior'

GROUP BY
    o.user_id,
    opp.product_id