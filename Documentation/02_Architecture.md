# Architecture

```text
Customers.csv ─┐
Products.csv  ─┼──> SSIS ──> Staging ──> Transform ──> Warehouse ──> Power BI
Sales.csv     ─┘              │
                              └── Rejected Records
```

## Layers

### Source
CSV files representing operational data.

### Staging
`stg.Customers`, `stg.Products`, `stg.Sales`

Raw source-level data is retained here before warehouse transformation.

### Warehouse
`dw.DimCustomer`, `dw.DimProduct`, `dw.DimDate`, `dw.FactSales`

### Audit
`audit.ETL_Audit` and `audit.ETL_Control`

### Reporting
Power BI connects to the `dw` schema.
