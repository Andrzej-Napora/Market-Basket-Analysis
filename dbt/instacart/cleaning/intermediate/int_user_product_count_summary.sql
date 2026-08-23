SELECT
    ups.user_id,

    COUNT(ups.product_id) AS unique_products_purchased,

    COUNT(upr.product_id) AS unique_reordered_products,

    COUNT(upr.product_id) * 100.0
        / NULLIF(COUNT(ups.product_id), 0)
        AS unique_product_reorder_rate_percent

FROM analytics.user_product_summary AS ups

LEFT JOIN analytics.user_product_reordered AS upr
    ON ups.user_id = upr.user_id
    AND ups.product_id = upr.product_id

GROUP BY
    ups.user_id
    limit 100;