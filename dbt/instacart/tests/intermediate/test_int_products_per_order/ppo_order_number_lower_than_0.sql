select *
from {{ref('int_products_per_order')}}
where order_number<0