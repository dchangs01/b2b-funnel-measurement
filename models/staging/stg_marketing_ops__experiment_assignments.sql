SELECT
    experiment_id,
    experiment_name,
    account_id,
    stratum_segment,
    randomization_block,
    assigned_group,
    assigned_at,
    trigger_lead_id,
    salesforce_campaign_id AS campaign_id
FROM {{ source('marketing_ops', 'experiment_assignment') }}
