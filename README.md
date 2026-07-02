# CVNA Gap-Up Research (2019–2024)

Exploratory SQL/Tableau analysis of positive gap-up events in CVNA daily
price data. The goal was to test whether gap formation follows any
structural pattern (frequency by year, size distribution) before
committing to a full backtest of a gap-trading strategy.

![Dashboard](CVNA_dashboard.png)

## Status

**Exploratory phase complete. Forward-return / edge testing not yet
implemented** — see [Next Steps](#next-steps). Numbers below describe
what this stage of the analysis supports, not a validated trading edge.

## Data

- Source: daily OHLC bars for CVNA, 2017–2025 (`CVNA.csv`)
- Analysis window: 2019-01-01 to 2024-12-31
- No indicators used — raw price action only

## Method

A gap-up day is defined as:

```
gap_pct = (open_t - close_{t-1}) / close_{t-1}
```

using `LAG()` over the ticker-partitioned, date-ordered series. Only
gap_pct >= 3% is treated as a "gap" for counting purposes; all gaps are
additionally bucketed into 3–5%, 5–7%, 7–10%, >10%.

## SQL

All queries read from a single base view instead of repeating the CTE:

| File | Purpose |
|---|---|
| `00_gaps_base_view.sql` | Base view: daily gap_pct + bucket, 2019–2024 |
| `01_gaps_3pct.sql` | All gap-up days (>=3%), full detail |
| `02_num_gaps_by_year.sql` | Gap count per calendar year |
| `03_gap_count_by_bucket.sql` | Gap count per size bucket |

Run `00_gaps_base_view.sql` once to create the view, then the rest can
be run independently.

## Findings (exploratory only)

- Gap-up frequency is not stable across years — it clusters in
  higher-volatility periods and is rare in calm regimes.
- Gap size distribution is skewed toward the 3–5% bucket; large gaps
  (>10%) are infrequent.
- No claim is made here about whether gaps are *tradable* — this stage
  only characterizes *when* and *how often* they occur.

## Dashboard

Built in Tableau (`CVNA_dash.twb`). Requires Tableau Desktop/Reader to
open interactively; a static screenshot is embedded above for anyone
without Tableau.

## Next Steps

- Forward returns at +2, +5, +10 trading days after each gap-up
- Compare forward returns across gap-size buckets
- Basic significance check (vs. random-day baseline) before drawing any
  conclusion about edge

## Tools

SQL (window functions, views), Tableau
