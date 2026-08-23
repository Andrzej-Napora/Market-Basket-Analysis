select *
from {{ref('int_products_purchased_since_last_purchase')}}
where product_id<0