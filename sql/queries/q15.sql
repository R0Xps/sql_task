-- 15. **SQL Stored Procedure with Temp Table**:
--     - Design a stored procedure that retrieves all tables which have future reservations.
--     - Store these tables in a temporary table, then join this temp table with the **`Restaurants`** table to list out the specific information about the associated restaurants.

-- NOTE: I used a function instead of a stored procedure as those do not return anything in PostgreSQL

CREATE OR REPLACE FUNCTION fn_GetTablesWithFutureReservations() RETURNS TABLE (
    RestaurantId INT,
    RestaurantName TEXT,
    TableId INT,
    ReservationDate TIMESTAMP
) AS $$
    WITH FutureReservedTables AS (
        SELECT RestaurantId, TableId, ReservationDate
        FROM Reservations
        WHERE ReservationDate > NOW()
    )
    SELECT r.RestaurantId, r.Name AS RestaurantName, frt.TableId, frt.ReservationDate
    FROM Restaurants r
    JOIN FutureReservedTables frt
    ON r.RestaurantId = frt.RestaurantId
$$ LANGUAGE SQL;