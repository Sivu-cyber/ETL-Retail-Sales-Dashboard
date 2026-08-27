# Interview Talking Points

## Project summary

Built a retail sales ETL pipeline using SQL Server Integration Services (SSIS), SQL Server and Power BI-ready dimensional modeling.

## Key points

- Designed staging, warehouse and audit schemas.
- Loaded CSV source data using SSIS Flat File Source.
- Used OLE DB Destination for staging and warehouse loads.
- Implemented surrogate-key lookups for dimensions.
- Created a star schema with DimCustomer, DimProduct, DimDate and FactSales.
- Calculated SalesAmount in the ETL layer.
- Implemented rejected-record handling for invalid customer/product references.
- Added source-to-target reconciliation.
- Prepared the model for Power BI reporting.
- Next enhancements: incremental loads, SCD Type 2, SQL Server Agent scheduling and operational monitoring.
