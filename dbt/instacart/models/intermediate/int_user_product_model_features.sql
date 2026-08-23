SELECT
    ups.user_id,
    ups.product_id,

    ups.user_product_purchase_count,

    ups.last_product_order_number,

    upr.orders_since_last_purchase,

    ppslp.products_since_last_purchase,

    ups.avg_product_cart_position,

    coalesce(l3o.last_3_orders,0) as last_3_orders,

    coalesce(l6o.last_6_orders,0) as last_6_orders,

    coalesce(l9o.last_9_orders,0) as last_9_orders,

    coalesce(l12o.last_12_orders,0) as last_12_orders,

    padspo.prod_avg_days_since_prior_order,

    padspo.prod_stddev_days_since_prior_order,

    prr.product_reordered_rate,

    upadspo.user_product_avg_days_since_prior_order,

    upadspo.user_product_stddev_days_since_prior_order,

    uprr.user_product_reordered_rate,

    poip.percentage_of_orders_including_product,

    uarr.user_aisle_reordered_rate,

    arr.aisle_reordered_rate,

    drr.department_reordered_rate


FROM {{ref('int_user_product_summary')}} AS ups

left JOIN {{ref('int_user_product_recency')}} AS upr
    ON ups.user_id = upr.user_id
    AND ups.product_id = upr.product_id

left JOIN {{ref('int_products_purchased_since_last_purchase')}} AS ppslp
    ON ups.user_id = ppslp.user_id
    AND ups.product_id = ppslp.product_id

left JOIN {{ref('int_last_3_orders')}} AS l3o
    ON ups.user_id = l3o.user_id
    AND ups.product_id = l3o.product_id

left JOIN {{ref('int_last_6_orders')}} AS l6o
    ON ups.user_id = l6o.user_id
    AND ups.product_id = l6o.product_id

left JOIN {{ref('int_last_9_orders')}} AS l9o
    ON ups.user_id = l9o.user_id
    AND ups.product_id = l9o.product_id

left JOIN {{ref('int_last_12_orders')}} AS l12o
    ON ups.user_id = l12o.user_id
    AND ups.product_id = l12o.product_id

left JOIN {{ref('int_prod_avg_days_since_prior_order')}} AS padspo
    on ups.product_id = padspo.product_id

left JOIN {{ref('int_product_reordered_rate')}} AS prr
    on ups.product_id = prr.product_id

left JOIN {{ref('int_user_product_avg_days_since_prior_order')}} AS upadspo
    ON ups.user_id = upadspo.user_id
    AND ups.product_id = upadspo.product_id

left JOIN {{ref('int_user_product_reordered_rate')}} AS uprr
    ON ups.user_id = uprr.user_id
    AND ups.product_id = uprr.product_id

left JOIN {{ref('int_percentage_of_orders_including_product')}} AS poip
    ON ups.user_id = uprr.user_id
    AND ups.product_id = uprr.product_id

left JOIN {{ref('int_user_aisle_reordered_rate')}} AS uarr
    ON ups.user_id = uarr.user_id AND
     ups.product_id = uarr.product_id

left JOIN {{ref('int_user_department_reordered_rate')}} AS udrr
    ON ups.user_id = udrr.user_id AND
     ups.product_id = udrr.product_id

left JOIN {{ref('int_aisle_reordered_rate')}} AS arr
    ON ups.user_id = arr.user_id AND
     ups.product_id = arr.product_id

left JOIN {{ref('int_department_reordered_rate')}} AS drr
    ON ups.user_id = drr.user_id AND
     ups.product_id = drr.product_id
