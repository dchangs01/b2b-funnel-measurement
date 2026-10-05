select
    id as lead_id,
    lower(email) as email,
    split_part(lower(email), '@', 2) as email_domain,
    company,
    status,
    lead_source,
    is_converted,
    converted_account_id,
    created_date as created_at,
    mql_date_c as mql_at_field,
    sql_date_c as sql_at
from {{ source('salesforce', 'lead') }}
where not is_deleted