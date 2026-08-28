SELECT *
FROM {{ ref('int_user_model_features') }}
WHERE total_reordered_purchases > total_product_purchases
   OR unique_reordered_products > unique_products_purchased
   OR unique_products_purchased > total_product_purchases