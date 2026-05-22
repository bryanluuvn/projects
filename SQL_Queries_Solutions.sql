-- SQL Less_1 - QUERIES SOLUTIONS
-- Các câu truy vấn cho các yêu cầu phân tích dữ liệu bán hàng

USE SalesTraining;
GO

-- 1. TỔNG DOANH THU KHÁCH HÀNG
-- Hiển thị tổng doanh thu từng khách hàng
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Phone,
    c.Email,
    c.City,
    SUM(o.TotalAmount) AS TotalRevenue
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Phone, c.Email, c.City
ORDER BY TotalRevenue DESC;

GO

-- 2. TOP KHÁCH HÀNG (Top 3 khách hàng có doanh thu cao nhất)
SELECT TOP 3
    c.CustomerID,
    c.CustomerName,
    c.City,
    COUNT(o.OrderID) AS NumberOfOrders,
    SUM(o.TotalAmount) AS TotalRevenue,
    AVG(o.TotalAmount) AS AvgOrderValue
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City
ORDER BY TotalRevenue DESC;

GO

-- 3. SẢN PHẨM BÁN CHẠY (Sản phẩm được đặt hàng nhiều nhất)
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,
    p.Price,
    SUM(oi.Quantity) AS TotalQuantitySold,
    COUNT(DISTINCT oi.OrderID) AS NumberOfOrders,
    SUM(oi.LineAmount) AS TotalRevenue
FROM Products p
INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category, p.Price
ORDER BY TotalQuantitySold DESC;

GO

-- 4. DOANH THU THEO DANH MỤC
-- Hiển thị tổng doanh thu từng danh mục sản phẩm
SELECT 
    p.Category,
    COUNT(DISTINCT p.ProductID) AS NumberOfProducts,
    SUM(oi.Quantity) AS TotalQuantitySold,
    SUM(oi.LineAmount) AS CategoryRevenue,
    AVG(p.Price) AS AvgProductPrice
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.Category
ORDER BY CategoryRevenue DESC;

GO

-- 5. KHÁCH HÀNG CHI TIÊU THẤP (Khách hàng có doanh thu dưới 10 triệu)
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    c.Email,
    COUNT(o.OrderID) AS NumberOfOrders,
    SUM(o.TotalAmount) AS TotalSpending
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City, c.Email
HAVING SUM(o.TotalAmount) < 10000000 OR SUM(o.TotalAmount) IS NULL
ORDER BY TotalSpending;

GO

-- 6. KHÁCH HÀNG MUA AIRPODS PRO
-- Hiển thị danh sách khách hàng đã mua sản phẩm AirPods Pro
SELECT DISTINCT
    c.CustomerID,
    c.CustomerName,
    c.Phone,
    c.Email,
    c.City,
    p.ProductName,
    oi.Quantity AS QuantityPurchased,
    oi.LineAmount,
    o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE p.ProductName = 'AirPods Pro'
ORDER BY o.OrderDate DESC;

GO
