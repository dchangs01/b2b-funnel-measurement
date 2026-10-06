SELECT
    id AS opportunity_id,
    account_id,
    name AS opportunity_name,
    type AS opportunity_type,
    stage_name,
    amount,
    close_date,
    is_closed,
    is_won,
    probability,
    forecast_category,
    lead_source,
    campaign_id,
    owner_id,
    created_date AS created_at,
    last_stage_change_date AS last_stage_changed_at
FROM {{ source('salesforce', 'opportunity') }}
WHERE NOT is_deleted