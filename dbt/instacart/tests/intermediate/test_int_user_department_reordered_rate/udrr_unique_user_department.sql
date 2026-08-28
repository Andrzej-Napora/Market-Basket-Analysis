SELECT
    user_id,
    department_id,
    COUNT(*) AS row_count
FROM {{ ref('int_user_department_reordered_rate') }}
GROUP BY
    user_id,
    department_id
HAVING COUNT(*) > 1