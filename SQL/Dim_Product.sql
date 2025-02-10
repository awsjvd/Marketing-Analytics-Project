
-----------Query to reshape the table as per the requrinment --------

select p.ProductID,
       p.ProductName,
	   CASE
	   When P.price < 50 Then 'Low'
	   When P.Price between 50 and 100 then 'Medium'
	   Else 'High'
	   END As PriceCategory 
	   from products p;


	   create table Dim_Product
	   (product_id INT,
	    product_Name Varchar(255),
	     price_category varchar(50)
	   );

---------Insert the Data into the dimesion table--------------

	   Insert into Dim_Product (product_id,product_Name,price_category)
	   
select p.ProductID,
       p.ProductName,
	   CASE
	   When P.price < 50 Then 'Low'
	   When P.Price between 50 and 100 then 'Medium'
	   Else 'High'
	   END As PriceCategory 
	   from products p;

