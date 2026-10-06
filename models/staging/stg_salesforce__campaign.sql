SELECT
    id AS campaign_id,
    name,
    type,
    status,
    is_active,
    start_date,
    end_date,
    budgeted_cost,
    actual_cost,
    parent_id,
    created_date
FROM {{ source('salesforce', 'campaign') }}
WHERE NOT is_deleted