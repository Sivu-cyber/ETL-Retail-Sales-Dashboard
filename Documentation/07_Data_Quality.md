# Data Quality & Error Handling

## Validation Rules

- CustomerID should exist in DimCustomer.
- ProductID should exist in DimProduct.
- SaleDate should map to DimDate.
- Quantity should be valid.
- Required fields should not be blank.

## Rejected Records

Invalid records are redirected to:

`stg.RejectedSales`

## Test Data

`Data/Sales_Test_Invalid.csv`

Contains:
- Invalid CustomerID: `C999`
- Invalid ProductID: `P999`

## SSIS Pattern

```text
Lookup
  │
  ├── Match ───────► Fact Load
  │
  └── No Match ────► RejectedSales
```
