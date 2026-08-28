SELECT
    department_id,
    department_reordered_rate
FROM {{ ref('int_department_reordered_rate') }}
WHERE department_reordered_rate < 0
   OR department_reordered_rate > 1
