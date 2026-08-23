select *
from {{ref('int_products_per_order')}}
where user_id<0