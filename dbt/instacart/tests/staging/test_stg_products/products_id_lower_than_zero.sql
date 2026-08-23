select *
from {{ref('stg_products')}}
where product_id<0