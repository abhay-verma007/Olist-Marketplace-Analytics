-----------------------------------------------------------------------------------------------------------------------------
-- CREATE DATABASE olist_db CHARACTER SET utf8mb4;

-----------------------------------------------------------------------------------------------------------------------------
USE olist_db; 

-----------------------------------------------------------------------------------------------------------------------------
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

-----------------------------------------------------------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_customers_dataset.csv'
INTO TABLE CUSTOMERS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM Customers;
-----------------------------------------------------------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_sellers_dataset.csv'
INTO TABLE SELLERS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM SELLERS;


-----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/product_category_name_translation.csv'
INTO TABLE PRODUCT_CAT_NAME_TRANSLATION
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM PRODUCT_CAT_NAME_TRANSLATION;

-----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_products_dataset.csv'
INTO TABLE PRODUCTS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM PRODUCTS;

-----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_orders_dataset.csv'
INTO TABLE ORDERS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM ORDERS;

-----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_order_items_dataset.csv'
INTO TABLE ORDER_ITEMS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM ORDER_ITEMS;

-----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_order_payments_dataset.csv'
INTO TABLE ORDER_PAYMENTS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) FROM ORDER_PAYMENTS;

----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_order_reviews_dataset.csv'
INTO TABLE ORDER_REVIEWS
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ESCAPED BY ''
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM ORDER_REVIEWS;

----------------------------------------------------------------------------------------------------------------------------

LOAD DATA LOCAL INFILE 'D:/Data_Analytics/Project_2/SQL_Kaggle_Dataset_Olist/olist_geolocation_dataset.csv'
INTO TABLE GEOLOCATION
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM GEOLOCATION;

----------------------------------------------------------------------------------------------------------------------------
## TO COUNT ALL TABLES INFORMATION

SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL SELECT 'product_cat_name_translation', COUNT(*) FROM product_cat_name_translation;