WITH leads AS (
SELECT
	lead_id,
	account_id,
	segment,
	lead_source,
	'lead' AS from_stage,
	'mql' AS to_stage,
	created_at AS entered_from_at,
	mql_at AS entered_to_at
FROM {{ ref('int_funnel_spine') }}
WHERE created_at IS NOT NULL
),

mqls AS (
SELECT
	lead_id,
	account_id,
	segment,
	lead_source,
	'mql' AS from_stage,
	'sql' AS to_stage,
	mql_at AS entered_from_at,
	sql_at AS entered_to_at
FROM {{ ref('int_funnel_spine') }}
WHERE mql_at IS NOT NULL
),

sqls AS (
SELECT
	lead_id,
	account_id,
	segment,
	lead_source,
	'sql' AS from_stage,
	'opportunity' AS to_stage,
	sql_at AS entered_from_at,
	opportunity_created_at AS entered_to_at
FROM {{ ref('int_funnel_spine') }}
WHERE sql_at IS NOT NULL
),

opportunities AS (
SELECT
	lead_id,
	account_id,
	segment,
	lead_source,
	'opportunity' AS from_stage,
	'won' AS to_stage,
	opportunity_created_at AS entered_from_at,
	won_at AS entered_to_at
FROM {{ ref('int_funnel_spine') }}
WHERE opportunity_created_at IS NOT NULL
),

combined AS (
SELECT * FROM leads
UNION ALL
SELECT * FROM mqls
UNION ALL
SELECT * FROM sqls
UNION ALL
SELECT * FROM opportunities
)

SELECT
	CONCAT(lead_id, '-', from_stage) AS funnel_transition_id,
	lead_id,
	account_id,
	segment,
	lead_source,
	from_stage,
	to_stage,
	entered_from_at,
	entered_to_at,
	entered_to_at IS NOT NULL AS advanced,
	DATE_DIFF('day', entered_from_at, entered_to_at) AS days_to_advance,
	DATE_DIFF('day', entered_from_at, DATE '{{ var("as_of_date") }}' ) AS days_since_entered
FROM combined


