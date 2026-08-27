# 🛒 Retail Sales ETL Pipeline

### SSIS • SQL Server • Data Warehouse • Power BI

An end-to-end **Retail Sales Data Engineering project** built using **SQL Server Integration Services (SSIS)** and **SQL Server**, with a dimensional data warehouse designed for **Power BI analytics**.

The project demonstrates how raw CSV sales data can be ingested, validated, transformed, loaded into a **star-schema data warehouse**, and consumed for business reporting.

---

## 🚀 Project Overview

This project simulates a real-world retail organization's sales data pipeline.

```text
                 SOURCE DATA
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
      Customers   Products    Sales
         CSV         CSV        CSV
          │          │          │
          └──────────┼──────────┘
                     ▼
              ┌─────────────┐
              │    SSIS     │
              │   ETL Flow  │
              └──────┬──────┘
                     ▼
             ┌───────────────┐
             │   STAGING     │
             │    stg.*      │
             └───────┬───────┘
                     ▼
          Validation & Transformation
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
       Lookups    Derived     Error
       / Keys     Columns     Handling
          │          │          │
          └──────────┼──────────┘
                     ▼
             ┌───────────────┐
             │ DATA WAREHOUSE│
             │     dw.*      │
             └───────┬───────┘
                     │
                     ▼
                ┌─────────┐
                │ Power BI│
                └─────────┘
```

---

## 🎯 Business Objective

The objective is to build a reliable sales data pipeline that can:

* Ingest customer, product, and sales data from CSV files
* Load raw data into staging tables
* Validate source data
* Handle invalid records
* Resolve business keys to warehouse surrogate keys
* Transform transactional data into dimensional warehouse structures
* Calculate sales metrics
* Load the final `FactSales` table
* Perform source-to-target reconciliation
* Provide a clean data model for Power BI reporting

---

# 🧰 Technology Stack

| Technology       | Purpose                      |
| ---------------- | ---------------------------- |
| **SQL Server**   | Database & Data Warehouse    |
| **SSMS**         | SQL development & validation |
| **SSIS / SSDT**  | ETL development              |
| **Power BI**     | Reporting & visualization    |
| **CSV**          | Source data                  |
| **Git / GitHub** | Version control & portfolio  |

---

# 🏗️ Data Warehouse Architecture

The warehouse follows a **Star Schema** design.

```text
                         ┌─────────────────┐
                         │   DimCustomer   │
                         │                 │
                         │ CustomerKey     │
                         │ CustomerID      │
                         │ CustomerName    │
                         │ City            │
                         │ State           │
                         └────────┬────────┘
                                  │
                                  │
┌─────────────────┐       ┌───────▼────────┐       ┌─────────────────┐
│     DimDate     │       │   FactSales    │       │   DimProduct    │
│                 │       │                │       │                 │
│ DateKey         ├──────►│ SalesKey       │◄──────┤ ProductKey      │
│ FullDate        │       │ SaleID         │       │ ProductID       │
│ Month           │       │ CustomerKey    │       │ ProductName     │
│ Quarter         │       │ ProductKey     │       │ Category        │
│ Year            │       │ DateKey        │       │ Price           │
└─────────────────┘       │ Quantity       │       └─────────────────┘
                          │ UnitPrice      │
                          │ SalesAmount    │
                          └────────────────┘
```

### Fact Table

**`dw.FactSales`**

Contains transactional sales measures:

* `Quantity`
* `UnitPrice`
* `SalesAmount`

And foreign keys:

* `CustomerKey`
* `ProductKey`
* `DateKey`

### Dimension Tables

**`dw.DimCustomer`**

Stores customer attributes such as:

* Customer
* City
* State
* Email

**`dw.DimProduct`**

Stores product attributes such as:

* Product
* Category
* Price

**`dw.DimDate`**

Provides calendar attributes:

* Date
* Month
* Quarter
* Year

---

# 🔄 ETL Process

## 1️⃣ Extract

SSIS reads the following source files:

```text
Data/
├── Customers.csv
├── Products.csv
└── Sales.csv
```

---

## 2️⃣ Load into Staging

Raw source data is first loaded into:

```text
stg.Customers
stg.Products
stg.Sales
```

The staging layer provides a controlled landing area before warehouse transformation.

---

## 3️⃣ Transform

SSIS performs transformations such as:

### 🔍 Lookup — Customer

```text
CustomerID
     ↓
DimCustomer
     ↓
CustomerKey
```

### 🔍 Lookup — Product

```text
ProductID
     ↓
DimProduct
     ↓
ProductKey + Price
```

### 🔍 Lookup — Date

```text
SaleDate
     ↓
DimDate
     ↓
DateKey
```

### 🧮 Derived Calculation

```text
SalesAmount = Quantity × UnitPrice
```

---

## 4️⃣ Load Data Warehouse

The transformed records are loaded into:

```text
dw.DimCustomer
dw.DimProduct
dw.DimDate
dw.FactSales
```

---

# ⭐ Important: `stg.Sales` vs `dw.FactSales`

These two tables serve different purposes.

### `stg.Sales`

Contains the **raw source transaction**.

Example:

```text
SaleID | CustomerID | ProductID | SaleDate   | Quantity
--------------------------------------------------------
S001   | C001       | P001       | 2026-01-10 | 1
```

### `dw.FactSales`

Contains the **transformed warehouse transaction**.

Example:

```text
SaleID | CustomerKey | ProductKey | DateKey  | Qty | UnitPrice | SalesAmount
----------------------------------------------------------------------------
S001   | 1            | 1          | 20260110 | 1   | 55000     | 55000
```

