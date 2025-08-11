-- 16. **Trigger Implementation**
--     - Design a trigger to log an entry into a separate **`AuditLog`** table whenever a table get reserved.
--     - The **`AuditLog`** should capture `ResturantId`, `TableId`, `ReservationDate` and **`ChangeDate`**.

CREATE OR REPLACE TRIGGER LogReservation
    AFTER INSERT ON Reservations
    FOR EACH ROW
    EXECUTE FUNCTION fn_LogReservation();

CREATE OR REPLACE FUNCTION fn_LogReservation() RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO AuditLog (RestaurantId, TableId, ReservationDate, ChangeDate)
        VALUES (NEW.RestaurantId, NEW.TableId, NEW.ReservationDate, NOW());
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;