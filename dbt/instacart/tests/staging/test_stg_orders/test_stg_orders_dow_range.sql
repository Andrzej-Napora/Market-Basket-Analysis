select *
from {{ref("stg_orders")}}
where order_dow<0 or order_dow>6