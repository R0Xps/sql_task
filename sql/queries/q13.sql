-- 13. **Stored Procedure - Borrowed Books Report**:
--     - **Procedure Name**: **`sp_ReservedTablesReport`**
--     - **Purpose**: Generate a report of tables reserved within a specified date range.
--     - **Parameters**: **`StartDate`**, **`EndDate`**
--     - **Implementation**: Retrieve all tables reserved within the given range, with details like reservation date, party size and restaurant details.
--     - **Return**: Tabulated report of reserved tables.

-- NOTE: I used a function instead of a stored procedure as those do not return anything in PostgreSQL

CREATE OR REPLACE FUNCTION sp_ReservedTablesReport(StartDate TIMESTAMP, EndDate TIMESTAMP) RETURNS TABLE (
    RestaurantId INT,
    RestaurantName TEXT,
    ReservationId INT,
    ReservationDate TIMESTAMP,
    CustomerId INT,
    PartySize INT,
    TableId INT
) AS $$
    SELECT rt.RestaurantId, rt.Name AS RestaurantName, rv.ReservationId, rv.ReservationDate, rv.CustomerId, rv.PartySize, rv.TableId
    FROM Restaurants rt
    JOIN Reservations rv
    ON rt.RestaurantId = rv.RestaurantId
    WHERE rv.ReservationDate BETWEEN StartDate AND EndDate;
$$ LANGUAGE SQL;