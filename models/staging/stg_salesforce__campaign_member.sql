SELECT
    id AS campaign_member_id,
    campaign_id,
    lead_id,
    contact_id,
    lead_or_contact_id,
    status,
    has_responded,
    first_responded_date,
    created_date
FROM {{ source('salesforce', 'campaign_member') }}
WHERE NOT is_deleted