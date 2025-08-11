-- 14. **Stored Procedure - Add New Order**:
--     - **Procedure Name**: **`sp_AddNewOrder`**
--     - **Purpose**: Streamline the process of adding a new order.
--     - **Parameters**: **`ReservationId`**, **`EmployeeId`**, **`OrderDate`**, and **`TotalAmount`**.
--     - **Implementation**: Check if the specified reservation and employee exist, if not, return an error message, if existing, add new order.
--     - **Return**: The new **`OrderId`** or an error message.

-- NOTE: I used a function instead of a stored procedure as those do not return anything in PostgreSQL

CREATE OR REPLACE FUNCTION sp_AddNewOrder(ReservationId INT, EmployeeId INT, OrderDate TIMESTAMP, TotalAmount NUMERIC) RETURNS INT AS $$
    INSERT INTO Orders(OrderId, ReservationId, EmployeeId, OrderDate, TotalAmount)
    VALUES (NextOrderId(), ReservationId, EmployeeId, OrderDate, TotalAmount)
    RETURNING OrderId;
$$ LANGUAGE SQL;


-- Helper function to get the next OrderId

CREATE OR REPLACE FUNCTION NextOrderId() RETURNS INT AS $$
    SELECT MAX(OrderId) + 1
    FROM Orders;
$$ LANGUAGE SQL;