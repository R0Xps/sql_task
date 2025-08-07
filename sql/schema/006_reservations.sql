-- +goose Up
CREATE TABLE Reservations (
    ReservationId INT PRIMARY KEY,
    CustomerId INT REFERENCES Customers(CustomerId),
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    TableId INT REFERENCES Tables(TableId),
    ReservationDate TIMESTAMP,
    PartySize INT
);

-- +goose Down
DROP TABLE Reservations;