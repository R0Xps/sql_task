-- 7. Retrieve Employees details with Views: Use a view to list all employees information including their restaurants details

CREATE VIEW EmployeesDetails AS
    SELECT *
    FROM Employees e
    JOIN Restaurants r
    ON e.RestaurantId = r.RestaurantId;

SELECT * FROM EmployeesDetails;