SELECT
    id AS user_id,
    first_name,
    last_name,
    name AS user_name,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    title,
    department,
    is_active,
    created_date AS created_at
FROM {{ source('salesforce', 'user') }}