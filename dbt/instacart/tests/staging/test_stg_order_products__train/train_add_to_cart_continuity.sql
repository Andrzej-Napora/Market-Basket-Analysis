with cte as(
SELECT *,
count(*) over(partition by order_id order by add_to_cart_order)
as add_to_cart_continuity
from {{ref('stg_order_products__train')}}
)
select *
from cte
where add_to_cart_continuity<>add_to_cart_order