select
aisle_id,
trim(lower(aisle)) as aisle
from {{source('raw' , 'aisles')}}