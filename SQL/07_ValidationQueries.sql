USE RetailSalesDW;
GO

-- Row counts
SELECT 'stg.Customers' AS TableName, COUNT(*) AS RowCount FROM stg.Customers
UNION ALL
SELECT 'stg.Products', COUNT(*) FROM stg.Products
UNION ALL
SELECT 'stg.Sales', COUNT(*) FROM stg.Sales
UNION ALL
SELECT 'dw.DimCustomer', COUNT(*) FROM dw.DimCustomer
UNION ALL
SELECT 'dw.DimProduct', COUNT(*) FROM dw.DimProduct
UNION ALL
SELECT 'dw.DimDate', COUNT(*) FROM dw.DimDate
UNION ALL
SELECT 'dw.FactSales', COUNT(*) FROM dw.FactSales
UNION ALL
SELECT 'stg.RejectedSales', COUNT(*) FROM stg.RejectedSales;

-- Star-schema validation
SELECT
    f.SaleID,
    c.CustomerName,
    c.City,
    c.State,
    p.ProductName,
    p.Category,
    d.FullDate,
    f.Quantity,
    f.UnitPrice,
    f.SalesAmount
FROM dw.FactSales f
JOIN dw.DimCustomer c ON f.CustomerKey = c.CustomerKey
JOIN dw.DimProduct p ON f.ProductKey = p.ProductKey
JOIN dw.DimDate d ON f.DateKey = d.DateKey
ORDER BY d.FullDate;

-- Reconciliation
SELECT
    (SELECT COUNT(*) FROM stg.Sales) AS SourceCount,
    (SELECT COUNT(*) FROM dw.FactSales) AS TargetCount,
    (SELECT COUNT(*) FROM stg.RejectedSales) AS RejectedCount,
    (SELECT COUNT(*) FROM stg.Sales)
      - (SELECT COUNT(*) FROM dw.FactSales)
      - (SELECT COUNT(*) FROM stg.RejectedSales) AS Difference;
