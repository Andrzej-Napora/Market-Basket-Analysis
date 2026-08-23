SELECT * from {{ref('stg_order_products__train')}}
where reordered not in (0,1)