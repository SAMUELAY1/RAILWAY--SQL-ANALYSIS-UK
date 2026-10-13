-- Which tickets were priced above the average for their specific route?
-- Concepts: CTE, JOIN
--
-- Note: an earlier version of this query used a correlated subquery
-- (recalculating the route average separately for every single row).
-- On the full 31,653-row table that timed out, because MySQL was
-- re-running the average calculation once per row instead of once per
-- route. This version computes each route's average ONCE in a CTE,
-- then joins it back -- same result, far fewer calculations.
--
-- Requires: CREATE INDEX idx_route ON railway (departure_station, arrival_destination);

WITH route_avg AS (
    SELECT
        departure_station,
        arrival_destination,
        ROUND(AVG(price), 2) AS route_avg_price
    FROM railway
    GROUP BY departure_station, arrival_destination
)
SELECT
    j.transaction_id,
    j.departure_station,
    j.arrival_destination,
    j.ticket_class,
    j.ticket_type,
    j.price,
    r.route_avg_price
FROM railway j
JOIN route_avg r
    ON r.departure_station = j.departure_station
    AND r.arrival_destination = j.arrival_destination
WHERE j.price > r.route_avg_price
ORDER BY (j.price - r.route_avg_price) DESC
LIMIT 20;
