SELECT
    ups.user_id,
    ups.product_id,

    CASE
        WHEN opt.product_id IS NOT NULL THEN 1
        ELSE 0
    END AS target

FROM {{ref('int_user_product_summary')}} AS ups

JOIN {{ref('stg_orders')}} AS train_order
    ON ups.user_id = train_order.user_id
    AND train_order.eval_set = 'train'

LEFT JOIN {{ref('stg_order_products__train')}} AS opt
    ON train_order.order_id = opt.order_id
    AND ups.product_id = opt.product_id