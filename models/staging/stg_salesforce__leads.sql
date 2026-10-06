SELECT
    id AS lead_id,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    company,
    status,
    lead_source,
    is_converted,
    converted_account_id,
    created_date AS created_at,
    mql_date_c AS mql_at_field,
    sql_date_c AS sql_at
FROM {{ source('salesforce', 'lead') }}
WHERE NOT is_deleted