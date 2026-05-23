with source as (
    select * from `raw_cc_parcel_product.raw_cc_parcel_product`
)

select
    safe_cast(parcel_id as string) as parcel_id,
    -- BigQuery'deki tam eşleşme için büyük harfle yazıp, dbt'nin beklediği küçük qty'ye çeviriyoruz:
    safe_cast(QUANTITY as int64) as qty
from source