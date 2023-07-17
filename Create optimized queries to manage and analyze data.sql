## Create Stored Procedure 'GetMaxQuantity'

use LittleLemonDB;
drop procedure if exists GetMaxQuantity;
create procedure GetMaxQuantity() select max(Quantity) as GetMaxQuantity from Orders;
call GetMaxQuantity();


## Create a prepared statement

prepare GetOrderDetail from 'select OrderID, Quantity, TotalCost from Orders where OrderID=?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

## Create stored procedure 'CancelOrder'

delimiter //
create procedure CancelOrder(Orderid int) 
begin
delete from Orders where OrderID=Orderid;
select concat("Order ", OrderID, " is cancelled") as Confirmation;
end//
delimiter ;

call CancelOrder(5);
