SELECT * from {{ref('stg_order_products__prior')}}
where 
product_id<0
