# ETL Flow

## Customer

```text
Customers.csv
    ↓
Flat File Source
    ↓
OLE DB Destination
    ↓
stg.Customers
```

## Product

```text
Products.csv
    ↓
Flat File Source
    ↓
OLE DB Destination
    ↓
stg.Products
```

## Sales

```text
Sales.csv
    ↓
Flat File Source
    ↓
OLE DB Destination
    ↓
stg.Sales
```

## Warehouse Fact

```text
stg.Sales
   ↓
Customer Lookup → CustomerKey
   ↓
Product Lookup  → ProductKey + Price
   ↓
Date Lookup     → DateKey
   ↓
Derived Column  → SalesAmount
   ↓
dw.FactSales
```

SalesAmount:

`Quantity × UnitPrice`
