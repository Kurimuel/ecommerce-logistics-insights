cat > step3.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.tmp_latest_review` AS
SELECT order_id, review_score
FROM `ecommerce-logistics-510006.olist.olist_reviews`
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY order_id
  ORDER BY review_answer_timestamp DESC
) = 1
EOF

bq query --use_legacy_sql=false < step3.sql
