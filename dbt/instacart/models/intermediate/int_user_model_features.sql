SELECT
    uos.user_id,

    uos.total_prior_orders,

    ups.total_product_purchases,

    ups.total_reordered_purchases,

    ups.total_product_purchases * 1.0
        / NULLIF(uos.total_prior_orders, 0)
        AS avg_basket_size,

    ups.user_reorder_rate_percent,

    upcs.unique_products_purchased,

    upcs.unique_reordered_products,

    upcs.unique_product_reorder_rate_percent,

    uadspo.user_avg_days_since_prior_order,

    uadspo.user_stddev_days_since_prior_order


FROM {{ref('int_user_order_summary')}} AS uos

left JOIN {{ref('int_user_purchase_summary')}} AS ups
    ON uos.user_id = ups.user_id

left JOIN {{ref('int_user_product_count_summary')}} AS upcs
    ON uos.user_id = upcs.user_id

left JOIN {{ref('int_user_avg_days_since_prior_order')}} AS uadspo
    ON uos.user_id = uadspo.user_id