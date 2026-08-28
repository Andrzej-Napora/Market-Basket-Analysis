SELECT *
FROM {{ ref('int_user_department_reordered_rate') }}
WHERE user_department_reordered_rate NOT BETWEEN 0 AND 1