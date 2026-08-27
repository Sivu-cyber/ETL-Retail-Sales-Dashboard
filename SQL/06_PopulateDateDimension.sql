USE RetailSalesDW;
GO

TRUNCATE TABLE dw.DimDate;

DECLARE @StartDate DATE = '2026-01-01';
DECLARE @EndDate DATE = '2026-12-31';

WITH DateList AS
(
    SELECT @StartDate AS FullDate
    UNION ALL
    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateList
    WHERE FullDate < @EndDate
)
INSERT INTO dw.DimDate
(
    DateKey, FullDate, DayNumber, MonthNumber,
    MonthName, QuarterNumber, YearNumber
)
SELECT
    CONVERT(INT, CONVERT(VARCHAR(8), FullDate, 112)),
    FullDate,
    DAY(FullDate),
    MONTH(FullDate),
    DATENAME(MONTH, FullDate),
    DATEPART(QUARTER, FullDate),
    YEAR(FullDate)
FROM DateList
OPTION (MAXRECURSION 400);
GO
