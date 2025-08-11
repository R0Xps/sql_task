-- 1. List of Reservations: Retrieve all reservations for a specific customers.
-- Assuming cid is the desired CustomerId

SELECT *
FROM Reservations
WHERE CustomerId = cid;
