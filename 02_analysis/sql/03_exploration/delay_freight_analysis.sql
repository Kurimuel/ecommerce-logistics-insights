cat > delay_freight_analysis.sql << 'EOF'
SELECT
  m.order_id,
  m.order_delivered_customer_date,
  m.order_estimated_delivery_date,

  DATE_DIFF(
    DATE(m.order_delivered_customer_date),
    DATE(m.order_estimated_delivery_date),
    DAY
  ) AS delivery_delay_days,

  ROUND(SAFE_DIVIDE(m.freight_value, m.price), 3) AS freight_to_price_ratio,

  m.price,
  m.freight_value,
  r.review_score

FROM `ecommerce-logistics-510006.olist.olist_merged` AS m
LEFT JOIN `ecommerce-logistics-510006.olist.olist_reviews` AS r
  ON m.order_id = r.order_id
WHERE m.order_delivered_customer_date IS NOT NULL
  AND m.order_estimated_delivery_date IS NOT NULL
LIMIT 20
EOF

bq query --use_legacy_sql=false < delay_freight_analysis.sql

หรือ ถ้าอยากให้ผลลัพธ์นี้ "ถูกเก็บไว้ถาวร" เป็นตารางใหม่

cat > create_analysis_table.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.delay_freight_analysis` AS
SELECT
  m.order_id,
  m.order_delivered_customer_date,
  m.order_estimated_delivery_date,

  DATE_DIFF(
    DATE(m.order_delivered_customer_date),
    DATE(m.order_estimated_delivery_date),
    DAY
  ) AS delivery_delay_days,

  ROUND(SAFE_DIVIDE(m.freight_value, m.price), 3) AS freight_to_price_ratio,

  m.price,
  m.freight_value,
  r.review_score

FROM `ecommerce-logistics-510006.olist.olist_merged` AS m
LEFT JOIN `ecommerce-logistics-510006.olist.olist_reviews` AS r
  ON m.order_id = r.order_id
WHERE m.order_delivered_customer_date IS NOT NULL
  AND m.order_estimated_delivery_date IS NOT NULL
EOF

bq query --use_legacy_sql=false < create_analysis_table.sql
