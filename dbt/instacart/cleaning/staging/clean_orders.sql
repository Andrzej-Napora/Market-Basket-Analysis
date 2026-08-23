select *
from raw.orders
where order_id is null
or user_id is null
or eval_set is null
or order_number is null
or order_dow is null
or order_hour_of_day is null
or days_since_prior_order is null
limit 100

select *
from raw.orders
where order_number = 1
and days_since_prior_order is not null
limit 100

select *
from raw.orders
where days_since_prior_order is null
and order_number <> 1
limit 100

select
order_id,
count(order_number)
from raw.orders
group by 
order_id
having count(order_number)>1
limit 100

select
order_id,
count(order_id) as row_count
from raw.orders
group by order_id
having count(order_id)>1
limit 100

SELECT *
FROM raw.orders
WHERE order_number < 1
   OR order_dow NOT BETWEEN 0 AND 6
   OR order_hour_of_day NOT BETWEEN 0 AND 23
   OR days_since_prior_order < 0
   OR eval_set NOT IN ('prior', 'train', 'test')
limit 100

with cte as(
select
user_id,
order_id,
order_number,
count(*)over(
    partition by user_id order by order_number
) order_count
from raw.orders
)
select
user_id,
order_id,
order_number,
order_count
from cte
where order_number<>order_count
limit 100