SELECT
	id AS account_id,
	name,
	type,
	website,
	industry,
	segment_c AS segment,
	number_of_employees,
	annual_revenue,
	billing_country,
	parent_id,
	owner_id,
	created_date
FROM {{ source('salesforce', 'account')}}
WHERE not is_deleted