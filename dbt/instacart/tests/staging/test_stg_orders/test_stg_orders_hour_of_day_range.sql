select *
from {{ref("stg_orders")}}
where order_hour_of_day<0 or order_hour_of_day>23