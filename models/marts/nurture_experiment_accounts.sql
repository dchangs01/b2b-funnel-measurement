WITH experiments AS (
	SELECT
		experiment_id,
		experiment_name,
		account_id,
		assigned_group,
		assigned_at,
		campaign_id,
		stratum_segment AS segment,
		trigger_lead_id
	FROM {{ ref('stg_marketing_ops__experiment_assignments') }}
),

eligible_leads AS (
	SELECT
		lead_id,
		account_id,
		entered_from_at,
		entered_to_at,
		days_to_advance
	FROM  {{ ref('funnel_transitions') }}
	WHERE from_stage = 'mql'
),

eligible_experiments AS (
	SELECT
		experiments.experiment_id,
		experiments.experiment_name,
		experiments.account_id,
		experiments.assigned_group,
		experiments.assigned_at,
		experiments.campaign_id,
		experiments.segment,
		experiments.trigger_lead_id,
		COUNT(eligible_leads.lead_id) AS eligible_leads,
		MIN(eligible_leads.entered_to_at) AS first_sql_at,
		MAX(CASE WHEN eligible_leads.days_to_advance <= 60 THEN 1 ELSE 0 END) AS converted_within_60d
	FROM experiments
	LEFT JOIN eligible_leads
	ON experiments.account_id = eligible_leads.account_id
	-- Cast to DATE to catch timestamp drift
	AND eligible_leads.entered_from_at::DATE <= DATE '2026-03-31'
	AND eligible_leads.entered_from_at::DATE >= experiments.assigned_at::DATE
	GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
)

SELECT * FROM eligible_experiments