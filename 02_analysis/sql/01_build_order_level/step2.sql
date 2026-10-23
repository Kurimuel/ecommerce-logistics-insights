cat > step2.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.tmp_orders` AS
SELECT
  order_id,
  ANY_VALUE(customer_state) AS customer_state,
  ANY_VALUE(order_status) AS order_status,
  ANY_VALUE(purchase_ts) AS purchase_ts,
  ANY_VALUE(delivered_ts) AS delivered_ts,
  ANY_VALUE(estimated_ts) AS estimated_ts,
  COUNT(*) AS n_items,
  SUM(price) AS order_price,
  SUM(freight_value) AS order_freight
FROM `ecommerce-logistics-510006.olist.tmp_items`
GROUP BY order_id
EOF

bq query --use_legacy_sql=false < step2.sql
