## Insert query

use LittleLemonDB;


INSERT INTO Bookings (bookingID ,Date, TableNumber, CustomerID)

VALUES 	(1,"2022-10-10", 5, 1),
		(2,"2022-11-12", 3, 3),
		(3,"2022-10-11", 2, 2),
		(4,"2022-10-13", 2, 1);
        
select * from bookings;
        
## Create Stored Procedure 'CheckBooking'

delimiter //

CREATE PROCEDURE CheckBooking(IN BookingDate DATE, IN Table_Number INT)
BEGIN
    SELECT CONCAT("Table ", Table_Number, " is already booked") AS Message
    FROM Bookings
    WHERE BookingDate = bookings.Date AND Table_Number = bookings.TableNumber;
END//

delimiter ;


CALL CheckBooking("2022-11-12", 3);


## Create procedure 'AddValidBooking'

DELIMITER //

CREATE FUNCTION Validate(RecordsFound INTEGER, message VARCHAR(255)) RETURNS INTEGER DETERMINISTIC
BEGIN
    IF RecordsFound IS NOT NULL OR RecordsFound > 0 THEN
        SIGNAL SQLSTATE 'ERR0R' SET MESSAGE_TEXT = message;
    END IF;
    RETURN RecordsFound;
END//

CREATE PROCEDURE AddValidBooking(IN BookingDate DATE, IN TableNumber INT)
	BEGIN
		DECLARE `_rollback` BOOL DEFAULT 0;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
		START TRANSACTION;
        
        SELECT Validate(COUNT(*), CONCAT("Table ", TableNumber, " is already booked"))
        FROM bookings
        WHERE date = BookingDate AND table_number = TableNumber;
        
		INSERT INTO bookings (date, table_number)
		VALUES (BookingDate, TableNumber);
		
		IF `_rollback` THEN
			SELECT CONCAT("Table ", TableNumber, " is already booked - booking cancelled") AS "Booking status";
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
    END//
    
DELIMITER ;

CALL AddValidBooking("2022-12-17", 6);