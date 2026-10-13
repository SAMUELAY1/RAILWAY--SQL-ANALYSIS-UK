-- Which routes have the worst delay/cancellation record, ranked?
-- Concepts: CTE, PARTITION-free window function, RANK()

WITH route_stats AS (
    SELECT
        departure_station,
        arrival_destination,
        COUNT(*) AS total_journeys,
        SUM(CASE WHEN journey_status IN ('Delayed', 'Cancelled') THEN 1 ELSE 0 END) AS disrupted_journeys,
        ROUND(
            100.0 * SUM(CASE WHEN journey_status IN ('Delayed', 'Cancelled') THEN 1 ELSE 0 END) / COUNT(*),
            1
        ) AS disruption_rate_pct
    FROM railway
    GROUP BY departure_station, arrival_destination
    HAVING COUNT(*) >= 10
)
SELECT
    departure_station,
    arrival_destination,
    total_journeys,
    disrupted_journeys,
    disruption_rate_pct,
    RANK() OVER (ORDER BY disruption_rate_pct DESC) AS disruption_rank
FROM route_stats
ORDER BY disruption_rank
LIMIT 15;
