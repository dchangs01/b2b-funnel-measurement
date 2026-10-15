-- Fails if any eligible_leads = 0.
-- Every account was enrolled because a lead MQL'd
-- during enrollment window so 0 means a lead was lost
-- in matching.
SELECT
	account_id,
	trigger_lead_id,
	eligible_leads
FROM {{ ref('nurture_experiment_accounts') }}
WHERE eligible_leads = 0