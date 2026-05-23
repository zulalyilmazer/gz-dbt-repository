with source as (
    select * from `raw_cc_parcel.raw_cc_parcel`
)

select
    safe_cast(parcel_id as string) as parcel_id,
    safe_cast(parcel_tracking as string) as parcel_tracking,
    safe_cast(transporter as string) as transporter,
    safe_cast(priority as string) as priority,
    
    -- Kesin var olan ana tarih sütunları
    parse_date("%B %e, %Y", date_purchase) as date_purchase,
    parse_date("%B %e, %Y", date_shipping) as date_shipping,
    parse_date("%B %e, %Y", date_delivery) as date_delivery
from source