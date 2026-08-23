SELECT
user_id,
department_id,
count(p.product_id)filter(where reordered=1)*1.0/
nullif(count(p.product_id),0) as user_department_reordered_rate
from {{ref('stg_products')}} as p
join {{ref('stg_order_products__prior')}} as opp
on opp.product_id = p.product_id
join {{ref('stg_orders')}} as o
on o.order_id = opp.order_id
where eval_set='prior'
group by user_id,department_id
