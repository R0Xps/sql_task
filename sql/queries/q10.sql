-- 10. **Popular Menu Item Analysis using Joins and Window Functions**: Identify the most popular menu item for each restaurant for a given month.
-- Assuming mo is the given month

WITH ItemRanksByMonth AS (
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