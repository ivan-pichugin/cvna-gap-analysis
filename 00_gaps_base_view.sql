-- ============================================================
-- gaps_base: base view for CVNA gap-up analysis (2019–2024)
-- Computes daily gap % vs previous close and assigns a bucket.
-- All downstream queries SELECT from this view instead of
-- redefining the CTE each time.
-- ============================================================

CREATE OR REPLACE VIEW gaps_base AS
WITH gaps AS (
    SELECT
        date::date AS date,
        ticker,
        open,
        close,
        prev_close,
        (open - prev_close) / prev_close AS gap_pct
    FROM (
        SELECT
            *,
            LAG(close) OVER (
                PARTITION BY ticker
                ORDER BY date::date
            ) AS prev_close
        FROM cvna
    ) t
    WHERE prev_close IS NOT NULL
)
SELECT
    *,
    CASE
        WHEN gap_pct >= 0.03 AND gap_pct < 0.05 THEN '3–5%'
        WHEN gap_pct >= 0.05 AND gap_pct < 0.07 THEN '5–7%'
        WHEN gap_pct >= 0.07 AND gap_pct < 0.10 THEN '7–10%'
        WHEN gap_pct >= 0.10                    THEN '>10%'
        ELSE 'below_3%'
    END AS gap_bucket
FROM gaps
WHERE date >= DATE '2019-01-01'
  AND date <  DATE '2025-01-01';
