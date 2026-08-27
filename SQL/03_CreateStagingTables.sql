USE RetailSalesDW;
GO

IF OBJECT_ID('stg.Customers','U') IS NOT NULL DROP TABLE stg.Customers;
IF OBJECT_ID('stg.Products','U') IS NOT NULL DROP TABLE stg.Products;
IF OBJECT_ID('stg.Sales','U') IS NOT NULL DROP TABLE stg.Sales;
IF OBJECT_ID('stg.RejectedSales','U') IS NOT NULL DROP TABLE stg.RejectedSales;
GO

CREATE TABLE stg.Customers
(
    CustomerID VARCHAR(20),
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Email VARCHAR(150)
);
GO

CREATE TABLE stg.Products
(
    ProductID VARCHAR(20),
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(18,2)
);
GO

CREATE TABLE stg.Sales
(
    SaleID VARCHAR(20),
    CustomerID VARCHAR(20),
    ProductID VARCHAR(20),
    SaleDate DATE,
    Quantity INT
);
GO

CREATE TABLE stg.RejectedSales
(
    SaleID VARCHAR(20),
    CustomerID VARCHAR(20),
    ProductID VARCHAR(20),
    SaleDate VARCHAR(50),
    Quantity VARCHAR(50),
    ErrorReason VARCHAR(500),
    RejectedDate DATETIME DEFAULT GETDATE()
);
GO
