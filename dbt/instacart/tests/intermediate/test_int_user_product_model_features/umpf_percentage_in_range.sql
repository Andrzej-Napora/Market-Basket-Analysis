SELECT *
FROM {{ ref('int_user_product_model_features') }}
WHERE percentage_of_orders_including_product NOT BETWEEN 0 AND 100