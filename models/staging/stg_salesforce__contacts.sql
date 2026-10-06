SELECT
    id AS contact_id,
    account_id,
    first_name,
    last_name,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    title,
    lead_source,
    owner_id,
    mql_date_c AS mql_date,
    sql_date_c AS sql_date,
    created_date
FROM {{ source('salesforce', 'contact') }}
WHERE NOT is_deleted