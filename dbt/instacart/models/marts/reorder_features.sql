SELECT
    upmf.user_id,
    upmf.product_id,

    upmf.aisle_id,

    upmf.aisle_reordered_rate,

    d.department_id,

    upmf.department_reordered_rate,

    rt.target,

    umf.days_since_prior_order,

    ROUND(
        (
            upmf.user_product_purchase_count * 1.0
            / NULLIF(umf.total_prior_orders, 0)
        )::NUMERIC,
        2
    ) AS product_purchases_per_order,

    umf.total_prior_orders,

    umf.total_product_purchases,

    umf.total_reordered_purchases,

    ROUND(
        umf.avg_basket_size::NUMERIC,
        2
    ) AS avg_basket_size,

    ROUND(
        umf.user_reorder_rate_percent::NUMERIC,
        2
    ) AS user_reorder_rate_percent,

    umf.unique_products_purchased,

    umf.unique_reordered_products,

    ROUND(
        umf.unique_product_reorder_rate_percent::NUMERIC,
        2
    ) AS unique_product_reorder_rate_percent,

    ROUND(
        upmf.user_aisle_reordered_rate::NUMERIC,
        2
    ) AS user_aisle_reordered_rate,

    ROUND(
        umf.user_avg_days_since_prior_order::NUMERIC,
        2
    ) AS user_avg_days_since_prior_order,

    ROUND(
        umf.user_stddev_days_since_prior_order::NUMERIC,
        2
    ) AS user_stddev_days_since_prior_order,

    ROUND(
        upmf.user_department_reordered_rate::NUMERIC,
        2
    ) AS user_department_reordered_rate,

    ROUND(
        upmf.percentage_of_orders_including_product::NUMERIC,
        2
    ) AS percentage_of_orders_including_product,


    upmf.user_product_purchase_count,

    upmf.last_product_order_number,

    upmf.orders_since_last_purchase,

    upmf.products_since_last_purchase,

    upmf.user_product_reordered_rate,

    ROUND(
        upmf.avg_product_cart_position::NUMERIC,
        2
    ) AS avg_product_cart_position,

    ROUND(
        upmf.last_3_orders::NUMERIC,
        2
    ) AS last_3_orders,

    ROUND(
        upmf.last_6_orders::NUMERIC,
        2
    ) AS last_6_orders,

    ROUND(
        upmf.last_9_orders::NUMERIC,
        2
    ) AS last_9_orders,

    ROUND(
        upmf.last_12_orders::NUMERIC,
        2
    ) AS last_12_orders,

    ROUND(
        upmf.prod_avg_days_since_prior_order::NUMERIC,
        2
    ) AS prod_avg_days_since_prior_order,

    ROUND(
        upmf.prod_stddev_days_since_prior_order::NUMERIC,
        2
    ) AS prod_stddev_days_since_prior_order,

    ROUND(
        upmf.product_reordered_rate::NUMERIC,
        2
    ) AS product_reordered_rate,

    ROUND(
        upmf.user_product_avg_days_since_prior_order::NUMERIC,
        2
    ) AS user_product_avg_days_since_prior_order,

    ROUND(
        upmf.user_product_stddev_days_since_prior_order::NUMERIC,
        2
    ) AS user_product_stddev_days_since_prior_order


FROM {{ref('int_user_product_model_features')}} AS upmf

JOIN {{ref('int_reorder_targets')}} AS rt
    ON upmf.user_id = rt.user_id
    AND upmf.product_id = rt.product_id

left JOIN {{ref('int_user_model_features')}} AS umf
    ON upmf.user_id = umf.user_id

JOIN {{ref('stg_products')}} AS p
    ON upmf.product_id = p.product_id

JOIN {{ref('stg_departments')}} AS d
    ON p.department_id = d.department_id