-- 6. Retrieve Reservations Report with Views: Use a view to list all reservations information including restaurants and customers information.

CREATE VIEW ReservationsReport AS
    SELECT *
    FROM Reservations rv
    JOIN Restaurants rt
    ON rv.RestaurantId = rt.RestaurantId
    JOIN Customers c
    ON rv.CustomerId = c.CustomerId;

SELECT * FROM ReservationsReport;