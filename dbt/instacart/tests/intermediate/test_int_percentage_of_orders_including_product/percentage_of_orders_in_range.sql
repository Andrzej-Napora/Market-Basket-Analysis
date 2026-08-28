SELECT *
FROM {{ ref('int_percentage_of_orders_including_product') }}
WHERE percentage_of_orders_including_product < 0
   OR percentage_of_orders_including_product > 100