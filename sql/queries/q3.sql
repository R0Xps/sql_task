-- 3. List of Orders and Menu Items: Lists the orders placed on a specific given reservation along with the associated menu items.
-- Assuming rid is the desired ReservationId

SELECT *
FROM Orders o
JOIN OrderItems oi
ON o.OrderId = oi.OrderId
JOIN MenuItems mi
ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = rid;
