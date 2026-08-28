select
user_id,
product_id,
count(*)
from {{ref('reorder_features')}}
group by user_id,
product_id
having count(*)>1