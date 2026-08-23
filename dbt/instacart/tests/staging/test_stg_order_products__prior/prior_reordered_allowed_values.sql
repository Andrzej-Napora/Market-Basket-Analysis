SELECT * from {{ref('stg_order_products__prior')}}
where reordered not in (0,1)