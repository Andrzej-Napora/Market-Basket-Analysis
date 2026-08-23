    SELECT
        ups.user_id,
        ups.product_id,

        COALESCE(
            SUM(ppo.basket_size),
            0
        ) AS products_since_last_purchase

    FROM {{ref('int_user_product_summary')}} AS ups

    LEFT JOIN {{ref('int_products_per_order')}} AS ppo
        ON ups.user_id = ppo.user_id
        AND ppo.order_number
            > ups.last_product_order_number

    GROUP BY
        ups.user_id,
        ups.product_id