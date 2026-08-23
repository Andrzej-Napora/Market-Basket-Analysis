    SELECT
        o.user_id,
        o.order_id,
        o.order_number,

        COUNT(opp.product_id) AS basket_size

    FROM {{ref('stg_orders')}} AS o

    JOIN {{ref('stg_order_products__prior')}} AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'

    GROUP BY
        o.user_id,
        o.order_id,
        o.order_number