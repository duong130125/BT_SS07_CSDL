CREATE DATABASE QLBH;
CREATE TABLE Customer (
    cID INT PRIMARY KEY,
    Name VARCHAR(25),
    cAge TINYINT
);

CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    odQTY INT,
    FOREIGN KEY (oID) REFERENCES Orders(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

CREATE TABLE Orders (
    oID INT PRIMARY KEY,
    cID INT,
    oDate DATETIME,
    oTotalPrice INT,
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

CREATE TABLE Product (
    pID INT PRIMARY KEY,
    pName VARCHAR(25),
    pPrice INT
);

INSERT INTO Customer (cID, Name, cAge)
VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO Orders (oID, cID, oDate, oTotalPrice)
VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice)
VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY)
VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(3, 5, 4),
(2, 3, 3);

-- 2
SELECT oID, cID, oDate, oTotalPrice
FROM Orders
ORDER BY oDate DESC;
-- 3
SELECT pName, pPrice
FROM Product
WHERE pPrice = (SELECT MAX(pPrice) FROM Product);

-- 4
SELECT c.Name AS CustomerName, p.pName AS ProductName
FROM Customer c
JOIN Orders o ON c.cID = o.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;
-- 5
SELECT Name
FROM Customer
WHERE cID NOT IN (SELECT DISTINCT cID FROM Orders);
-- 6
SELECT o.oID, c.Name AS CustomerName, p.pName AS ProductName, od.odQTY
FROM Orders o
JOIN Customer c ON o.cID = c.cID
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID;
-- 7
SELECT o.oID, o.oDate, 
       SUM(od.odQTY * p.pPrice) AS TotalPrice
FROM Orders o
JOIN OrderDetail od ON o.oID = od.oID
JOIN Product p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
-- 8
ALTER TABLE Orders DROP FOREIGN KEY FK_Orders_Customer;
ALTER TABLE OrderDetail DROP FOREIGN KEY FK_OrderDetail_Orders;
ALTER TABLE OrderDetail DROP FOREIGN KEY FK_OrderDetail_Product;
ALTER TABLE Customer DROP PRIMARY KEY;
ALTER TABLE Orders DROP PRIMARY KEY;
ALTER TABLE Product DROP PRIMARY KEY;

