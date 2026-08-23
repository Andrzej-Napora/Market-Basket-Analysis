select *
from raw.aisles
limit 100


select
aisle_id,
count(*)
from raw.aisles
group by aisle_id
having count(*)>1
limit 100

select *
from raw.aisles
where
aisle is null

