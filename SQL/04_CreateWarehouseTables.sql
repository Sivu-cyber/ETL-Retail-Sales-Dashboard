USE RetailSalesDW;
GO

IF OBJECT_ID('dw.FactSales','U') IS NOT NULL DROP TABLE dw.FactSales;
IF OBJECT_ID('dw.DimCustomer','U') IS NOT NULL DROP TABLE dw.DimCustomer;
IF OBJECT_ID('dw.DimProduct','U') IS NOT NULL DROP TABLE dw.DimProduct;
IF OBJECT_ID('dw.DimDate','U') IS NOT NULL DROP TABLE dw.DimDate;
GO

CREATE TABLE dw.DimCustomer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(20) NOT NULL,
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Email VARCHAR(150),
    EffectiveDate DATE,
    EndDate DATE,
    IsCurrent BIT
);
GO

CREATE TABLE dw.DimProduct
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(20) NOT NULL,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(18,2)
);
GO

CREATE TABLE dw.DimDate
(
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    DayNumber INT,
    MonthNumber INT,
    MonthName VARCHAR(20),
    QuarterNumber INT,
    YearNumber INT
);
GO

CREATE TABLE dw.FactSales
(
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    SaleID VARCHAR(20) NOT NULL,
    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(18,2),
    SalesAmount DECIMAL(18,2),
    CONSTRAINT FK_FactSales_Customer FOREIGN KEY (CustomerKey) REFERENCES dw.DimCustomer(CustomerKey),
    CONSTRAINT FK_FactSales_Product FOREIGN KEY (ProductKey) REFERENCES dw.DimProduct(ProductKey),
    CONSTRAINT FK_FactSales_Date FOREIGN KEY (DateKey) REFERENCES dw.DimDate(DateKey)
);
GO
