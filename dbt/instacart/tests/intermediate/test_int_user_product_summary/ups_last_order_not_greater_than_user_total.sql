SELECT
    ups.user_id,
    ups.product_id,
    ups.last_product_order_number,
    uos.total_prior_orders
FROM {{ ref('int_user_product_summary') }} AS ups
JOIN {{ ref('int_user_order_summary') }} AS uos
    ON ups.user_id = uos.user_id
WHERE ups.last_product_order_number > uos.total_prior_orders