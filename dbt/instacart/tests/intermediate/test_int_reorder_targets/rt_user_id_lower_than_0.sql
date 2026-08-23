select *
from {{ref('int_reorder_targets')}}
where user_id<0