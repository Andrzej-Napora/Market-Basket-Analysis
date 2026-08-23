SELECT
    ups.user_id,
    ups.product_id,

    ups.user_product_purchase_count,

    ups.last_product_order_number,

    upr.orders_since_last_purchase,

    ppslp.products_since_last_purchase,

    ups.avg_product_cart_position


FROM analytics.user_product_summary AS ups

JOIN analytics.user_product_recency AS upr
    ON ups.user_id = upr.user_id
    AND ups.product_id = upr.product_id

JOIN analytics.products_purchased_since_last_purchase AS ppslp
    ON ups.user_id = ppslp.user_id
    AND ups.product_id = ppslp.product_id
    limit 100;