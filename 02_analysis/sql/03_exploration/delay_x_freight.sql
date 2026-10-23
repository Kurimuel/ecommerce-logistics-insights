cat > delay_x_freight.sql << 'EOF'
SELECT
  CASE WHEN delivery_delay_days <= 0 THEN '1_on_time'
       WHEN delivery_delay_days <= 7 THEN '2_late_1_7d'
       ELSE '3_late_8d_plus' END AS delay_bucket,
  CASE WHEN freight_to_price_ratio < 0.2 THEN 'A_low'
       WHEN freight_to_price_ratio < 0.4 THEN 'B_mid'
       ELSE 'C_high' END AS freight_bucket,
  COUNT(*) AS orders,
  ROUND(AVG(review_score), 2) AS avg_review,
  ROUND(AVG(CAST(review_score <= 2 AS INT64)) * 100, 1) AS low_review_pct
FROM `ecommerce-logistics-510006.olist.order_level_analysis`
WHERE review_score IS NOT NULL
GROUP BY delay_bucket, freight_bucket
ORDER BY delay_bucket, freight_bucket
EOF

bq query --use_legacy_sql=false < delay_x_freight.sql
