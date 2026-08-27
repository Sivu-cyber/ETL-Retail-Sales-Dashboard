# Incremental Loading

## Objective

Avoid processing the entire historical source dataset on every execution.

## Logical Flow

```text
Previous Successful Run
        ↓
Read Watermark / Control Value
        ↓
Identify New or Changed Records
        ↓
Transform
        ↓
Load Warehouse
        ↓
Update Control Value
```

## Control

`audit.ETL_Control` stores the process name and last successful load value.

## Benefits

- Less processing
- Faster execution
- Lower database workload
- Better scalability
- Suitable for recurring ETL jobs

## Test Data

`Data/Sales_Incremental_Test.csv` contains additional transactions for incremental-load testing.
