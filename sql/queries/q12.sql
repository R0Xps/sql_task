-- 12. **Database Function - Calculate Employees Salary**:
--     - **Function Name**: **`fn_CalculateEmployeeSalary`**
--     - **Purpose**: Compute the salary for a given employee.
--     - **Parameter**: `EmployeeId`
--     - **Implementation**: Salary is defined as: # number of orders made by specific employee * employee rank.
--         - Employee’s rank based on position: Position = `VIPOrdersWaiter` = 5, `StandardWaiter` = 4, `AssistantWaiter`  = 3.
--     - **Return**: salary for the `EmployeeId`.

CREATE OR REPLACE FUNCTION fn_CalculateEmployeeSalary(EmployeeId INT) RETURNS INT AS $$
    SELECT TotalOrders * Rank
    FROM (
        SELECT COUNT(o.OrderId) AS TotalOrders, CASE e.Position WHEN 'VIPOrdersWaiter' THEN 5 WHEN 'StandardWaiter' THEN 4 WHEN 'AssistantWaiter' THEN 3 END AS Rank
        FROM Employees e
        JOIN Orders o
        ON e.EmployeeId = o.EmployeeId
        WHERE e.EmployeeId = fn_CalculateEmployeeSalary.EmployeeId
        GROUP BY Rank
    );
$$ LANGUAGE SQL;