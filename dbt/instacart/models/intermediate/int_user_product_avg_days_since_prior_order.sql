SELECT
    user_id,
    product_id,
    avg(days_since_prior_order) 
as user_product_avg_days_since_prior_order,
stddev_pop(days_since_prior_order)
as user_product_stddev_days_since_prior_order
from {{ref('stg_orders')}} o
join {{ref('stg_order_products__prior')}} as opp
on o.order_id = opp.order_id
where eval_set='prior'
group by user_id,
product_id
order by user_id,
product_id