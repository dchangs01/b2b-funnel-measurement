SELECT
    id AS user_id,
    first_name,
    last_name,
    name,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    title,
    department,
    is_active,
    created_date
FROM {{ source('salesforce', 'user') }}