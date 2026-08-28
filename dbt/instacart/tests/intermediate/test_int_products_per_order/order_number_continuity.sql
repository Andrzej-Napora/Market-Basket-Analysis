WITH numbered_orders AS (
    SELECT
        user_id,
        order_id,
        order_number,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY order_number
        ) AS expected_order_number
    FROM {{ ref('int_products_per_order') }}
)

SELECT *
FROM numbered_orders
WHERE order_number <> expected_order_number