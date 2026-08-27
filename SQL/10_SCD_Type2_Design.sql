USE RetailSalesDW;
GO

/*
SCD Type 2 reference logic.

When tracked attributes change:
1. Expire the current dimension row.
2. Set EndDate to the change date.
3. Set IsCurrent = 0.
4. Insert a new version with IsCurrent = 1.
5. Preserve the old row for historical reporting.

Example conceptual operation:

UPDATE dw.DimCustomer
SET EndDate = @ChangeDate,
    IsCurrent = 0
WHERE CustomerID = @CustomerID
  AND IsCurrent = 1;

INSERT INTO dw.DimCustomer
(
    CustomerID, CustomerName, City, State, Email,
    EffectiveDate, EndDate, IsCurrent
)
VALUES
(
    @CustomerID, @CustomerName, @City, @State, @Email,
    @ChangeDate, '9999-12-31', 1
);
*/
