    SELECT
        uos.user_id,
        ups.product_id,

        uos.last_prior_order_number
            - ups.last_product_order_number
            AS orders_since_last_purchase

    FROM {{ref('int_user_order_summary')}} AS uos

    JOIN {{ref('int_user_product_summary')}} AS ups
        ON uos.user_id = ups.user_id