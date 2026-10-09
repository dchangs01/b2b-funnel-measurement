-- Fails if any deal reached a stage before an earlier one,
-- or is somehow both won and lost
SELECT *
FROM {{ ref('int_opportunity_stage_dates') }}
WHERE proposal_at < discovery_at
   OR negotiation_at < proposal_at
   OR won_at < COALESCE(negotiation_at, proposal_at, discovery_at)
   OR lost_at < discovery_at
   OR (won_at IS NOT NULL AND lost_at IS NOT NULL)