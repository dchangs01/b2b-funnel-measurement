SELECT
    id AS opportunity_history_id,
    opportunity_id,
    created_date,
    stage_name,
    amount,
    close_date,
    probability,
    forecast_category,
    expected_revenue
FROM {{ source('salesforce', 'opportunity_history') }}
WHERE NOT is_deleted