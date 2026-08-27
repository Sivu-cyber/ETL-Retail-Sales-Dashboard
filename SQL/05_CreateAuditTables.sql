USE RetailSalesDW;
GO

IF OBJECT_ID('audit.ETL_Audit','U') IS NOT NULL DROP TABLE audit.ETL_Audit;
GO

CREATE TABLE audit.ETL_Audit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    PackageName VARCHAR(100),
    SourceCount INT,
    TargetCount INT,
    RejectedCount INT,
    StartTime DATETIME,
    EndTime DATETIME,
    Status VARCHAR(20),
    ErrorMessage VARCHAR(500)
);
GO
