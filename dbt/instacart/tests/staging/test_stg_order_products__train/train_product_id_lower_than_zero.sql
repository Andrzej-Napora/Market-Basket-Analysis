SELECT * from {{ref('stg_order_products__train')}}
where 
product_id<0
