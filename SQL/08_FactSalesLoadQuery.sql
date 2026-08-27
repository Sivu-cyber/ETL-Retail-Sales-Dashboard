USE RetailSalesDW;
GO

SELECT
    s.SaleID,
    c.CustomerKey,
    p.ProductKey,
    d.DateKey,
    s.Quantity,
    p.Price AS UnitPrice,
    s.Quantity * p.Price AS SalesAmount
FROM stg.Sales s
JOIN dw.DimCustomer c
    ON s.CustomerID = c.CustomerID
   AND c.IsCurrent = 1
JOIN dw.DimProduct p
    ON s.ProductID = p.ProductID
JOIN dw.DimDate d
    ON s.SaleDate = d.FullDate;
