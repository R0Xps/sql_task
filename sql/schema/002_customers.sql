-- +goose Up
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    Email TEXT,
    PhoneNumber TEXT
);

-- +goose Down
DROP TABLE Customers;