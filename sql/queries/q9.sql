-- 9. **Restaurant Popularity using Aggregation**: Rank restaurants by the reservation frequency.

WITH ReservationsCounter AS (
    SELECT rs.RestaurantId, COUNT(rv.ReservationId) AS ReservationCount
    FROM Restaurants rs
    LEFT JOIN Reservations rv
    ON rs.RestaurantId = rv.RestaurantId
    GROUP BY rs.RestaurantId
)

SELECT r.*, rc.ReservationCount
FROM Restaurants r
JOIN ReservationsCounter rc
ON r.RestaurantId = rc.RestaurantId
ORDER BY rc.ReservationCount DESC;