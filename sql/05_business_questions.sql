
Select
		Sum(i.price) as Total_Revenue
From order_items i
Join v_orders_clean v on i.order_id = v.order_id;
														## Total Revenue of Valid Orders R$. 1,34,94,400.74 
                                                        ## [Acutal Orders Except Cancelled or unavailable]

-----------------------------------------------------------------------------------------------------------------------------------------------
Select
		Date_Format(V.order_purchase_timestamp, '%Y-%m')	as Order_Months,
        Count(Distinct v.Order_id) 							as Total_Orders,
        Round(Sum(i.price),2) 								as Total_Revenue
From order_items i
Join v_orders_clean v on i.order_id = v.order_id
Group By Order_Months
Order By Order_Months;
														## Total Orders and Total revenue PER MONTH
---------------------------------------------------------------------------------------------------------------------------------------------

Select
		Coalesce(t.Product_Category_name, t.Product_Category_name_English,'Unknown')			as Category_Name,
        Round(Sum(i.price),2) 																	as Total_Revenue
From order_items i
Join v_orders_clean v 					 	on i.order_id = v.order_id
Join Products P							 	on p.product_id = i.product_id
Left Join product_cat_name_translation t 	on t.product_category_name = p.product_category_name 
Group By Category_Name
Order By Total_Revenue Desc
LIMIT 10;
														## Category Wise Total Revenue  [TOP 10]
                                                        ## Hence Beleza_saude is top 1 i.e. R$ 12,55,695.13/-
---------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
		c.customer_state   AS state,
		COUNT(*)           AS total_orders
FROM v_orders_clean v
JOIN customers c ON c.customer_id = v.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;
														## State wise Count of Customers Order [TOP 10]
                                                        ## Hence SP is top 1 i.e. 41127                                                        
---------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
		Round(Avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),2)   AS Avg_Delivery_Days
FROM v_orders_clean
Where order_status = 'Delivered' and order_delivered_customer_date is not null;

														## Avg Delivery Day
                                                        ## Hence 12.50 Days taken to delivery as Average                  


---------------------------------------------------------------------------------------------------------------------------------------------


SELECT COUNT(*) AS 	Orders_Delivered,
       SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1 ELSE 0 END) AS Late_Delivery_Orders,
       ROUND(100 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                            THEN 1 ELSE 0 END) / COUNT(*), 2) AS Late_Orders_prcntge
FROM v_orders_clean
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;

														## Late Deliveries [Not Delivered as per expected time]
                                                        ## Hence 7826 Deliveries are Late which is 8.11% of Delivered Orders
---------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
		OP.Payment_type,
        Count(Distinct v.Order_id) 				As Total_Orders,
        Sum(OP.Payment_value)			As Total_Payment
FROM Order_Payments OP
Join v_orders_clean v on op.Order_id = v.order_id
Group By OP.payment_type;

														## Types of Payment Mode
                                                        ## Credit Card has Highest Total Orders i/c Total Payments
---------------------------------------------------------------------------------------------------------------------------------------------
SELECT review_score,
       COUNT(*) AS total_reviews
FROM v_reviews_clean
GROUP BY review_score
ORDER BY review_score;
														## Count of Reviews By Score [Total Sum of Reviews is 97473]
                                                        
SELECT ROUND(AVG(review_score), 2) AS avg_score
FROM v_reviews_clean;
														## Avg of total Reviews Score = 4.12

---------------------------------------------------------------------------------------------------------------------------------------------                                                        
                                                        
SELECT CASE WHEN v.order_delivered_customer_date > v.order_estimated_delivery_date
            THEN 'Late' ELSE 'On time' END   AS delivery_status,
       COUNT(*)                              AS orders_reviewed,
       ROUND(AVG(r.review_score), 2)         AS avg_review_score
FROM v_orders_clean v
JOIN v_reviews_clean r ON r.order_id = v.order_id
WHERE v.order_status = 'delivered'
  AND v.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;
																		## Late vs on-time reviews
                                                                        ## On Time = 88163 Orders get Reviewed & Avg Review Score is 4.29
                                                                        ## Late  = 7661 Orders get Reviewed & Avg Review Score is 2.57
                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------   
                                                                        
SELECT i.seller_id,
       s.seller_state,
       ROUND(SUM(i.price), 2) AS revenue
FROM v_orders_clean v
JOIN order_items i ON i.order_id = v.order_id
JOIN sellers s     ON s.seller_id = i.seller_id
GROUP BY i.seller_id, s.seller_state
ORDER BY revenue DESC
LIMIT 10;
																		## Top 10 sellers by revenue 
                                                                        ## Higest Seller's Revenue is R$ 229237.63/-