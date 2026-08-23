select *
from {{ref('int_products_purchased_since_last_purchase')}}
where user_id<0