WITH mql_from_history AS (
	SELECT
		lead_id,
		MIN(changed_at) AS mql_at
	FROM {{ ref('stg_salesforce__lead_history') }}
	WHERE field = 'Status'
	AND new_value = 'MQL'
	GROUP BY lead_id
),

leads AS (
	SELECT * FROM {{ ref('stg_salesforce__leads') }}
)

SELECT
	leads.lead_id,
	leads.created_at,
	COALESCE(mql_from_history.mql_at, leads.mql_at) AS mql_at,
	leads.sql_at,
	CASE 
		WHEN mql_from_history.mql_at IS NOT NULL THEN 'lead_history'
		WHEN leads.mql_at IS NOT NULL THEN 'mql_date_field'
	END AS mql_at_source
FROM leads
LEFT JOIN mql_from_history
ON leads.lead_id = mql_from_history.lead_id
