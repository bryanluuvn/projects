
-- SQL Less_1
CREATE DATABASE SalesTraining;
GO

USE SalesTraining;
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerName, Phone, Email, City) VALUES
('Nguyen Van A', '0901111111', 'a@gmail.com', 'Hanoi'),
('Tran Thi B', '0902222222', 'b@gmail.com', 'HCM'),
('Le Van C', '0903333333', 'c@gmail.com', 'Danang'),
('Pham Thi D', '0904444444', 'd@gmail.com', 'Hanoi'),
('Hoang Van E', '0905555555', 'e@gmail.com', 'HCM'),
('Vo Thi F', '0906666666', 'f@gmail.com', 'Can Tho');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductName, Category, Price) VALUES
('iPhone 15', 'Electronics', 25000000),
('Samsung S23', 'Electronics', 21000000),
('Macbook Air M2', 'Electronics', 32000000),
('AirPods Pro', 'Electronics', 5500000),
('Nike Shoes', 'Fashion', 3500000),
('Adidas Jacket', 'Fashion', 2800000),
('Sony WH-1000XM5', 'Electronics', 9000000);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-01-05', 25000000),
(1, '2024-02-10', 5500000),
(2, '2024-01-12', 32000000),
(2, '2024-03-22', 9000000),
(3, '2024-01-30', 3500000),
(4, '2024-02-14', 21000000),
(5, '2024-02-18', 2800000),
(6, '2024-03-05', 9000000);

CREATE TABLE OrderItems (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    LineAmount DECIMAL(12,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderItems (OrderID, ProductID, Quantity, LineAmount) VALUES
(1, 1, 1, 25000000),
(2, 4, 1, 5500000),
(3, 3, 1, 32000000),
(4, 7, 1, 9000000),
(5, 5, 1, 3500000),
(6, 2, 1, 21000000),
(7, 6, 1, 2800000),
(8, 7, 1, 9000000);
