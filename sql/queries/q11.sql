-- 11. **Database Function - Calculate Restaurant Revenue**:
--     - **Function Name**: **`fn_CalculateRevenue`**
--     - **Purpose**: Compute revenue made by a specific restaurant.
--     - **Parameter**: `RestaurantId`
--     - **Return**: total revenue amount for the `RestaurantId`.

CREATE OR REPLACE FUNCTION fn_CalculateRevenue(RestaurantId INT) RETURNS NUMERIC AS $$
    SELECT SUM(o.TotalAmount)
    FROM Restaurants rt
    JOIN Reservations rv
    ON rt.RestaurantId = rv.RestaurantId
    JOIN Orders o
    ON rv.ReservationId = o.ReservationId
    WHERE rt.RestaurantId = fn_CalculateRevenue.RestaurantId;
$$ LANGUAGE SQL;