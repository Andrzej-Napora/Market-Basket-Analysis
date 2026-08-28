select *
from {{ref('reorder_features')}}
where target not in (0,1)