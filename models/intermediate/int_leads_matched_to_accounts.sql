SELECT
	lead_id,
	leads.email,
	leads.email_domain,
	email_domain IN (
		'gmail.com',
		'yahoo.com',
		'outlook.com',
		'hotmail.com',
		'icloud.com'
	) AS is_personal_email,
	COALESCE(leads.converted_account_id, accounts.account_id) AS account_id,
	CASE 
		WHEN leads.converted_account_id IS NOT NULL THEN 'converted'
		WHEN accounts.account_id IS NOT NULL THEN 'email_domain'
	END AS  match_method,
	ROW_NUMBER() OVER (PARTITION BY leads.email ORDER BY leads.created_at, leads.lead_id) > 1 AS is_duplicate_lead
FROM {{ ref('stg_salesforce__leads') }} leads
LEFT JOIN {{ ref('stg_salesforce__accounts')}} accounts
ON leads.email_domain = accounts.website
AND leads.email_domain NOT IN (
	'gmail.com',
	'yahoo.com',
	'outlook.com',
	'hotmail.com',
	'icloud.com'
)
