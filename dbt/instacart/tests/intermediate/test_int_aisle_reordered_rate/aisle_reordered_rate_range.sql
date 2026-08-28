SELECT
    aisle_id,
    aisle_reordered_rate
FROM {{ ref('int_aisle_reordered_rate') }}
WHERE aisle_reordered_rate < 0
   OR aisle_reordered_rate > 1
