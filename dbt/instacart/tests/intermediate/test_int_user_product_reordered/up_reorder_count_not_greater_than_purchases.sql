SELECT
    reordered.user_id,
    reordered.product_id,
    reordered.reorder_count,
    summary.user_product_purchase_count
FROM {{ ref('int_user_product_reordered') }} AS reordered
JOIN {{ ref('int_user_product_summary') }} AS summary
    ON reordered.user_id = summary.user_id
    AND reordered.product_id = summary.product_id
WHERE reordered.reorder_count
    > summary.user_product_purchase_count