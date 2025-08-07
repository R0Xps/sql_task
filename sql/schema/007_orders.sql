-- +goose Up
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    ReservationId INT REFERENCES Reservations(ReservationId),
    EmployeeId INT REFERENCES Employees(EmployeeId),
    OrderDate TIMESTAMP,
    TotalAmount NUMERIC(10, 2)
);

-- +goose Down
DROP TABLE Orders;