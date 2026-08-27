# Architecture

```text
Customers.csv ─┐
Products.csv  ─┼──> SSIS ──> Staging ──> Transform/Lookup ──> Data Warehouse
Sales.csv     ─┘              │                                  │
                              └── Rejected Records                ├── DimCustomer
                                                                  ├── DimProduct
                                                                  ├── DimDate
                                                                  └── FactSales
```

## Layers

1. **Source** – CSV files representing operational data.
2. **Staging (`stg`)** – raw landing area.
3. **Warehouse (`dw`)** – star schema with dimensions and fact table.
4. **Audit (`audit`)** – ETL execution and reconciliation metadata.
5. **BI** – Power BI can consume the warehouse star schema.

## Sales distinction

- `stg.Sales` stores source-level transaction records.
- `dw.FactSales` stores transformed warehouse facts with surrogate keys, unit price and calculated sales amount.
