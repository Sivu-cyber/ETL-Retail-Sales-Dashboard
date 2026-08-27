# Data Model

## Star Schema

```text
              DimCustomer
                   │
                   │
DimDate ─────── FactSales ─────── DimProduct
```

## FactSales

Grain: one row per sales transaction.

Measures:
- Quantity
- UnitPrice
- SalesAmount

Keys:
- CustomerKey
- ProductKey
- DateKey

## DimCustomer

Business key: `CustomerID`

Surrogate key: `CustomerKey`

SCD Type 2 columns:
- EffectiveDate
- EndDate
- IsCurrent

## DimProduct

Business key: `ProductID`

Surrogate key: `ProductKey`

## DimDate

Business key: `FullDate`

Surrogate/date key: `DateKey`
