SELECT
user_id,
avg(days_since_prior_order)
as user_avg_days_since_prior_order,
stddev_pop(days_since_prior_order)
as user_stddev_days_since_prior_order
from {{ref('stg_orders')}}
where eval_set='prior'
group by user_id
order by user_id