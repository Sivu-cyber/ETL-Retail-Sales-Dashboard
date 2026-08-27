# Power BI Reporting

## Data Source

Connect Power BI to SQL Server database:

`RetailSalesDW`

Use the `dw` schema.

## Model

- `dw.FactSales`
- `dw.DimCustomer`
- `dw.DimProduct`
- `dw.DimDate`

## Recommended Relationships

```text
DimCustomer[CustomerKey]  1 ─── * FactSales[CustomerKey]
DimProduct[ProductKey]    1 ─── * FactSales[ProductKey]
DimDate[DateKey]          1 ─── * FactSales[DateKey]
```

## KPIs

- Total Sales
- Total Quantity
- Total Orders
- Average Order Value

## Visuals

- Sales by Month
- Sales by Category
- Sales by State
- Top Customers
- Top Products

## Slicers

- Year
- Category
- State
