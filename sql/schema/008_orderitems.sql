-- +goose Up
CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY,
    OrderId INT REFERENCES Orders(OrderId),
    ItemId INT REFERENCES MenuItems(ItemId),
    Quantity INT
);

-- +goose Down
DROP TABLE OrderItems;