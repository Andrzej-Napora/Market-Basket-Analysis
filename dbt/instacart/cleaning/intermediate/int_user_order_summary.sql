    SELECT
        user_id,

        COUNT(order_id) AS total_prior_orders,

        MAX(order_number) AS last_prior_order_number

    FROM raw.orders

    WHERE eval_set = 'prior'

    GROUP BY
        user_id
        limit 100;