SELECT
    user_id,
    lower(email) AS email,
    split_part(lower(email), '@', 2) AS email_domain,
    signed_up_at,
    signup_utm_source,
    signup_utm_medium,
    current_plan,
    first_paid_at
FROM {{ source('app', 'users') }}