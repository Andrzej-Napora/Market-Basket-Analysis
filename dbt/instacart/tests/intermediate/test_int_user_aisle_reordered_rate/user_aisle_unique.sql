SELECT
    user_id,
    aisle_id,
    COUNT(*) AS row_count
FROM {{ ref('int_user_aisle_reordered_rate') }}
GROUP BY
    user_id,
    aisle_id
HAVING COUNT(*) > 1