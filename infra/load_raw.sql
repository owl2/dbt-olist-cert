-- infra/load_raw.sql
SET search_path TO raw;

\echo '→ customers'
COPY olist_customers FROM '/data/raw/olist_customers_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ sellers'
COPY olist_sellers FROM '/data/raw/olist_sellers_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ orders'
COPY olist_orders FROM '/data/raw/olist_orders_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ order_items'
COPY olist_order_items FROM '/data/raw/olist_order_items_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ payments'
COPY olist_order_payments FROM '/data/raw/olist_order_payments_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ reviews'
COPY olist_order_reviews FROM '/data/raw/olist_order_reviews_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ products'
COPY olist_products FROM '/data/raw/olist_products_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ geolocation'
COPY olist_geolocation FROM '/data/raw/olist_geolocation_dataset.csv'
  WITH (FORMAT csv, HEADER true);

\echo '→ category translation'
COPY product_category_name_translation FROM '/data/raw/product_category_name_translation.csv'
  WITH (FORMAT csv, HEADER true);

-- Index minimaux : accélèrent nettement les jointures de la couche staging
CREATE INDEX ON olist_orders (order_id);
CREATE INDEX ON olist_orders (customer_id);
CREATE INDEX ON olist_order_items (order_id);
CREATE INDEX ON olist_order_payments (order_id);
CREATE INDEX ON olist_order_reviews (order_id);
CREATE INDEX ON olist_geolocation (geolocation_zip_code_prefix);

ANALYZE;