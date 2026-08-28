SELECT *
FROM {{ ref('int_user_department_reordered_rate') }}
WHERE user_id <= 0