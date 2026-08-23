select *
from {{ref('int_reorder_targets')}}
where product_id<0