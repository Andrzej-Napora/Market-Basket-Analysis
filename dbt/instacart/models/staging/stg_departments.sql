select 
department_id,
trim(lower(department)) as department
from {{source('raw' , 'departments')}}