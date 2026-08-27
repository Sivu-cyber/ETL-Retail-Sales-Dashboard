USE RetailSalesDW;
GO

/*
Incremental-load design reference.

The production implementation should identify only source rows that
are new or changed since the last successful ETL run.

Typical control values:
    LastSuccessfulLoad
    SourceModifiedDate / Watermark
    BatchID

Example conceptual filter:

WHERE SourceModifiedDate > @LastSuccessfulLoad

For a file-based source, a practical implementation can use a control
table, file/batch metadata, or a source-side modified timestamp.
*/

IF OBJECT_ID('audit.ETL_Control','U') IS NULL
BEGIN
    CREATE TABLE audit.ETL_Control
    (
        ControlID INT IDENTITY(1,1) PRIMARY KEY,
        ProcessName VARCHAR(100) NOT NULL,
        LastSuccessfulLoad DATETIME NULL,
        LastBatchID VARCHAR(100) NULL,
        UpdatedDate DATETIME DEFAULT GETDATE()
    );
END
GO
