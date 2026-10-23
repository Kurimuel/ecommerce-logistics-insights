cat > step4.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.order_level_analysis` AS
SELECT
  o.order_id,
  o.customer_state,
  o.n_items,
  o.order_price,
  o.order_freight,
  ROUND(SAFE_DIVIDE(o.order_freight, o.order_price), 3) AS freight_to_price_ratio,
  DATE_DIFF(DATE(o.delivered_ts), DATE(o.estimated_ts), DAY) AS delivery_delay_days,
  DATE_DIFF(DATE(o.delivered_ts), DATE(o.estimated_ts), DAY) > 0 AS is_late,
  FORMAT_DATE('%Y-%m', DATE(o.purchase_ts)) AS purchase_month,
  r.review_score
FROM `ecommerce-logistics-510006.olist.tmp_orders` AS o
LEFT JOIN `ecommerce-logistics-510006.olist.tmp_latest_review` AS r
  ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.delivered_ts IS NOT NULL
  AND o.estimated_ts IS NOT NULL
EOF

bq query --use_legacy_sql=false < step4.sql
