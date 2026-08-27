# 🛒 Retail Sales ETL Pipeline

### SSIS • SQL Server • Data Warehouse • Incremental Loading • SCD Type 2 • Power BI

An end-to-end **Retail Sales Data Engineering project** demonstrating a production-style ETL workflow using **SQL Server Integration Services (SSIS)** and **SQL Server**.

The project covers source ingestion, staging, data validation, transformation, surrogate-key management, **incremental loading, SCD Type 2, error handling, reconciliation, ETL auditing**, and a Power BI-ready dimensional data warehouse.

---

## 📌 Project Overview

This project simulates a retail organization's sales data platform where customer, product, and sales data arrive as source files.

The ETL pipeline processes the data through multiple layers before making it available for analytics.

```text
                         SOURCE SYSTEM
                              │
               ┌──────────────┼──────────────┐
               │              │              │
               ▼              ▼              ▼
          Customers.csv   Products.csv   Sales.csv
               │              │              │
               └──────────────┼──────────────┘
                              ▼
                         SSIS ETL
                              │
                              ▼
                     ┌────────────────┐
                     │    STAGING     │
                     │     stg.*      │
                     └───────┬────────┘
                             │
                 Validation & Transformation
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
          Lookups      Incremental      Error Handling
       / Surrogate Keys    Loading
              │              │
              └──────────────┼──────────────┘
                             ▼
                    ┌─────────────────┐
                    │ DATA WAREHOUSE  │
                    │      dw.*       │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
         Dimensions      Fact Tables     Audit
                             │
                             ▼
                         POWER BI
```

---

# 🎯 Business Objective

The objective of this project is to build a reliable and scalable retail sales ETL pipeline that can:

* Ingest customer, product, and sales data from CSV files
* Load raw source data into staging tables
* Validate incoming data
* Handle invalid and rejected records
* Transform source data into a dimensional warehouse
* Generate and resolve surrogate keys
* Implement **Incremental Loading**
* Implement **SCD Type 2** for historical tracking
* Calculate sales metrics
* Load the `FactSales` table
* Perform source-to-target reconciliation
* Maintain ETL audit information
* Provide a Power BI-ready data model

---

# 🛠️ Technology Stack

| Technology       | Usage                        |
| ---------------- | ---------------------------- |
| **SQL Server**   | Database & Data Warehouse    |
| **SSIS / SSDT**  | ETL development              |
| **SSMS**         | SQL development & validation |
| **Power BI**     | Reporting & visualization    |
| **CSV**          | Source data                  |
| **Git / GitHub** | Source control & portfolio   |

---

# 🏗️ Data Warehouse Architecture

The warehouse follows a **Star Schema**.

```text
                         ┌─────────────────┐
                         │   DimCustomer   │
                         │                 │
                         │ CustomerKey     │
                         │ CustomerID      │
                         │ CustomerName    │
                         │ City            │
                         │ State           │
                         │ Email           │
                         │ EffectiveDate   │
                         │ EndDate         │
                         │ IsCurrent       │
                         └────────┬────────┘
                                  │
                                  │
┌─────────────────┐        ┌─────▼──────────┐        ┌─────────────────┐
│     DimDate     │        │   FactSales    │        │   DimProduct    │
│                 │        │                │        │                 │
│ DateKey         ├───────►│ SalesKey       │◄───────┤ ProductKey      │
│ FullDate        │        │ SaleID         │        │ ProductID       │
│ Month           │        │ CustomerKey    │        │ ProductName     │
│ Quarter         │        │ ProductKey     │        │ Category        │
│ Year            │        │ DateKey        │        │ Price           │
└─────────────────┘        │ Quantity       │        └─────────────────┘
                           │ UnitPrice      │
                           │ SalesAmount    │
                           └────────────────┘
```

---

# ⭐ Data Warehouse Tables

## Fact Table

### `dw.FactSales`

Stores transactional sales information.

### Measures

* `Quantity`
* `UnitPrice`
* `SalesAmount`

### Foreign Keys

* `CustomerKey`
* `ProductKey`
* `DateKey`

---

## Dimension Tables

### `dw.DimCustomer`

Stores customer information and supports **SCD Type 2 historical tracking**.

Key attributes:

* CustomerID
* CustomerName
* City
* State
* Email
* EffectiveDate
* EndDate
* IsCurrent

### `dw.DimProduct`

Stores product information:

* ProductID
* ProductName
* Category
* Price

### `dw.DimDate`

Provides calendar attributes:

* DateKey
* FullDate
* Day
* Month
* Quarter
* Year

---

# 🔄 ETL Process

## 1. Extract

SSIS reads the source CSV files:

```text
Data/
├── Customers.csv
├── Products.csv
└── Sales.csv
```

---

## 2. Staging

The raw source data is loaded into:

```text
stg.Customers
stg.Products
stg.Sales
```

The staging layer provides a controlled landing area before transformation and warehouse loading.

---

## 3. Data Validation

Incoming records are validated for:

