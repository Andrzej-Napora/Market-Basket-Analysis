
SELECT
product_id,
trim(lower(product_name)) as product_name,
aisle_id,
department_id
from {{source('raw' , 'products')}}