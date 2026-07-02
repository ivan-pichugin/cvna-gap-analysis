-- All gap-up days with gap_pct >= 3%
-- Source: gaps_base view (see 00_gaps_base_view.sql)

SELECT *
FROM gaps_base
WHERE gap_pct >= 0.03
ORDER BY date;
