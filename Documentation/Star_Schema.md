# Star Schema

```text
                +----------------+
                |  DimCustomer   |
                +----------------+
                        |
                        |
+------------+     +-----------+     +-------------+
|  DimDate   | --->| FactSales |<--- | DimProduct  |
+------------+     +-----------+     +-------------+
```

### Fact

`dw.FactSales`

Measures:
- Quantity
- UnitPrice
- SalesAmount

Keys:
- CustomerKey
- ProductKey
- DateKey

### Dimensions

- `dw.DimCustomer`
- `dw.DimProduct`
- `dw.DimDate`
