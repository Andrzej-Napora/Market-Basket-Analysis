select * 
from {{ref('stg_aisles')}}
where aisle_id<0