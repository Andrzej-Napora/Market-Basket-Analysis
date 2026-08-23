with cte as(
SELECT
user_id,
aisle_id,
count(p.product_id)filter(where reordered=1)*1.0/
nullif(count(p.product_id),0) as user_aisle_reordered_rate
from {{ref('stg_products')}} as p
join {{ref('stg_order_products__prior')}} as opp
on opp.product_id = p.product_id
join {{ref('stg_orders')}} as o
on o.order_id = opp.order_id
where eval_set='prior'
group by user_id, aisle_id
)

SELECT
c.user_id,
opp.product_id,
c.user_aisle_reordered_rate
from {{ref('stg_products')}} as p
join {{ref('stg_order_products__prior')}} as opp
on opp.product_id = p.product_id
join {{ref('stg_orders')}} as o
on o.order_id = opp.order_id
join cte as c
on c.user_id = o.user_id and
    c.aisle_id = p.aisle_id
where eval_set='prior'