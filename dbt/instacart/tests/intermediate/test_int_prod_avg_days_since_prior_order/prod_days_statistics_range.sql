SELECT
    product_id,
    prod_avg_days_since_prior_order,
    prod_stddev_days_since_prior_order
FROM {{ ref('int_prod_avg_days_since_prior_order') }}
WHERE prod_avg_days_since_prior_order NOT BETWEEN 0 AND 30
   OR prod_stddev_days_since_prior_order < 0