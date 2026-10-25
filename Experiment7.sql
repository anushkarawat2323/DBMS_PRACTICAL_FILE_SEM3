-- AIM: To identify functional dependencies in a denormalized Sales table and normalize it step-by-step from UNF to 1NF, 2NF, 3NF and BCNF, and verify lossless join
-- and dependency preservation using SQL queries.
  CREATE TABLE Sales_UNF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(40),
    Products VARCHAR(100),
    Quantities VARCHAR(50),
    Prices VARCHAR(50)
);

INSERT INTO Sales_UNF VALUES
(101,1,'Aarav','Laptop,Mouse','1,2','50000,800'),
(102,2,'Riya','Keyboard,Mouse','1,1','1500,800');

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(40)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(40),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Customer VALUES
(1,'Aarav'),(2,'Riya');

INSERT INTO Product VALUES
(1,'Laptop',50000),
(2,'Mouse',800),
(3,'Keyboard',1500);

INSERT INTO Orders VALUES
(101,1),(102,2);

INSERT INTO OrderDetails VALUES
(101,1,1),(101,2,2),
(102,3,1),(102,2,1);

SELECT * FROM Sales_UNF;

SELECT o.OrderID,c.CustomerName,p.ProductName,od.Quantity,p.Price
FROM Orders o
JOIN Customer c ON o.CustomerID=c.CustomerID
JOIN OrderDetails od ON o.OrderID=od.OrderID
JOIN Product p ON od.ProductID=p.ProductID;

SELECT OrderID,CustomerID FROM Orders;

SELECT CustomerID,CustomerName FROM Customer;

SELECT ProductID,ProductName,Price FROM Product;

SELECT OrderID,ProductID,Quantity FROM OrderDetails;
