-- Distribution of gap-up events across size buckets
-- Source: gaps_base view (see 00_gaps_base_view.sql)

SELECT
    gap_bucket,
    COUNT(*) AS num_gaps
FROM gaps_base
WHERE gap_bucket <> 'below_3%'
GROUP BY gap_bucket
ORDER BY gap_bucket;
