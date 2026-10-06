SELECT
    id AS campaign_id,
    name AS campaign_name,
    type AS campaign_type,
    status,
    is_active,
    start_date,
    end_date,
    budgeted_cost,
    actual_cost,
    parent_id,
    created_date AS created_at
FROM {{ source('salesforce', 'campaign') }}
WHERE NOT is_deleted