This separation follows a standard **ETL → Staging → Data Warehouse** architecture.

---

# 🛡️ Data Quality & Error Handling

The project includes a dedicated rejected-record table:

```text
stg.RejectedSales
```

A test file is included:

```text
Data/Sales_Test_Invalid.csv
```

It contains intentionally invalid transactions.

Examples:

```text
Invalid CustomerID → C999
Invalid ProductID  → P999
```

SSIS Lookup transformations can redirect unmatched records instead of allowing the entire package to fail.

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

---

# 📊 Source-to-Target Reconciliation

The project includes reconciliation checks to validate the ETL.

Expected control rule:

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

Validation queries are available in:

```text
SQL/07_ValidationQueries.sql
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

# ⚙️ Setup & Execution

## Step 1 — Create Database

Open SQL Server Management Studio and execute:

```text
SQL/01_CreateDatabase.sql
```

---

## Step 2 — Create Schemas

Execute:

```text
SQL/02_CreateSchemas.sql
```

Schemas created:

```text
stg
dw
audit
```

---

## Step 3 — Create Staging Tables

Execute:

```text
SQL/03_CreateStagingTables.sql
```

Creates:

```text
stg.Customers
stg.Products
stg.Sales
stg.RejectedSales
```

---

## Step 4 — Create Warehouse

Execute:

```text
SQL/04_CreateWarehouseTables.sql
```

Creates:

```text
dw.DimCustomer
dw.DimProduct
dw.DimDate
dw.FactSales
```

---

## Step 5 — Create Audit Framework

Execute:

```text
SQL/05_CreateAuditTables.sql
```

---

## Step 6 — Populate Date Dimension

Execute:

```text
SQL/06_PopulateDateDimension.sql
```

This generates the 2026 calendar dates.

Expected:

```text
365 records
```

---

# 📦 SSIS Packages

The SSIS solution contains the following packages:

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

The complete ETL can be orchestrated through:

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

Packages are executed using **Success-based precedence constraints**.

---

# 📈 Power BI Dashboard

The warehouse is designed to serve as the Power BI reporting layer.

Recommended KPIs:

```text
💰 Total Sales
📦 Total Quantity
🧾 Total Orders
📊 Average Order Value
```

Recommended visualizations:

* Sales by Month
* Sales by Category
* Sales by State
* Top 10 Customers
* Top 10 Products

Recommended slicers:

```text
Year
Category
State
```

### Example DAX

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

# 📊 Expected Initial Counts

| Object      | Expected Records |
| ----------- | ---------------: |
| Customers   |               10 |
| Products    |               10 |
| Sales       |               15 |
| DimCustomer |               10 |
| DimProduct  |               10 |
| DimDate     |              365 |
| FactSales   |               15 |

After running the invalid-data test:

```text
Source Sales
      ↓
17 records
      │
      ├── 15 valid → FactSales
      │
      └── 2 invalid → RejectedSales
```

---

# 🧪 Validation

Run:

```text
SQL/07_ValidationQueries.sql
```

The validation script checks:

* Source row counts
* Target row counts
* Rejected row counts
* Star-schema joins
* Source-to-target reconciliation

---

# 💡 Key Data Engineering Concepts Demonstrated

This project demonstrates practical knowledge of:

* ETL development
* SSIS Data Flow
* Flat File Source
* OLE DB Source
* OLE DB Destination
* Lookup Transformation
* Derived Column
* Conditional Split
* Error handling
* Data validation
* Data reconciliation
* Surrogate keys
* Dimension modeling
* Fact tables
* Star schema
* Staging architecture
* ETL auditing
* Power BI data modeling
* DAX measures
* Git/GitHub version control

---

# 🔮 Future Enhancements

The next version of the project can include:

### 🔄 Incremental Loading

Process only newly arrived or changed records.

### 🕐 SCD Type 2

Track historical customer attribute changes.

```text
C001
Chennai    → Historical
Bangalore  → Current
```

### 📋 ETL Audit Framework

Capture:

* Start time
* End time
* Source count
* Target count
* Rejected count
* Status
* Error message

### ⏰ SQL Server Agent

Schedule the ETL automatically.

### 🔐 SSIS Parameters

Externalize:

* Connection strings
* File paths
* Environment-specific configurations

### 📊 Advanced Power BI

Add:

* Drill-through
* Tooltips
* Dynamic KPIs
* Time intelligence
* Top-N analysis
* Executive dashboard

---

# 🏆 Portfolio Value

This project demonstrates an end-to-end data engineering workflow:

```text
             RAW DATA
                 ↓
             INGESTION
                 ↓
             STAGING
                 ↓
          DATA VALIDATION
                 ↓
           TRANSFORMATION
                 ↓
         DIMENSION LOOKUPS
                 ↓
           FACT LOADING
                 ↓
          RECONCILIATION
                 ↓
          DATA WAREHOUSE
                 ↓
             POWER BI
```

It can be used to demonstrate practical experience with **SQL, SSIS, ETL, Data Warehousing and Power BI** in interviews.

---

# 👩‍💻 Author

**Sivaranjani**

Data Engineering Portfolio Project

### Technologies

`SQL Server` • `SSIS` • `SSMS` • `Power BI` • `ETL` • `Data Warehouse` • `GitHub`

---

## ⭐ If you find this project useful

Feel free to explore the repository, review the SQL scripts, and follow the ETL flow from source files through staging and the warehouse to Power BI.
