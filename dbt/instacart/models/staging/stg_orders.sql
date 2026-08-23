SELECT
    order_id,
    user_id,
    TRIM(LOWER(eval_set)) AS eval_set,
    order_number,
    order_dow,
    order_hour_of_day,
    days_since_prior_order
FROM {{ source('raw', 'orders') }}
