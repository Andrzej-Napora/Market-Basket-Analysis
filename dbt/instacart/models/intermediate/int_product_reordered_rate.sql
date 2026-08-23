SELECT
product_id,
count(product_id)filter(where reordered=1)*1.0/
nullif(count(product_id),0) as product_reordered_rate
FROM {{ref('stg_order_products__prior')}}
group by product_id