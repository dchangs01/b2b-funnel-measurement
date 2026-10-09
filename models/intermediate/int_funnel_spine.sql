WITH leads AS (
	SELECT
		lead_id,
		account_id,
		match_method
	FROM {{ ref('int_leads_matched_to_accounts') }}
	WHERE NOT is_duplicate_lead
	GROUP BY 1, 2, 3
),

stages AS (
	SELECT
		lead_id,
		created_at,
		mql_at,
		sql_at
	FROM {{ ref('int_lead_stage_dates') }}
	GROUP BY 1, 2, 3, 4
),

lead_details AS (
	SELECT
		lead_id,
		lead_source,
		converted_contact_id
	FROM {{ ref('stg_salesforce__leads') }}
	GROUP BY 1, 2, 3
),

sourced_opps AS (
	SELECT
		contact_id,
		opportunity_id
	FROM {{ ref('stg_salesforce__opportunity_contact_roles') }}
	WHERE is_primary is TRUE
	GROUP BY 1, 2
),

opps AS (
	SELECT
		opportunity_id,
		account_id,
		discovery_at,
		won_at,
		lost_at,
		amount,
		opportunity_type
	FROM {{ ref('int_opportunity_stage_dates') }}
	GROUP BY 1, 2, 3, 4, 5, 6, 7
),

accounts AS (
	SELECT
		account_id,
		segment
	FROM {{ ref('stg_salesforce__accounts') }}
	GROUP BY 1, 2
),

spine AS (
	SELECT
		leads.lead_id,
		leads.account_id,
		leads.match_method,
		accounts.segment,
		lead_details.lead_source,
		stages.created_at,
		stages.mql_at,
		stages.sql_at,
		sourced_opps.opportunity_id,
		opps.opportunity_type,
		opps.amount,
		opps.discovery_at AS opportunity_created_at,
		opps.won_at,
		opps.lost_at
	FROM leads
	LEFT JOIN stages ON leads.lead_id = stages.lead_id
	LEFT JOIN lead_details ON leads.lead_id = lead_details.lead_id
	LEFT JOIN sourced_opps ON lead_details.converted_contact_id = sourced_opps.contact_id
	LEFT JOIN opps ON sourced_opps.opportunity_id = opps.opportunity_id
	LEFT JOIN accounts ON leads.account_id = accounts.account_id
	GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
)

SELECT * FROM spine