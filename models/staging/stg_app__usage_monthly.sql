SELECT
    CONCAT(user_id, '-', usage_month) AS usage_monthly_id,
    user_id,
    usage_month,
    active_days,
    messages_sent
FROM {{ source('app', 'usage_monthly') }}