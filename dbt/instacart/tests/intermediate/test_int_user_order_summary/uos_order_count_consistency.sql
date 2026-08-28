SELECT *
FROM {{ ref('int_user_order_summary') }}
WHERE total_prior_orders <> last_prior_order_number