-- +goose Up

-- 1) RESTAURANTS (50 records)
INSERT INTO Restaurants (RestaurantId, Name, Address, PhoneNumber, OpeningHours)
SELECT gs,
       'Restaurant ' || gs,
       'Address ' || gs || ', Cityville',
       '+1-555-' || LPAD(gs::text, 4, '0'),
       '09:00-22:00'
FROM generate_series(1, 50) gs;

-- 2) CUSTOMERS (400 records)
INSERT INTO Customers (CustomerId, FirstName, LastName, Email, PhoneNumber)
SELECT gs,
       'FirstName' || gs,
       'LastName' || gs,
       'customer' || gs || '@mail.com',
       '+1-555-' || LPAD((1000 + gs)::text, 4, '0')
FROM generate_series(1, 400) gs;

-- 3) EMPLOYEES (100 employees, random positions)
INSERT INTO Employees (EmployeeId, RestaurantId, FirstName, LastName, Position)
SELECT gs,
       ((gs - 1) % 50) + 1,
       'EmpFirst' || gs,
       'EmpLast' || gs,
       (ARRAY['Chef','Waiter','Manager','Host'])[floor(random()*4 + 1)]
FROM generate_series(1, 100) gs;

-- 4) MENU ITEMS (1000 items)
INSERT INTO MenuItems (ItemId, RestaurantId, Name, Description, Price)
SELECT gs,
       ((gs - 1) % 50) + 1,
       'Menu Item ' || gs,
       'Delicious food item number ' || gs,
       round((random() * 30 + 5)::numeric, 2)
FROM generate_series(1, 1000) gs;

-- 5) TABLES (100 tables, random capacity between 2 and 8)
INSERT INTO Tables (TableId, RestaurantId, Capacity)
SELECT gs,
       ((gs - 1) % 50) + 1,  -- Distribute across restaurants
       (random() * 6 + 2)::int
FROM generate_series(1, 100) gs;

-- 6) RESERVATIONS (500 records)
INSERT INTO Reservations (ReservationId, CustomerId, RestaurantId, TableId, ReservationDate, PartySize)
SELECT gs,
       ((gs - 1) % 400) + 1,
       ((gs - 1) % 50) + 1,
       ((gs - 1) % 100) + 1,
       NOW() - (random() * INTERVAL '30 days'),
       (random() * 5 + 1)::int
FROM generate_series(1, 500) gs;

-- 7) ORDERS (500 orders)
INSERT INTO Orders (OrderId, ReservationId, EmployeeId, OrderDate, TotalAmount)
SELECT gs,
       ((gs - 1) % 500) + 1,
       ((gs - 1) % 100) + 1,
       NOW() - (random() * INTERVAL '30 days'),
       0  -- Will update after inserting order items
FROM generate_series(1, 500) gs;

-- 8) ORDER ITEMS (1500 order items)
INSERT INTO OrderItems (OrderItemId, OrderId, ItemId, Quantity)
SELECT gs,
       ((gs - 1) % 500) + 1,
       ((gs - 1) % 1000) + 1,
       (random() * 4 + 1)::int
FROM generate_series(1, 1500) gs;

-- 9) UPDATE total amounts in orders
UPDATE Orders o
SET TotalAmount = sub.sum_price
FROM (
    SELECT oi.OrderId, SUM(oi.Quantity * mi.Price) AS sum_price
    FROM OrderItems oi
    JOIN MenuItems mi ON oi.ItemId = mi.ItemId
    GROUP BY oi.OrderId
) sub
WHERE o.OrderId = sub.OrderId;


-- +goose Down
DELETE FROM OrderItems;
DELETE FROM Orders;
DELETE FROM Reservations;
DELETE FROM Tables;
DELETE FROM MenuItems;
DELETE FROM Employees;
DELETE FROM Customers;
DELETE FROM Restaurants;