WITH stage_dates AS (
	SELECT
		opportunity_id,
		MIN(CASE WHEN stage_name = 'Discovery' THEN changed_at END) AS discovery_at,
		MIN(CASE WHEN stage_name = 'Proposal' THEN changed_at END) AS proposal_at,
		MIN(CASE WHEN stage_name = 'Negotiation' THEN changed_at END) AS negotiation_at,
		MIN(CASE WHEN stage_name = 'Closed Won' THEN changed_at END) AS won_at,
		MIN(CASE WHEN stage_name = 'Closed Lost' THEN changed_at END) AS lost_at
	FROM {{ ref('stg_salesforce__opportunity_history') }}
	GROUP BY opportunity_id
),

opps AS (
	SELECT * FROM {{ ref('stg_salesforce__opportunities')}}
)

SELECT
	opps.opportunity_id,
	opps.account_id,
	opps.opportunity_type,
	opps.amount,
	stage_dates.discovery_at,
	stage_dates.proposal_at,
	stage_dates.negotiation_at,
	stage_dates.won_at,
	stage_dates.lost_at,
	opps.is_closed,
	opps.is_won
FROM opps
LEFT JOIN stage_dates
ON opps.opportunity_id = stage_dates.opportunity_id