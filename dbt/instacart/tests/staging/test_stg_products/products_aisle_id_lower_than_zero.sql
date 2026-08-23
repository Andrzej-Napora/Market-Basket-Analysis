select * 
from {{ref('stg_products')}}
where aisle_id<0