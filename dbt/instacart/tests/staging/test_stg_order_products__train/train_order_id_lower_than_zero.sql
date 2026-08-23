SELECT * from {{ref('stg_order_products__train')}}
where 
order_id<0