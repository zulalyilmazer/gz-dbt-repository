WITH sales AS (
    SELECT * FROM {{ ref('stg_raw__sales') }}
),
product AS (
    SELECT * FROM {{ ref('stg_raw__product') }}
)
SELECT
    s.orders_id,
    s.date_date,
    s.products_id,
    s.revenue,
    s.quantity,
    p.purchase_price,
    -- Satır başındaki virgülleri kaldırdık, kolon aralarına aldık
    ROUND(CAST(p.purchase_price AS FLOAT64) * CAST(s.quantity AS FLOAT64), 2) AS purchase_cost,
    ROUND(CAST(s.revenue AS FLOAT64) - (CAST(s.quantity AS FLOAT64) * CAST(p.purchase_price AS FLOAT64)), 2) AS margin
FROM sales AS s
LEFT JOIN product AS p 
    ON p.products_id = s.products_id