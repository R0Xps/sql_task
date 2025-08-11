-- +goose Up
CREATE TABLE MenuItems (
    ItemId INT PRIMARY KEY,
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    Name TEXT,
    Description TEXT,
    Price NUMERIC(10, 2)
);

-- +goose Down
DROP TABLE MenuItems;