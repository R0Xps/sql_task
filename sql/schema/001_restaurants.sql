-- +goose Up
CREATE TABLE Restaurants (
    RestaurantId INT PRIMARY KEY,
    Name TEXT,
    Address TEXT,
    PhoneNumber TEXT,
    OpeningHours TEXT
);

-- +goose Down
DROP TABLE Restaurants;