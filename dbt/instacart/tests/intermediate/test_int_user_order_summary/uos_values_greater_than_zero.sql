SELECT *
FROM {{ ref('int_user_order_summary') }}
WHERE user_id <= 0
   OR total_prior_orders <= 0
   OR last_prior_order_number <= 0