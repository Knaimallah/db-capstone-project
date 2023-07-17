## Create stored procedure 'AddBooking'

DELIMITER //

CREATE PROCEDURE AddBooking(IN BookingID INT, IN CustomerID INT, IN TableNumber INT, IN BookingDate DATE)
BEGIN 
INSERT INTO bookings (bookingid, customerid, tablenumber, date) VALUES (BookingID, CustomerID, TableNumber, BookingDate); 
SELECT "New booking added" AS "Confirmation";
END//

DELIMITER ; 

DROP PROCEDURE IF EXISTS AddBooking; 


CALL AddBooking(9, 3, 4, "2022-12-30");

## Create Stored Procedure 'UpdateBooking'

DELIMITER //

CREATE PROCEDURE UpdateBooking(IN Booking_ID INT, IN BookingDate DATE) 
BEGIN
UPDATE bookings SET date = BookingDate WHERE BookingID = Booking_ID; 
SELECT CONCAT("Booking ", Booking_ID, " updated") AS "Confirmation"; 
END//

DELIMITER ;

CALL UpdateBooking(9, "2022-12-17");

## Create stored procedure 'CancelBooking'

DROP PROCEDURE IF EXISTS CancelBooking; 

DELIMITER //

CREATE PROCEDURE CancelBooking(IN Booking_ID INT) 
BEGIN 
DELETE FROM bookings WHERE BookingID = Booking_ID; SELECT CONCAT("Booking ", Booking_ID, " cancelled") AS "Confirmation"; 
END//

DELIMITER ; 

CALL CancelBooking(9);