* Required fields
* Valid CustomerID
* Valid ProductID
* Valid dates
* Valid quantities
* Duplicate transactions
* Lookup availability

Invalid records are redirected to:

```text
stg.RejectedSales
```

---

# 🔍 Lookup Transformations

SSIS Lookup transformations are used to resolve business keys into warehouse surrogate keys.

### Customer Lookup

```text
CustomerID
     ↓
DimCustomer
     ↓
CustomerKey
```

### Product Lookup

```text
ProductID
     ↓
DimProduct
     ↓
ProductKey
```

### Date Lookup

```text
SaleDate
     ↓
DimDate
     ↓
DateKey
```

---

# 🧮 Derived Calculations

Sales amount is calculated during ETL:

```text
SalesAmount = Quantity × UnitPrice
```

Example:

```text
Quantity  = 2
UnitPrice = 12,000

SalesAmount = 2 × 12,000
            = 24,000
```

---

# 🔄 Incremental Loading

The project implements **Incremental Loading** to avoid unnecessarily processing the complete source dataset during every ETL execution.

Instead of repeatedly loading all historical records, the ETL identifies and processes only **new or changed records**.

```text
Initial Load
     ↓
Load Historical Data
     ↓
Store Last Successful Load
     ↓
New Source Data
     ↓
Identify New / Changed Records
     ↓
Process Incremental Records
     ↓
Update Warehouse
```

### Benefits

* Reduces ETL processing time
* Minimizes unnecessary database operations
* Supports growing datasets
* Improves overall ETL performance
* Makes the pipeline more scalable

---

# 🕐 SCD Type 2

**Slowly Changing Dimension Type 2** is implemented for customer history.

When an important customer attribute changes, the existing record is retained as historical data and a new version of the customer record is created.

### Example

Initial customer:

```text
CustomerKey | CustomerID | City      | IsCurrent
-------------------------------------------------
1           | C001       | Chennai   | 1
```

Customer moves to Bangalore.

Instead of overwriting the existing record:

```text
CustomerKey | CustomerID | City       | IsCurrent
--------------------------------------------------
1           | C001       | Chennai    | 0
11          | C001       | Bangalore  | 1
```

The historical record remains available for reporting.

### SCD Type 2 Attributes

```text
EffectiveDate
EndDate
IsCurrent
```

This allows the warehouse to answer questions such as:

> "Which city was the customer associated with when the sale occurred?"

---

# ⭐ `stg.Sales` vs `dw.FactSales`

These tables serve different purposes.

### `stg.Sales`

Stores the raw source transaction:

```text
SaleID | CustomerID | ProductID | SaleDate   | Quantity
--------------------------------------------------------
S001   | C001       | P001      | 2026-01-10 | 1
```

### `dw.FactSales`

Stores the transformed warehouse transaction:

```text
SaleID | CustomerKey | ProductKey | DateKey  | Qty | UnitPrice | SalesAmount
----------------------------------------------------------------------------
S001   | 1            | 1          | 20260110 | 1   | 55000     | 55000
```

This separation provides a clear distinction between **raw source data and analytical warehouse data**.

---

# 🛡️ Data Quality & Error Handling

The project includes rejected-record handling using:

```text
stg.RejectedSales
```

A test dataset is provided:

```text
Data/Sales_Test_Invalid.csv
```

It contains intentionally invalid records such as:

```text
Invalid CustomerID → C999
Invalid ProductID  → P999
```

SSIS Lookup transformations can redirect unmatched records.

```text
                 Lookup
                   │
          ┌────────┴────────┐
          ▼                 ▼
       Match             No Match
          │                 │
          ▼                 ▼
     FactSales        RejectedSales
```

This prevents bad records from unnecessarily stopping the complete ETL pipeline.

---

# 📊 Source-to-Target Reconciliation

The project includes reconciliation checks to validate ETL completeness.

Expected rule:

```text
Source Records
      =
Loaded Records
      +
Rejected Records
```

Example:

```text
17 Source Records
       =
15 Loaded Records
       +
2 Rejected Records
```

Validation queries are available under:

```text
SQL/07_ValidationQueries.sql
```

---

# 📋 ETL Audit

An audit framework is included using:

```text
audit.ETL_Audit
```

The framework can capture:

* Package name
* Source record count
* Target record count
* Rejected record count
* ETL start time
* ETL end time
* Execution status
* Error message

This provides basic operational visibility into ETL execution.

---

# 📦 SSIS Packages

The ETL solution is organized into separate packages:

```text
Load_Customers.dtsx
Load_Products.dtsx
Load_Sales.dtsx
Load_DimCustomer.dtsx
Load_DimProduct.dtsx
Load_FactSales.dtsx
Master_ETL.dtsx
```

### Master Package

```text
Master_ETL
    │
    ├── Load Customers
    │
    ├── Load Products
    │
    ├── Load Sales
    │
    ├── Load DimCustomer
    │
    ├── Load DimProduct
    │
    ├── Load DimDate
    │
    └── Load FactSales
```

