cat > validate.sql << 'EOF'
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT order_id) AS distinct_orders,
  ROUND(AVG(CAST(is_late AS INT64)) * 100, 1) AS late_percent,
  ROUND(AVG(review_score), 2) AS avg_review,
  COUNTIF(review_score IS NULL) AS missing_reviews,
  MIN(purchase_month) AS first_month,
  MAX(purchase_month) AS last_month
FROM `ecommerce-logistics-510006.olist.order_level_analysis`
EOF

bq query --use_legacy_sql=false < validate.sql
