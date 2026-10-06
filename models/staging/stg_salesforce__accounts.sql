SELECT
	id AS account_id,
	website,
	segment_c AS segment,
	type
FROM {{ source('salesforce', 'account')}}
WHERE not is_deleted