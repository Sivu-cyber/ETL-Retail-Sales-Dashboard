# Reconciliation & Audit

## Reconciliation Rule

```text
Source Count = Target Count + Rejected Count
```

Example:

```text
17 = 15 + 2
```

## Audit Table

`audit.ETL_Audit`

Tracks:
- Package
- Source count
- Target count
- Rejected count
- Start time
- End time
- Status
- Error message

## Control Table

`audit.ETL_Control`

Supports incremental-load watermark/control tracking.
