# 🚀 SSIS Packages

The `SSIS/Packages` folder contains the SSIS packages developed for the **Retail Sales ETL Pipeline** using SQL Server Integration Services (SSIS).

## 📦 Package Overview

| Package | Purpose |
|---|---|
| `Load_Customers.dtsx` | Loads customer data from CSV into the staging layer. |
| `Load_Products.dtsx` | Loads product data from CSV into the staging layer. |
| `Load_Sales.dtsx` | Loads sales transactions into the staging layer. |
| `Load_DimCustomer.dtsx` | Loads the Customer dimension with **SCD Type 2** processing. |
| `Load_DimProduct.dtsx` | Loads the Product dimension. |
| `Load_FactSales.dtsx` | Performs lookups, surrogate-key mapping, transformations, and fact loading. |
| `Master_ETL.dtsx` | Orchestrates the complete ETL workflow. |

## 🔄 ETL Workflow

```text
📄 Customers.csv ──→ Load Customers ──┐
📄 Products.csv  ──→ Load Products  ──┼──→ Data Warehouse
📄 Sales.csv     ──→ Load Sales     ──┘
                                           ↓
                                  DimCustomer (SCD2)
                                           ↓
                                     DimProduct
                                           ↓
                                     FactSales
