SELECT * from {{ref('stg_order_products__prior')}}
where 
order_id<0