# Validation Checklist

## Database

- [ ] Database exists
- [ ] `stg`, `dw`, and `audit` schemas exist
- [ ] Tables created

## Initial Load

- [ ] 10 customers in staging
- [ ] 10 products in staging
- [ ] 15 sales in staging
- [ ] 10 customers in DimCustomer
- [ ] 10 products in DimProduct
- [ ] 365 dates in DimDate
- [ ] 15 sales in FactSales

## Data Quality

- [ ] Invalid customer is rejected
- [ ] Invalid product is rejected
- [ ] Rejected count is correct

## Incremental Loading

- [ ] New records are detected
- [ ] Existing records are not duplicated
- [ ] Control/watermark is updated

## SCD Type 2

- [ ] Changed customer creates new version
- [ ] Old version has IsCurrent = 0
- [ ] New version has IsCurrent = 1
- [ ] EffectiveDate and EndDate are populated

## Reconciliation

- [ ] Source = Target + Rejected
