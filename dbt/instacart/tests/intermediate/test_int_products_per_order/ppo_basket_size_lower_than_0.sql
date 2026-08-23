select *
from {{ref('int_products_per_order')}}
where basket_size<0