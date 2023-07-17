## Create OrdersView virtual table

CREATE VIEW OrdersView AS
    SELECT 
        orderid, quantity, totalcost
    FROM
        Orders
    WHERE
        quantity > '2';

## Create Join table

SELECT 
    customers.CustomerID,
    customers.name,
    orders.OrderID,
    orders.totalcost,
    menus.Name,
    menuitems.Course,
    menuitems.Starter
FROM
    orders
        LEFT JOIN
    customers ON customers.CustomerID = orders.CustomerID
        LEFT JOIN
    menus ON menus.MenuID = orders.MenuID
        LEFT JOIN
    menucontent ON menucontent.MenuID = menus.MenuID
        LEFT JOIN
    menuitems ON menuitems.MenuItemID = menucontent.MenuItemID
WHERE
    orders.TotalCost > 150;

## Create subquery

SELECT 
    menus.name AS 'Menu Name'
FROM
    menus
WHERE
    menuid = ANY (SELECT 
            menuid
        FROM
            orders
        WHERE
            quantity > 2);

