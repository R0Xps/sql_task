-- 19. Query Plans Part2:
--     - Check the query plans for the 5 queries selected in Req #15 after adding some indexes.

-- Index creation/deletion queries are in the sql/schema directory
-- The following queries are the exact same as in q17.sql

-- 1. Query #8
EXPLAIN WITH OrdersCountByReservation AS (
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

-- 2. Query #9
EXPLAIN WITH ReservationsCounter AS (
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

-- 3. Query #10 (replace mo with a month number)
EXPLAIN WITH ItemRanksByMonth AS (
    SELECT rt.RestaurantId, DATE_PART('month', o.OrderDate) AS Month, mi.ItemId, SUM(oi.Quantity) AS TotalSales
    FROM Restaurants rt
    JOIN Reservations rv
    ON rt.RestaurantId = rv.RestaurantId
    JOIN Orders o
    ON rv.ReservationId = o.ReservationId
    JOIN OrderItems oi
    ON o.OrderId = oi.OrderId
    JOIN MenuItems mi
    ON oi.ItemId = mi.ItemId
    GROUP BY rt.RestaurantId, Month, mi.ItemId
    ORDER BY TotalSales DESC
)

SELECT RestaurantId, ItemId, TotalSales
FROM (
    SELECT RestaurantId, ItemId, TotalSales, RANK() OVER (PARTITION BY RestaurantId ORDER BY TotalSales DESC) AS Rank
    FROM ItemRanksByMonth
    WHERE Month = mo
)
WHERE Rank <= 1;

-- 4. Query #12 (replace eid with an employee id)
EXPLAIN SELECT TotalOrders * Rank
    FROM (
        SELECT COUNT(o.OrderId) AS TotalOrders, CASE e.Position WHEN 'VIPOrdersWaiter' THEN 5 WHEN 'StandardWaiter' THEN 4 WHEN 'AssistantWaiter' THEN 3 END AS Rank
        FROM Employees e
        JOIN Orders o
        ON e.EmployeeId = o.EmployeeId
        WHERE e.EmployeeId = eid
        GROUP BY Rank
);

-- 5. Query #15
EXPLAIN WITH FutureReservedTables AS (
    SELECT RestaurantId, TableId, ReservationDate
    FROM Reservations
    WHERE ReservationDate > NOW()
)
SELECT r.RestaurantId, r.Name AS RestaurantName, frt.TableId, frt.ReservationDate
FROM Restaurants r
JOIN FutureReservedTables frt
ON r.RestaurantId = frt.RestaurantId;