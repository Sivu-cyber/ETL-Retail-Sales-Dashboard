# Data Dictionary

## stg.Customers
| Column | Meaning |
|---|---|
| CustomerID | Source/business customer identifier |
| CustomerName | Customer name |
| City | Customer city |
| State | Customer state |
| Email | Customer email |

## stg.Products
| Column | Meaning |
|---|---|
| ProductID | Source/business product identifier |
| ProductName | Product description |
| Category | Product category |
| Price | Current source price |

## stg.Sales
| Column | Meaning |
|---|---|
| SaleID | Source transaction identifier |
| CustomerID | Source customer identifier |
| ProductID | Source product identifier |
| SaleDate | Transaction date |
| Quantity | Units sold |

## dw.DimCustomer
`CustomerKey` is the warehouse surrogate key. `CustomerID` remains the source/business key.

## dw.DimProduct
`ProductKey` is the warehouse surrogate key.

## dw.DimDate
`DateKey` uses `YYYYMMDD` format.

## dw.FactSales
| Column | Meaning |
|---|---|
| SalesKey | Warehouse identity key |
| SaleID | Source transaction identifier |
| CustomerKey | Foreign key to customer dimension |
| ProductKey | Foreign key to product dimension |
| DateKey | Foreign key to date dimension |
| Quantity | Units sold |
| UnitPrice | Price used for the transaction |
| SalesAmount | Quantity × UnitPrice |
