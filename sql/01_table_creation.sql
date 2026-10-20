------------------------------------------------------------------------------------------------------------------------
use olist_db;
------------------------------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS (
  customer_id varchar(50) NOT NULL,
  Customer_unique_id varchar(50) NOT NULL,
  customer_zip_code_prefix char(5) NOT NULL,
  customer_city varchar(50) NOT NULL,
  customer_state Char(2) NOT NULL,
  PRIMARY KEY (Customer_id)
);

DESCRIBE CUSTOMERS;
------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SELLERS (
  seller_id varchar(50) NOT NULL,
  seller_zip_code_prefix char(5) NOT NULL,
  seller_city varchar(50) NOT NULL,
  seller_state Char(2) NOT NULL,
  PRIMARY KEY (seller_id)
);

DESCRIBE SELLERS;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PRODUCT_CAT_NAME_TRANSLATION (
  product_category_name varchar(100) NOT NULL,
  product_category_name_english varchar(100) NOT NULL,
  PRIMARY KEY (product_category_name)
);

DESCRIBE PRODUCT_CAT_NAME_TRANSLATION;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE PRODUCTS (
  product_id varchar(50) NOT NULL,
  product_category_name varchar(100),
  product_name_length INT(5),
  product_description_length INT(10),
  product_photos_qty INT(5),
  product_weight_g INT(10),
  product_length_cm INT(10),
  product_height_cm INT(10),
  product_width_cm INT(10),
  PRIMARY KEY (product_id)
);

DESCRIBE PRODUCTS;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ORDERS (
	order_id varchar(50) NOT NULL,
	customer_id varchar(50) NOT NULL,
	order_status varchar(15),
	order_purchase_timestamp datetime,
	order_approved_at datetime,
	order_delivered_carrier_date datetime,
	order_delivered_customer_date datetime,
	order_estimated_delivery_date datetime,
	PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

	DESCRIBE ORDERS; 

-- ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_ITEMS (
	order_id varchar(50) NOT NULL,
	order_item_id INT NOT NULL,
    product_id varchar(50) NOT NULL,
	seller_id varchar(50) NOT NULL,
	shipping_limit_date datetime,
	price decimal(10,2),
	freight_value decimal(10,2),
	PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id),
    FOREIGN KEY (seller_id) REFERENCES SELLERS(seller_id)
);

	DESCRIBE ORDER_ITEMS; 
    
    
-- ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_PAYMENTS (
	order_id varchar(50) NOT NULL,
	payment_sequential INT NOT NULL,
    payment_type varchar(20) NOT NULL,
	payment_installments INT NOT NULL,
	payment_value decimal(10,2),
	PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

	DESCRIBE ORDER_PAYMENTS; 
    ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ORDER_REVIEWS (
	review_id varchar(50) NOT NULL,
	order_id varchar(50) NOT NULL,
	review_score INT NOT NULL,
    review_comment_title varchar(50),
	review_comment_message varchar(350),
	review_creation_date datetime,
    review_answer_timestamp datetime,
	PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

	DESCRIBE ORDER_REVIEWS; 
--     
    ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE GEOLOCATION (
	geolocation_zip_code_prefix char(5) NOT NULL,
    geolocation_lat decimal(10,8),
	geolocation_lng decimal(11,8),
	geolocation_city varchar(50),
    geolocation_state Char(2)
);

	DESCRIBE GEOLOCATION; 
    
    ------------------------------------------------------------------------------------------------------------------------