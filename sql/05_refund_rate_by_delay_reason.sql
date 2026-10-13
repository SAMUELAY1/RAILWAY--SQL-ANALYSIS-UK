-- Which delay reasons trigger the most refund requests?
-- Concepts: aggregation, HAVING, conditional SUM via CASE

SELECT
    reason_for_delay,
    COUNT(*) AS total_disrupted_journeys,
    SUM(CASE WHEN refund_request = 'Yes' THEN 1 ELSE 0 END) AS refunds_requested,
    ROUND(
        100.0 * SUM(CASE WHEN refund_request = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        1
    ) AS refund_rate_pct
FROM railway
WHERE journey_status IN ('Delayed', 'Cancelled')
  AND reason_for_delay != ''
GROUP BY reason_for_delay
HAVING COUNT(*) >= 5
ORDER BY refund_rate_pct DESC;
