cat > save_kpi_monthly.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.kpi_monthly` AS
SELECT
  purchase_month,
  COUNT(*) AS orders,
  ROUND(AVG(CAST(is_late AS INT64)) * 100, 1) AS late_pct,
  ROUND(AVG(freight_to_price_ratio), 3) AS avg_freight_ratio,
  ROUND(AVG(review_score), 2) AS avg_review
FROM `ecommerce-logistics-510006.olist.order_level_analysis`
GROUP BY purchase_month
EOF

bq query --use_legacy_sql=false < save_kpi_monthly.sql
