select * from raw.products limit 100


select *
from raw.products
where 
product_id is null
or product_name is null
or aisle_id is null
or department_id is null
limit 100

select
product_id,
count(*)
from raw.products
group by product_id
having  count(*)>1
limit 100

