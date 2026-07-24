SET search_path TO raw;

DROP TABLE IF EXISTS
  olist_orders, olist_order_items, olist_order_payments,
  olist_order_reviews, olist_customers, olist_sellers,
  olist_products, olist_geolocation, product_category_name_translation
CASCADE;

CREATE TABLE olist_customers (
  customer_id              varchar(32),
  customer_unique_id       varchar(32),
  customer_zip_code_prefix varchar(8),
  customer_city            text,
  customer_state           varchar(4)
);

CREATE TABLE olist_sellers (
  seller_id              varchar(32),
  seller_zip_code_prefix varchar(8),
  seller_city            text,
  seller_state           varchar(4)
);

CREATE TABLE olist_orders (
  order_id                      varchar(32),
  customer_id                   varchar(32),
  order_status                  varchar(20),
  order_purchase_timestamp      timestamp,
  order_approved_at             timestamp,
  order_delivered_carrier_date  timestamp,
  order_delivered_customer_date timestamp,
  order_estimated_delivery_date timestamp
);

CREATE TABLE olist_order_items (
  order_id            varchar(32),
  order_item_id       integer,
  product_id          varchar(32),
  seller_id           varchar(32),
  shipping_limit_date timestamp,
  price               numeric(12,2),
  freight_value       numeric(12,2)
);

CREATE TABLE olist_order_payments (
  order_id             varchar(32),
  payment_sequential   integer,
  payment_type         varchar(30),
  payment_installments integer,
  payment_value        numeric(12,2)
);

CREATE TABLE olist_order_reviews (
  review_id               varchar(32),
  order_id                varchar(32),
  review_score            integer,
  review_comment_title    text,
  review_comment_message  text,
  review_creation_date     timestamp,
  review_answer_timestamp  timestamp
);

CREATE TABLE olist_products (
  product_id                 varchar(32),
  product_category_name      text,
  product_name_lenght        integer,
  product_description_lenght integer,
  product_photos_qty         integer,
  product_weight_g           integer,
  product_length_cm          integer,
  product_height_cm          integer,
  product_width_cm           integer
);

CREATE TABLE olist_geolocation (
  geolocation_zip_code_prefix varchar(8),
  geolocation_lat             numeric(12,8),
  geolocation_lng             numeric(12,8),
  geolocation_city            text,
  geolocation_state           varchar(4)
);

CREATE TABLE product_category_name_translation (
  product_category_name         text,
  product_category_name_english text
);