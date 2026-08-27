# SSIS Package Design

## Packages

```text
Load_Customers.dtsx
Load_Products.dtsx
Load_Sales.dtsx
Load_DimCustomer.dtsx
Load_DimProduct.dtsx
Load_FactSales.dtsx
Master_ETL.dtsx
```

## Master Sequence

```text
Load Customers
      ↓
Load Products
      ↓
Load Sales
      ↓
Load DimCustomer
      ↓
Load DimProduct
      ↓
Load DimDate
      ↓
Load FactSales
```

Use Success precedence constraints between dependent packages.

## Main SSIS Components

- Flat File Source
- OLE DB Source
- OLE DB Destination
- Lookup
- Derived Column
- Conditional Split
- Execute SQL Task
- Execute Package Task