Success-based precedence constraints control the package execution sequence.

---

# 📈 Power BI

The warehouse is designed as the reporting layer for Power BI.

### KPI Metrics

* Total Sales
* Total Quantity
* Total Orders
* Average Order Value

### Visualizations

* Sales by Month
* Sales by Category
* Sales by State
* Top 10 Customers
* Top 10 Products

### Filters

* Year
* Category
* State

Example DAX:

```DAX
Total Sales =
SUM(FactSales[SalesAmount])

Total Quantity =
SUM(FactSales[Quantity])

Total Orders =
DISTINCTCOUNT(FactSales[SaleID])

Average Order Value =
DIVIDE(
    [Total Sales],
    [Total Orders],
    0
)
```

---

# 📁 Repository Structure

```text
RetailSalesETL/
│
├── 📂 Data/
│   ├── Customers.csv
│   ├── Products.csv
│   ├── Sales.csv
│   └── Sales_Test_Invalid.csv
│
├── 📂 SQL/
│   ├── 01_CreateDatabase.sql
│   ├── 02_CreateSchemas.sql
│   ├── 03_CreateStagingTables.sql
│   ├── 04_CreateWarehouseTables.sql
│   ├── 05_CreateAuditTables.sql
│   ├── 06_PopulateDateDimension.sql
│   ├── 07_ValidationQueries.sql
│   └── 08_FactSalesLoadQuery.sql
│
├── 📂 SSIS/
│   └── Packages/
│
├── 📂 Documentation/
│   ├── Architecture.md
│   ├── ETL_Flow.md
│   ├── Interview_Notes.md
│   └── Star_Schema.md
│
├── 📂 PowerBI/
│   ├── README.md
│   └── DAX_Measures.txt
│
├── 📄 PROJECT_STATUS.md
├── 📄 .gitignore
└── 📄 README.md
```

---

# ⚙️ Setup

### 1. Create Database

Execute:

```text
SQL/01_CreateDatabase.sql
```

### 2. Create Schemas

Execute:

```text
SQL/02_CreateSchemas.sql
```

Creates:

```text
stg
dw
audit
```

### 3. Create Staging Tables

Execute:

```text
SQL/03_CreateStagingTables.sql
```

### 4. Create Warehouse Tables

Execute:

```text
SQL/04_CreateWarehouseTables.sql
```

### 5. Create Audit Framework

Execute:

```text
SQL/05_CreateAuditTables.sql
```

### 6. Populate Date Dimension

Execute:

```text
SQL/06_PopulateDateDimension.sql
```

### 7. Configure SSIS

Open the SSIS solution in Visual Studio/SSDT and configure:

* SQL Server connection
* CSV file paths
* SSIS packages
* Lookup transformations
* Incremental load logic
* SCD Type 2 logic
* Error handling

### 8. Execute Master ETL

Run:

```text
Master_ETL.dtsx
```

---

# 📊 Expected Data

| Object      | Initial Records |
| ----------- | --------------: |
| Customers   |              10 |
| Products    |              10 |
| Sales       |              15 |
| DimCustomer |              10 |
| DimProduct  |              10 |
| DimDate     |             365 |
| FactSales   |              15 |

The invalid test dataset can then be used to validate rejected-record processing.

---

# 💡 Key Data Engineering Concepts

This project demonstrates hands-on experience with:

* ETL development
* SSIS Data Flow
* Flat File Source
* OLE DB Source
* OLE DB Destination
* Lookup Transformation
* Derived Column
* Conditional Split
* Surrogate Keys
* Star Schema
* Dimension & Fact Modeling
* **Incremental Loading**
* **SCD Type 2**
* Data Quality
* Error Handling
* Source-to-Target Reconciliation
* ETL Auditing
* Power BI Data Modeling
* DAX
* Git/GitHub

---

# 🚀 Future Enhancements

Potential future improvements include:

* SQL Server Agent scheduling
* SSIS Catalog deployment
* Environment-specific configurations
* Advanced ETL monitoring
* Retry mechanisms
* CI/CD deployment
* Automated data-quality framework
* Advanced Power BI analytics

---

# 🏆 Project Outcome

This project demonstrates an end-to-end data engineering workflow:

```text
SOURCE
  ↓
EXTRACT
  ↓
STAGING
  ↓
VALIDATION
  ↓
TRANSFORMATION
  ↓
INCREMENTAL LOAD
  ↓
SCD TYPE 2
  ↓
DATA WAREHOUSE
  ↓
RECONCILIATION & AUDIT
  ↓
POWER BI
```

It demonstrates practical implementation of **SQL Server, SSIS, ETL, Data Warehousing, Incremental Loading, SCD Type 2, Data Quality, and Power BI** in a single portfolio project.

---

## 👩‍💻 Author

**Sivaranjani**

### Data Engineering Portfolio Project

`SQL Server` • `SSIS` • `ETL` • `Data Warehouse` • `Incremental Loading` • `SCD Type 2` • `Power BI` • `GitHub`
