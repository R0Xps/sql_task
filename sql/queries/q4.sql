-- 4. List of Ordered Menu Items: Lists the menu items ordered by a specific reservation.
-- Assuming rid is the desired ReservationId

SELECT mi.*
FROM Orders o
JOIN OrderItems oi
ON o.OrderId = oi.OrderId
JOIN MenuItems mi
ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = rid;