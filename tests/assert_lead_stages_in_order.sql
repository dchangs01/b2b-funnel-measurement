-- Fails if any lead reached a stage before the previous one
SELECT *
FROM {{ ref('int_lead_stage_dates') }}
WHERE mql_at < created_at
   OR sql_at < mql_at