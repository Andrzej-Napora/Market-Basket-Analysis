SELECT *
FROM {{ ref('int_user_avg_days_since_prior_order') }}
WHERE user_id <= 0
   OR user_avg_days_since_prior_order < 0
   OR user_stddev_days_since_prior_order < 0