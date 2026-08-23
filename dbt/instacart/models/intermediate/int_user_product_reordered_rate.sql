SELECT
user_id,
product_id,
count(product_id)filter(where reordered=1)*1.0/
nullif(count(product_id),0) as user_product_reordered_rate
FROM {{ref('stg_order_products__prior')}} as opp
join {{ref('stg_orders')}} as o
on o.order_id = opp.order_id
where eval_set='prior'
group by user_id, product_id