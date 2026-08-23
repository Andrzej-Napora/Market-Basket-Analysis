SELECT
        o.user_id,
        opp.product_id,
        COUNT(opp.reordered) AS reorder_count

    FROM raw.orders AS o

    JOIN raw.order_products__prior AS opp
        ON o.order_id = opp.order_id

    WHERE o.eval_set = 'prior'
      AND opp.reordered = 1

    GROUP BY
        o.user_id,
        opp.product_id
        limit 100;