select *
from {{ref('int_products_purchased_since_last_purchase')}}
where products_since_last_purchase<0