SELECT
    id AS lead_id,
    first_name,
    last_name,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    title,
    company,
    status,
    lead_source,
    industry,
    number_of_employees,
    country,
    owner_id,
    is_converted,
    converted_date,
    converted_account_id,
    converted_contact_id,
    converted_opportunity_id,
    mql_date_c AS mql_at,
    sql_date_c AS sql_at,
    created_date AS created_at
FROM {{ source('salesforce', 'lead') }}
WHERE NOT is_deleted