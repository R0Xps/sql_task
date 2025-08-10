-- +goose Up
CREATE TABLE AuditLog (
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    TableId INT REFERENCES Tables(TableId),
    ReservationDate TIMESTAMP,
    ChangeDate TIMESTAMP
);

-- +goose Down
DROP TABLE AuditLog;