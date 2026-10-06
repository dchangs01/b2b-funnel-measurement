SELECT
    id AS opportunity_contact_role_id,
    opportunity_id,
    contact_id,
    role,
    is_primary,
    created_date AS created_at
FROM {{ source('salesforce', 'opportunity_contact_role') }}
WHERE NOT is_deleted