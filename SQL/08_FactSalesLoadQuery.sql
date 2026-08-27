USE RetailSalesDW;
GO

-- Reference SQL for the transformation implemented in SSIS.
-- SSIS Lookups resolve surrogate keys from the dimensions.

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
JOIN dw.DimProduct p
    ON s.ProductID = p.ProductID
JOIN dw.DimDate d
    ON s.SaleDate = d.FullDate;
