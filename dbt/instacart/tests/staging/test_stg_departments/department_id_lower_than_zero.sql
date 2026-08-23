select * 
from {{ref('stg_departments')}}
where department_id<0