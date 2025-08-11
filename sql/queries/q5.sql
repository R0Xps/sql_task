-- 5. Calculate Average Order Amount: Calculate the average order amount made through a specific employee.
-- Assuming eid is the desired EmployeeId

SELECT AVG(TotalAmount) AS AvgAmount
FROM Orders
WHERE EmployeeId = eid;