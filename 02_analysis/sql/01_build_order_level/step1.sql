cat > step1.sql << 'EOF'
CREATE OR REPLACE TABLE `ecommerce-logistics-510006.olist.tmp_items` AS
SELECT
  order_id,
  order_item_id,
  ANY_VALUE(customer_state) AS customer_state,
  ANY_VALUE(order_status) AS order_status,
  ANY_VALUE(order_purchase_timestamp) AS purchase_ts,
  ANY_VALUE(order_delivered_customer_date) AS delivered_ts,
  ANY_VALUE(order_estimated_delivery_date) AS estimated_ts,
  MAX(price) AS price,
  MAX(freight_value) AS freight_value
FROM `ecommerce-logistics-510006.olist.olist_merged`
GROUP BY order_id, order_item_id
EOF

bq query --use_legacy_sql=false < step1.sql
