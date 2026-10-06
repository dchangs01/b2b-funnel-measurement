SELECT
    id AS lead_history_id,
    lead_id,
    field,
    old_value,
    new_value,
    created_date
FROM {{ source('salesforce', 'lead_history') }}
WHERE NOT is_deleted