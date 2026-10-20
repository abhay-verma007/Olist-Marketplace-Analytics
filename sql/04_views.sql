use olist_db;

CREATE VIEW v_orders_clean AS
SELECT *
FROM orders
WHERE order_status NOT IN ('canceled', 'unavailable');

Select count(*) From V_orders_clean limit 5;
																		## to get only Delivered Orders 

-----------------------------------------------------------------------------------------------------------------------------

CREATE VIEW v_reviews_clean AS
    Select * From(
			Select *, 
					Row_Number() Over (Partition by Order_ID Order By Review_answer_timestamp Desc) as SrNo
			From Order_Reviews
	) t
    Where SrNo = 1;
    
Select * From V_reviews_clean limit 5;
																## only the latest review per order

-----------------------------------------------------------------------------------------------------------------------------
CREATE VIEW v_geolocation_zip AS
SELECT geolocation_zip_code_prefix,
       AVG(geolocation_lat) AS lat,
       AVG(geolocation_lng) AS lng,
       MIN(geolocation_city) AS city,
       MIN(geolocation_state) AS state
FROM geolocation
GROUP BY geolocation_zip_code_prefix;

Select * From V_geolocation_zip limit 5;
													##one row per zip prefix for geolocation                                                                

-----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_order_items_clean AS
SELECT i.* 
FROM order_items i
JOIN v_orders_clean v ON v.order_id = i.order_id;

-----------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW v_order_payments_clean AS
SELECT p.* 
FROM order_payments p
JOIN v_orders_clean v ON v.order_id = p.order_id;

-----------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW v_reviews_clean AS
SELECT r.*
FROM (
		SELECT *, ROW_NUMBER() OVER (PARTITION BY order_id
                                 ORDER BY review_answer_timestamp DESC) AS rn
		FROM order_reviews
) r
JOIN v_orders_clean v ON v.order_id = r.order_id
WHERE r.rn = 1;
-----------------------------------------------------------------------------------------------------------------------------
SELECT COUNT(*) FROM v_reviews_clean;
SELECT COUNT(*) FROM v_geolocation_zip;
SELECT COUNT(*) FROM v_orders_clean;
SELECT COUNT(*) FROM v_order_items_clean;
SELECT COUNT(*) FROM v_order_payments_clean;
SELECT COUNT(*) FROM v_reviews_clean;
