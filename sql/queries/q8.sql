-- 8. **Reservation’s Order with CTEs**: Identify reservations which have 2 or more orders using CTEs.

WITH OrdersCountByReservation AS (
    SELECT r.ReservationId, COUNT(*) AS OrdersCount
    FROM Reservations r
    JOIN Orders o
    ON r.ReservationId = o.ReservationId
    GROUP BY r.ReservationId
)

SELECT r.*
FROM Reservations r
JOIN OrdersCountByReservation oc
ON r.ReservationId = oc.ReservationId
WHERE oc.OrdersCount >= 2;