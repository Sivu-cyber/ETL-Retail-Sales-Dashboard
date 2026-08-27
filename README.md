# 🛒 Retail Sales ETL Pipeline

### SSIS • SQL Server • Data Warehouse • Power BI

An end-to-end **Retail Sales Data Engineering project** built using **SSIS and SQL Server**, with a dimensional data warehouse and Power BI reporting layer.

## 📌 Project Overview

```text
CSV Sources
     ↓
   SSIS ETL
     ↓
  Staging
     ↓
Transformation
     ↓
Data Warehouse
     ↓
 Power BI
```

The pipeline processes **Customer, Product, and Sales** data and transforms it into a **Star Schema** for analytics.

## 🛠️ Technology Stack

* SQL Server
* SSIS / SSDT
* SSMS
* Power BI
* Git / GitHub
* CSV

## 🏗️ Data Warehouse

```text
              DimCustomer
                   │
                   │
DimDate ─────── FactSales ─────── DimProduct
```

**Fact:** `dw.FactSales`

**Dimensions:**

* `dw.DimCustomer`
* `dw.DimProduct`
* `dw.DimDate`

## 🔄 Key ETL Features

* CSV file ingestion using SSIS
* Staging layer implementation
* Lookup transformations
* Surrogate key handling
* **Incremental Loading**
* **SCD Type 2**
* Sales amount calculation
* Data quality & rejected record handling
* Source-to-target reconciliation
* ETL auditing
* Power BI-ready dimensional model

## 📊 Power BI

The warehouse supports:

* Total Sales
* Total Orders
* Sales by Month
* Sales by Category
* Sales by State
* Top Customers
* Top Products

## 📁 Repository Structure

```text
Data/            → Source CSV files
SQL/             → Database & validation scripts
SSIS/            → SSIS ETL packages
Documentation/   → Architecture & ETL documentation
PowerBI/         → Dashboard & DAX measures
```

## 💡 Data Engineering Concepts

`ETL` • `SSIS` • `Incremental Loading` • `SCD Type 2` • `Star Schema` • `Surrogate Keys` • `Data Quality` • `Reconciliation` • `ETL Auditing` • `Power BI`

## 🚀 Future Enhancements

* SQL Server Agent scheduling
* SSIS project/environment configurations
* Advanced ETL monitoring
* CI/CD deployment

---

### 👩‍💻 Author

**Sivaranjani**

`SQL Server` • `SSIS` • `ETL` • `Data Warehouse` • `Power BI`
