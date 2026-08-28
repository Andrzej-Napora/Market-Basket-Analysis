SELECT
    user_id,
    aisle_id,
    user_aisle_reordered_rate
FROM {{ ref('int_user_aisle_reordered_rate') }}
WHERE user_aisle_reordered_rate < 0
   OR user_aisle_reordered_rate > 1