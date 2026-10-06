SELECT
    CONCAT(date, '-', channel) AS ad_spend_id,
    date AS spend_date,
    channel,
    platform,
    salesforce_campaign_id AS campaign_id,
    spend,
    impressions,
    clicks
FROM {{ source('ads', 'ad_spend_daily') }}