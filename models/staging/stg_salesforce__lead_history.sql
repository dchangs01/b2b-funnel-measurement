SELECT
    id AS lead_history_id,
    lead_id,
    field,
    old_value,
    new_value,
    created_date AS changed_at
FROM {{ source('salesforce', 'lead_history') }}
WHERE NOT is_deleted