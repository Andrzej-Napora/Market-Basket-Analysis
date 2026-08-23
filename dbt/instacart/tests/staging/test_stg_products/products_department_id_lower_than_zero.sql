select *
from {{ref('stg_products')}}
where department_id<0