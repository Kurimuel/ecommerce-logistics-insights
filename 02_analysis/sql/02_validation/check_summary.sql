bq ls olist

cat > check_summary.sql << 'EOF'
SELECT 'kpi_monthly' AS tbl, COUNT(*) AS n_rows, SUM(orders) AS total_orders
FROM `ecommerce-logistics-510006.olist.kpi_monthly`
UNION ALL
SELECT 'kpi_state', COUNT(*), SUM(orders)
FROM `ecommerce-logistics-510006.olist.kpi_state`
UNION ALL
SELECT 'delay_freight_matrix', COUNT(*), SUM(orders)
FROM `ecommerce-logistics-510006.olist.delay_freight_matrix`
EOF

bq query --use_legacy_sql=false < check_summary.sql
