-- Number of gap-up events (>= 3%) per calendar year
-- Source: gaps_base view (see 00_gaps_base_view.sql)

SELECT
    EXTRACT(YEAR FROM date) AS year,
    COUNT(*)                AS num_gaps
FROM gaps_base
WHERE gap_pct >= 0.03
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;
