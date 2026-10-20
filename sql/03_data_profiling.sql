use olist_db;
---------------------------------------------------------------------------------------------------------------------
Select count(*) from customers;    ## 99441
Select count(*) from geolocation;   ##1000163
Select count(*) from order_items;    ##112650
Select count(*) from order_payments;   ##103886
Select count(*) from order_reviews;     ##99224
Select count(*) from orders;         ##99441
Select count(*) from product_cat_name_translation;  ##71
Select count(*) from products;     ##32951
Select count(*) from sellers;      ##3095

---------------------------------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
SET SESSION sql_mode = '';                   ## To Allow Updates

---------------------------------------------------------------------------------------------------------------------

UPDATE orders SET order_approved_at = NULL WHERE YEAR(order_approved_at) = 0;
UPDATE orders SET order_delivered_carrier_date = NULL WHERE YEAR(order_delivered_carrier_date) = 0;
UPDATE orders SET order_delivered_customer_date = NULL WHERE YEAR(order_delivered_customer_date) = 0;    ## Fix to Fill NULL in Orders Table where Year was 0

---------------------------------------------------------------------------------------------------------------------
UPDATE products SET product_category_name = NULL WHERE product_category_name = '';
UPDATE products SET product_name_length = NULL WHERE product_name_length = 0;
UPDATE products SET product_description_length = NULL WHERE product_description_length = 0;
UPDATE products SET product_photos_qty = NULL WHERE product_photos_qty = 0;
UPDATE products SET product_weight_g = NULL WHERE product_weight_g = 0;
UPDATE products SET product_weight_g = 0 WHERE product_weight_g IS NULL AND product_length_cm > 0;
																			      	## Fix to Fill NULL in PRODUCTS Table where THESE THINGS was 0 OR ''

---------------------------------------------------------------------------------------------------------------------

UPDATE order_reviews SET review_comment_title = NULL WHERE review_comment_title = '';
UPDATE order_reviews SET review_comment_message = NULL WHERE review_comment_message = '';
																						## Fix to Fill NULL in ORDER_REVIEWS Table where THESE THINGS was ''

---------------------------------------------------------------------------------------------------------------------
Select
		Count(Distinct Customer_unique_id),
        count(Distinct Customer_id)
From Customers;                                 ## 96096 Customers Ordered many times i.e. 99441


---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) - count(Distinct Order_id)
From Order_Reviews;                                 ## 551 Means some unique Order_ids reviewed more than 1 time.


---------------------------------------------------------------------------------------------------------------------

Select Count(*) From (
	Select
			order_id,
			count(review_id) as Nos_Reviews
	From Order_reviews
	Group By Order_id
	Having Nos_Reviews > 1
) t;
													## 547 orders have more than one review

---------------------------------------------------------------------------------------------------------------------
Select count(*) From (
	Select
			O.Order_id
	From Orders O
	Left Join Order_items OI on OI.order_id = O.order_id
	Where OI.Order_item_id is Null
)t;
												##  775 orders have no items
                                                
---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Approved
From Orders
Where Order_approved_at is Null;
												##  160 Orders have Null Values in Approved Orders
                                                
---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Delivered_carrier
From Orders
Where order_delivered_carrier_date is Null;
												##  1783 Orders have Null Values in Delivered Carrier

---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Delivered_custormer
From Orders
Where order_delivered_customer_date is Null;
												##  2965 Orders have Null Values in Delivered Customer Date
                                                
---------------------------------------------------------------------------------------------------------------------
Select Count(*) From (
	Select
			Order_id
	From Orders
	Where Order_status = 'delivered' 
	and order_delivered_customer_date is Null
) t;
												##  8 orders are marked delivered but have no delivery date
                                                
---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Category
From Products
Where Product_Category_name is Null;
												##  610 products have no category     

---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Weight
From Products
Where Product_weight_g is Null;
												##  2 rows in Products weight have Null Values  

---------------------------------------------------------------------------------------------------------------------
Select
		Count(*) as Cnt_Delivered
