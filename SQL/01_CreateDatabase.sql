USE master;
GO

IF DB_ID('RetailSalesDW') IS NULL
BEGIN
    CREATE DATABASE RetailSalesDW;
END
GO
