WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}
),

shipping AS (
    SELECT * FROM {{ ref('stg_raw__ship') }}
)

SELECT
    o.orders_id,
    o.date_date,
    -- Operasyonel Marj Formülü: marj + nakliye ücreti - lojistik maliyeti - gemi maliyeti
    ROUND(
        CAST(o.margin AS FLOAT64) 
        + CAST(s.shipping_fee AS FLOAT64) 
        - CAST(s.logcost AS FLOAT64) 
        - CAST(s.ship_cost AS FLOAT64)
    , 2) AS operational_margin,
    o.revenue,
    o.margin,
    o.purchase_cost,
    o.quantity,
    s.shipping_fee,
    s.logcost,
    s.ship_cost
FROM orders_margin o
LEFT JOIN shipping s 
    ON o.orders_id = s.orders_id