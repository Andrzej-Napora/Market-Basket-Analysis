with cte as(
SELECT
aisle_id,
count(p.product_id)filter(where reordered=1)*1.0/
nullif(count(p.product_id),0) as aisle_reordered_rate
from {{ref('stg_products')}} as p
join {{ref('stg_order_products__prior')}} as opp
on opp.product_id = p.product_id
join {{ref('stg_orders')}} as o
on o.order_id = opp.order_id
where eval_set='prior'
group by aisle_id
)
SELECT
user_id,
p.product_id,
aisle_reordered_rate
from {{ref('stg_orders')}} as o
join {{ref('stg_order_products__prior')}} as opp
on opp.order_id = o.order_id
join {{ref('stg_products')}} as p
on p.product_id = opp.product_id
join cte as c
on p.aisle_id = c.aisle_id