-- How is ticket revenue trending month over month?
-- Concepts: window function running total, LAG()

WITH monthly AS (
    SELECT
        DATE_FORMAT(date_of_journey, '%Y-%m') AS journey_month,
        ROUND(SUM(price), 2) AS monthly_revenue
    FROM railway
    GROUP BY journey_month
)
SELECT
    journey_month,
    monthly_revenue,
    ROUND(SUM(monthly_revenue) OVER (ORDER BY journey_month), 2) AS cumulative_revenue,
    ROUND(
        monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY journey_month),
        2
    ) AS change_vs_prior_month
FROM monthly
ORDER BY journey_month;
