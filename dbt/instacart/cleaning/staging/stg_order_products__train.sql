SELECT * from raw.order_products__train limit 100

SELECT * from raw.order_products__train
where 
order_id is null or
product_id is null or
add_to_cart_order is null or
reordered is null
limit 100


SELECT * from raw.order_products__train
where reordered<>0 and reordered<>1
limit 100


with cte as(
SELECT *,
count(*) over(partition by order_id order by add_to_cart_order)
as add_to_cart_continuity
from raw.order_products__train
)
select *
from cte
where add_to_cart_continuity<>add_to_cart_order
limit 100


SELECT * from raw.order_products__train
where 
order_id<0 or
product_id<0 or
add_to_cart_order<0
limit 100