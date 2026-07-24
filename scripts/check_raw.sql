-- scripts/check_raw.sql
\echo '=== Volumétrie ==='
SELECT 'orders' AS t, count(*) FROM raw.olist_orders
UNION ALL SELECT 'order_items', count(*) FROM raw.olist_order_items
UNION ALL SELECT 'payments',    count(*) FROM raw.olist_order_payments
UNION ALL SELECT 'reviews',     count(*) FROM raw.olist_order_reviews
UNION ALL SELECT 'customers',   count(*) FROM raw.olist_customers
UNION ALL SELECT 'sellers',     count(*) FROM raw.olist_sellers
UNION ALL SELECT 'products',    count(*) FROM raw.olist_products
UNION ALL SELECT 'geolocation', count(*) FROM raw.olist_geolocation
UNION ALL SELECT 'categories',  count(*) FROM raw.product_category_name_translation
ORDER BY 1;

\echo '=== Unicité des clés attendues ==='
SELECT
  count(*)                        AS n_rows,
  count(DISTINCT order_id)        AS n_orders,
  count(*) - count(DISTINCT order_id) AS doublons
FROM raw.olist_orders;

\echo '=== customer_id vs customer_unique_id ==='
SELECT
  count(*)                            AS lignes,
  count(DISTINCT customer_id)         AS ids_par_commande,
  count(DISTINCT customer_unique_id)  AS personnes_reelles
FROM raw.olist_customers;

\echo '=== Amplitude temporelle ==='
SELECT
  min(order_purchase_timestamp) AS premiere,
  max(order_purchase_timestamp) AS derniere
FROM raw.olist_orders;

\echo '=== Répartition des statuts ==='
SELECT order_status, count(*) AS n
FROM raw.olist_orders
GROUP BY 1 ORDER BY 2 DESC;

\echo '=== Complétude des horodatages ==='
SELECT
  count(*) FILTER (WHERE order_approved_at IS NULL)             AS sans_approbation,
  count(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS sans_livraison
FROM raw.olist_orders;

\echo '=== Intégrité référentielle (orphelins) ==='
SELECT count(*) AS items_sans_commande
FROM raw.olist_order_items i
LEFT JOIN raw.olist_orders o USING (order_id)
WHERE o.order_id IS NULL;

\echo '=== Cardinalité geolocation ==='
SELECT
  count(*)                                  AS lignes,
  count(DISTINCT geolocation_zip_code_prefix) AS zips_distincts
FROM raw.olist_geolocation;