SELECT
	id AS account_id,
	name AS account_name,
	type AS account_type,
	LOWER(TRIM(website)) AS website,
	industry,
	segment_c AS segment,
	number_of_employees,
	annual_revenue,
	billing_country,
	parent_id,
	owner_id,
	created_date AS created_at
FROM {{ source('salesforce', 'account')}}
WHERE NOT is_deleted