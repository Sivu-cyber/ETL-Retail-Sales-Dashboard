# Retail Sales ETL — SSIS + SQL Server + Power BI

A hands-on retail data engineering project demonstrating an end-to-end ETL pipeline using **SQL Server Integration Services (SSIS)** and **SQL Server**, with a dimensional model prepared for **Power BI**.

## Project Objective

Build a reliable pipeline that:

1. Reads customer, product and sales CSV files.
2. Loads raw data into staging tables.
3. Transforms source data into a warehouse star schema.
4. Resolves surrogate keys through SSIS Lookup transformations.
5. Calculates sales amounts.
6. Redirects invalid records to a rejected-record table.
7. Performs source-to-target reconciliation.
8. Provides a Power BI-ready model.

## Technology Stack

- SQL Server
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS / SSDT)
- Power BI
- Git / GitHub
- CSV

## Architecture

```text
CSV Sources
   |
   v
SSIS
   |
   v
+----------------+
| Staging (stg)  |
+----------------+
   |
   v
Lookups / Transformations
   |
   v
+-----------------------------+
| Data Warehouse (dw)         |
|                             |
| DimCustomer                 |
| DimProduct                  |
| DimDate                     |
| FactSales                   |
+-----------------------------+
   |
   v
Power BI
```

## Data Model

`FactSales` is the central fact table.

Dimensions:

- `DimCustomer`
- `DimProduct`
- `DimDate`

The project uses surrogate keys in the fact table.

### Important distinction

`stg.Sales` is the raw source-level sales table.

`dw.FactSales` is the transformed warehouse fact table containing:

- `CustomerKey`
- `ProductKey`
- `DateKey`
- `Quantity`
- `UnitPrice`
- `SalesAmount`

## Repository Structure

```text
RetailSalesETL/
├── Data/
│   ├── Customers.csv
│   ├── Products.csv
│   ├── Sales.csv
│   └── Sales_Test_Invalid.csv
├── SQL/
│   ├── 01_CreateDatabase.sql
│   ├── 02_CreateSchemas.sql
│   ├── 03_CreateStagingTables.sql
│   ├── 04_CreateWarehouseTables.sql
│   ├── 05_CreateAuditTables.sql
│   ├── 06_PopulateDateDimension.sql
│   ├── 07_ValidationQueries.sql
│   └── 08_FactSalesLoadQuery.sql
├── SSIS/
│   └── Packages/
│       └── README.md
├── Documentation/
│   ├── Architecture.md
│   ├── ETL_Flow.md
│   ├── Interview_Notes.md
│   └── Star_Schema.md
├── PowerBI/
│   ├── README.md
│   └── DAX_Measures.txt
├── .gitignore
└── README.md
```

## Setup

Run the SQL scripts in this order:

```text
01_CreateDatabase.sql
02_CreateSchemas.sql
03_CreateStagingTables.sql
04_CreateWarehouseTables.sql
05_CreateAuditTables.sql
06_PopulateDateDimension.sql
```

Then create the SSIS packages using the instructions in `Documentation/ETL_Flow.md`.

## Expected Initial Counts

| Object | Expected |
|---|---:|
| Customers source | 10 |
| Products source | 10 |
| Sales source | 15 |
| DimCustomer | 10 |
| DimProduct | 10 |
| DimDate | 365 |
| FactSales | 15 |

## Data Quality Test

`Data/Sales_Test_Invalid.csv` contains two deliberately invalid transactions:

- One invalid CustomerID
- One invalid ProductID

Use these to test SSIS Lookup no-match handling and populate `stg.RejectedSales`.

## Reconciliation

The expected control rule is:

```text
Source Sales = Loaded Fact Sales + Rejected Sales
```

The repository includes a validation query in `SQL/07_ValidationQueries.sql`.

## Power BI

Connect Power BI to the `dw` schema and build:

- Total Sales
- Total Quantity
- Total Orders
- Average Order Value
- Sales by Month
- Sales by Category
- Sales by State
- Top Customers
- Top Products

See `PowerBI/README.md`.

## Future Enhancements

- Incremental loading
- SCD Type 2 for customer changes
- SSIS parameters and project-level configurations
- SQL Server Agent scheduling
- Retry/error framework
- Centralized ETL logging
- Row-level data-quality rules
- Power BI dashboard screenshots
- CI/CD deployment

## Portfolio / Resume Description

> Developed an end-to-end retail sales ETL pipeline using SSIS and SQL Server, implementing CSV ingestion, staging, dimensional modeling, surrogate-key lookups, fact loading, data-quality rejection handling and source-to-target reconciliation. Prepared a star-schema warehouse for Power BI reporting with customer, product, date and sales analytics.