From Orders
Where Order_status = 'Delivered';
												##  96478 Orders Have been Delivered
                                                
---------------------------------------------------------------------------------------------------------------------
Select
		Count(Distinct Payment_type ) as Cnt_Payment_type
From Order_Payments;
												##  5 Types of Order Payments types is occured

---------------------------------------------------------------------------------------------------------------------
Select 
	payment_type,
	count(*)
From Order_Payments
Group by payment_type;
										## Credit_card = 76795, Boleto = 19784, Voucher = 5775
                                        ## Debit_Card = 1529, Not_defined = 3
                                        
---------------------------------------------------------------------------------------------------------------------
SELECT 
		MIN(price), 
        MAX(price), 
        MIN(freight_value), 
        MAX(freight_value)
FROM order_items;
										##  R$. 6735/- is Max Price
                                        ##  R$. 0.85/- is Min Price
                                        
Select 
        Round(Avg(price),2) as Avg_price
From order_items;
										##  R$. 120.65/- is Average Price of Orders_Items

---------------------------------------------------------------------------------------------------------------------
Select Order_id,
		Max(freight_Value) as FreightMax,
        Min(freight_Value) as FreightMin
From order_items
group by order_id
Order by FreightMax Desc lIMIT 1;
										##  Rs.409.68/- is Max Freight Value and also the Minimum Freight Value of Orders_Items
                                        
Select 
        Round(Avg(freight_Value),2) as Avg_freight_Value
From order_items;
										##  Rs 19.99/- is Average Price of Orders_Items
                                        
---------------------------------------------------------------------------------------------------------------------
select 
		count(*)
From order_payments  					## 9 rows where payment value is ZERO
where payment_value = 0;

select 
		count(*)
From order_payments 					## 2 rows where payment installment is ZERO that means paid in full one time
where payment_installments = 0;

--------------------------------------------------------------------------------------------------------------------

Select 
		Min(Order_purchase_timestamp) as First_Order_Date,
        Max(Order_purchase_timestamp) as Last_Order_Date
From Orders;
														## Sept 2016 was First order Date
                                                        ## Oct 2018 was Last Order Date
                                                        
--------------------------------------------------------------------------------------------------------------------

Select count(*) From (
	Select 
			Distinct p.Product_category_name
	From Products P 
	Left Join Product_cat_name_translation PT
	on p.Product_category_name = PT.Product_category_name
	Where PT.Product_category_name_english is null AND P.product_category_name IS NOT NULL
) t;
                                                        ## 2 categories have no English translation
                                                        
--------------------------------------------------------------------------------------------------------------------
Select count(*) From (
	Select *
	From Orders
	Where order_delivered_carrier_date < order_purchase_timestamp
) t;
                                                        ## 166 orders have a carrier date before the purchase date
                                                        
--------------------------------------------------------------------------------------------------------------------

SELECT 
		COUNT(*) - 
		COUNT(DISTINCT geolocation_zip_code_prefix, geolocation_lat, geolocation_lng,
				BINARY geolocation_city, BINARY geolocation_state) AS duplicate_rows
FROM geolocation;
														## 261836 Rows are duplicate in geolocation tables

--------------------------------------------------------------------------------------------------------------------

Select
		SUM(price) as Total_Price
From Order_items;
														## 1,35,91,643.70/- is TOTAL PRICE OF ORDERS THAT HAVE BEEN ORDERED

--------------------------------------------------------------------------------------------------------------------

Select
		SUM(freight_value) as Total_freight_Value
From Order_items;
														## 22,51,909.54/- is TOTAL FREIGHT VALUE OF ORDERITEMS

--------------------------------------------------------------------------------------------------------------------

Select
		SUM(payment_value) as Total_payment_value
From Order_payments;
														## 1,60,08,872.12/- is Total Payments paid by customers

--------------------------------------------------------------------------------------------------------------------
Select count(*) from (
	Select
			Distinct O.Order_id
	From Orders O
	Left Join Order_items I on O.order_id = I.order_id
	where i.order_item_id is not null
) t; 												## 98,666 Orders are with Items 