-- Fails if any lead reached a funnel stage before the previous one.
-- Opportunity vs. SQL is compared at the day level: deals created at
-- conversion can be timestamped a few hours before the SQL field.
SELECT *
FROM {{ ref('int_funnel_spine') }}
WHERE mql_at < created_at
   OR sql_at < mql_at
   OR CAST(opportunity_created_at AS DATE) < CAST(sql_at AS DATE)
   OR won_at < opportunity_created_at
   OR lost_at < opportunity_created_at