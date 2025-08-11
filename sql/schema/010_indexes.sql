-- +goose Up

-- 1. ReservationId in Orders table
CREATE INDEX idx_orders_reservationid ON Orders(ReservationId);

-- 2. RestaurantId in Reservations table
CREATE INDEX idx_reservations_restaurantid ON Reservations(RestaurantId);

-- 3. OrderId in OrderItems table
CREATE INDEX idx_orderitems_orderid ON OrderItems(OrderId);

-- 4. ItemId in OrderItems table
CREATE INDEX idx_orderitems_itemid ON OrderItems(ItemId);

-- 5. EmployeeId in Orders table
CREATE INDEX idx_orders_employeeid ON Orders(EmployeeId);

-- 6. ReservationDate in Reservations table
CREATE INDEX idx_reservations_reservationdate ON Reservations(ReservationDate);


-- +goose Down

-- 1.
DROP INDEX idx_orders_reservationid;

-- 2.
DROP INDEX idx_reservations_restaurantid;

-- 3.
DROP INDEX idx_orderitems_orderid;

-- 4.
DROP INDEX idx_orderitems_itemid;

-- 5.
DROP INDEX idx_orders_employeeid;

-- 6.
DROP INDEX idx_reservations_reservationdate;