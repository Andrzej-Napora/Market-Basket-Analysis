SELECT
        o.user_id,
        opp.product_id,
        COUNT(opp.reordered) AS reorder_count

    FROM {{ref('stg_orders')}} AS o

    JOIN {{ref('stg_order_products__prior')}} AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'
      AND opp.reordered = 1

    GROUP BY
        o.user_id,
        opp.product_id