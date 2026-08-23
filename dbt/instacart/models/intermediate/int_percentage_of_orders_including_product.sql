with cte as(
SELECT
user_id,
count(order_id) as user_total_orders
from {{ref('stg_orders')}}
where eval_set='prior'
group by user_id
)
SELECT
c.user_id,
product_id,
count(distinct o.order_id)*100.0/nullif(user_total_orders,0)
as percentage_of_orders_including_product
from {{ref('stg_orders')}} as o
join {{ref('stg_order_products__prior')}} as opp
on o.order_id = opp.order_id
join cte as c
on c.user_id = o.user_id
where eval_set='prior'
group by c.user_id,
product_id,user_total_orders