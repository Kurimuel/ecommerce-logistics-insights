cat > kpi_overall.sql << 'EOF'
SELECT
  COUNT(*) AS orders,
  ROUND(AVG(CAST(is_late AS INT64)) * 100, 1) AS late_pct,
  ROUND(AVG(delivery_delay_days), 1) AS avg_delay_days,
  ROUND(AVG(freight_to_price_ratio), 3) AS avg_freight_ratio,
  ROUND(APPROX_QUANTILES(freight_to_price_ratio, 2)[OFFSET(1)], 3) AS median_freight_ratio,
  ROUND(AVG(review_score), 2) AS avg_review,
  ROUND(AVG(CAST(review_score <= 2 AS INT64)) * 100, 1) AS low_review_pct
FROM `ecommerce-logistics-510006.olist.order_level_analysis`
EOF

bq query --use_legacy_sql=false < kpi_overall.sql
