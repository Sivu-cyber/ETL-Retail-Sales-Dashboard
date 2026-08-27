# SCD Type 2

## Objective

Preserve historical versions of customer attributes.

## Tracked Attributes

Examples:
- City
- State
- CustomerName
- Email

## Logic

```text
Current Dimension Row
        ↓
Compare Incoming Attributes
        ↓
No Change ───────────────► Keep Current
        │
        └── Change
              ↓
       Expire Old Row
       IsCurrent = 0
              ↓
       Insert New Row
       IsCurrent = 1
```

## Example

Before:

```text
CustomerKey | CustomerID | City      | IsCurrent
1           | C001       | Chennai   | 1
```

After change:

```text
CustomerKey | CustomerID | City       | IsCurrent
1           | C001       | Chennai    | 0
11          | C001       | Bangalore  | 1
```

The old row remains available for historical analysis.
