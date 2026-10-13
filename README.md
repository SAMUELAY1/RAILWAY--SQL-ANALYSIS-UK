# uk-rail-sql-analysis
This is an SQL analysis made based on the railway raw  data to get insights on trains schedules and routes 

## UK Rail Journey Analysis (SQL)

SQL analysis of UK train journey data, exploring route reliability, revenue 
trends, ticket pricing anomalies, and refund patterns. Built to practice 
intermediate SQL  window functions, CTEs, and correlated vs. JOIN-based 
approaches to the same problem.

## Dataset

UK Train Rides 
(Kaggle) — 31,653 UK rail journeys, Jan–Apr 2024, covering ticket purchases, 
journey status, delay reasons, and refund requests.

## Repository structure

├── sql/
│   ├── 01_schema.sql
│   ├── 02_top_delayed_routes.sql
│   ├── 03_monthly_revenue_trend.sql
│   ├── 04_above_average_priced_tickets.sql
│   └── 05_refund_rate_by_delay_reason.sql
├── data/
│   └── railway.csv
└── README.md

## Setup (MySQL)

1. Run `sql/01_schema.sql` to create the `uk_rail` database and `railway` table.
2. In MySQL Workbench, right-click the `railway` table, choose **Table Data Import Wizard**, select `data/railway.csv` and run the import.
3. Run the index command at the bottom of `sql/01_schema.sql`. This is required for query 04 to finish in a reasonable time (see the note in that file).
4. Run any query in `sql/` from a Workbench SQL tab.

## Analysis

| File | Question | SQL concepts |
|------|----------|--------------|
| [sql/02_top_delayed_routes.sql](sql/02_top_delayed_routes.sql) | Which routes have the worst delay/cancellation record, ranked? | CTE, `RANK()` window function |
| [sql/03_monthly_revenue_trend.sql](sql/03_monthly_revenue_trend.sql) | How is revenue trending month over month? | Running total window function, `LAG()` |
| [sql/04_above_average_priced_tickets.sql](sql/04_above_average_priced_tickets.sql) | Which tickets are priced well above the norm for their route? | CTE + `JOIN` (rewritten from a correlated subquery for performance, see note in file) |
| [sql/05_refund_rate_by_delay_reason.sql](sql/05_refund_rate_by_delay_reason.sql) | Which delay reasons trigger the most refund requests? | Aggregation, `HAVING`, conditional `SUM` |

## Findings

- 31,653 journeys analysed (Jan–Apr 2024).
- Several routes with lower overall journey counts showed a 100% disruption 
- rate  worth treating with some caution given smaller sample sizes 
- Technical Issue delays had the highest refund rate (54.9%), followed by 



Next steps

- The reason_for_delay column has inconsistent capitalisation for the same 
- underlying categories (e.g. "Signal Failure" vs "Signal failure") a 
- CASE based cleaning step before aggregating in query 05 would sharpen 
- those numbers further.
- Segment disruption rate by railcard type or ticket class.
- Add a simple chart for the monthly revenue trend.
