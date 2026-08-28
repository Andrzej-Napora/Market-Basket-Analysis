SELECT *
FROM {{ ref('int_user_product_model_features') }}
WHERE prod_avg_days_since_prior_order < 0
   OR prod_stddev_days_since_prior_order < 0
   OR user_product_avg_days_since_prior_order < 0
   OR user_product_stddev_days_since_prior_order < 0