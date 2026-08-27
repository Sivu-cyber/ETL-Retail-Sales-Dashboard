# SSIS ETL Flow

## Package sequence

```text
Master_ETL
   |
   +--> Load_Customers
   +--> Load_Products
   +--> Load_Sales
   +--> Load_DimCustomer
   +--> Load_DimProduct
   +--> Load_FactSales
```

## Fact load

```text
OLE DB Source: stg.Sales
        |
        v
Lookup Customer --> CustomerKey
        |
        v
Lookup Product  --> ProductKey + Price
        |
        v
Lookup Date     --> DateKey
        |
        v
Derived Column  --> SalesAmount = Quantity * Price
        |
        v
OLE DB Destination: dw.FactSales
```

## Data quality

Configure Lookup transformations to redirect no-match rows to `stg.RejectedSales`.

Expected reconciliation:

`Source Count = Target Count + Rejected Count`
