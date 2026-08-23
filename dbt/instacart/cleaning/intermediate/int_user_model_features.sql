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

    upcs.unique_product_reorder_rate_percent

FROM analytics.user_order_summary AS uos

JOIN analytics.user_purchase_summary AS ups
    ON uos.user_id = ups.user_id

JOIN analytics.user_product_count_summary AS upcs
    ON uos.user_id = upcs.user_id
    limit 100;