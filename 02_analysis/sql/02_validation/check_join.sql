cat > check_join.sql << 'EOF'
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(r.review_score IS NOT NULL) AS matched_reviews,
  ROUND(COUNTIF(r.review_score IS NOT NULL) / COUNT(*) * 100, 1) AS match_percent
FROM `ecommerce-logistics-510006.olist.olist_merged` AS m
LEFT JOIN `ecommerce-logistics-510006.olist.olist_reviews` AS r
  ON m.order_id = r.order_id
EOF

bq query --use_legacy_sql=false < check_join.sql
