SELECT
    id AS opportunity_id,
    account_id,
    name,
    type,
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
    created_date,
    last_stage_change_date
FROM {{ source('salesforce', 'opportunity') }}
WHERE NOT is_deleted