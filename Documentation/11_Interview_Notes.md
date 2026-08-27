# Interview Notes

## Project Summary

Built an end-to-end retail ETL pipeline using SSIS and SQL Server.

## Explain the Architecture

Source CSV files are loaded into staging through SSIS. Staging data is validated and transformed. Lookups resolve business keys to warehouse surrogate keys. The final data is loaded into a star-schema warehouse and exposed to Power BI.

## Incremental Loading

I implemented incremental processing so new or changed records are processed instead of repeatedly loading the complete historical dataset. A control/watermark concept is used to track the last successful load.

## SCD Type 2

I implemented SCD Type 2 for customer attributes. When a tracked attribute changes, the existing row is expired and a new current version is inserted. This preserves historical customer states.

## Error Handling

Invalid lookup records are redirected to a rejected-record table instead of being loaded into the fact table.

## Reconciliation

I validate ETL completeness using:

`Source Count = Loaded Count + Rejected Count`

## Power BI

Power BI consumes the warehouse star schema for sales, customer, product and time analysis.
