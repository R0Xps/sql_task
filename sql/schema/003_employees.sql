-- +goose Up
CREATE TABLE Employees (
    EmployeeId INT PRIMARY KEY,
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    FirstName TEXT,
    LastName TEXT,
    Position TEXT
);

-- +goose Down
DROP TABLE Employees;