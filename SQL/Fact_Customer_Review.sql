---------------Create Table -------------------------

Create Table Fact_Customer_Review

   (review_id INT,
    customer_id INT,
	product_id  INT,
	review_date Date,
	rating INT,
	review_text Varchar(500)
   );

   Insert into Fact_Customer_Review (review_id,customer_id,product_id,review_date,rating,review_text)
   select 
   cr.ReviewID,
   cr.CustomerID,
   cr.ProductID,
   cr.reviewdate,
   cr.Rating, 
   replace(cr.ReviewText,'  ',' ') as ReviewText
   from customer_reviews cr;


===================verify the average=================
SELECT 
    CAST(SUM(rating * Frequency) AS FLOAT) / CAST(SUM(Frequency) AS FLOAT) AS Weighted_Average
FROM (
    SELECT rating, COUNT(*) AS Frequency
    FROM Fact_Customer_Review
    GROUP BY rating
) AS RatingDistribution;


--------------update dates------------

SELECT MIN(review_date) AS earliest_date, 
       MAX(review_date) AS latest_date
FROM Fact_Customer_Review;

UPDATE Fact_Customer_Review
SET review_date = CASE
    WHEN YEAR(review_date) = 2023 THEN DATEADD(YEAR, -1, review_date)
    WHEN YEAR(review_date) = 2024 THEN DATEADD(YEAR, -1, review_date)
    WHEN YEAR(review_date) = 2025 THEN DATEADD(YEAR, -1, review_date)
    ELSE review_date
END;
