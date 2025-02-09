--------- Check the duplicate records-----------------------
select cj.JourneyID,
cj.CustomerID,
cj.ProductID,
cj.VisitDate,
cj.stage,
cj.action,
cj.Duration,count(*)
from customer_journey cj
group by  cj.JourneyID,
cj.CustomerID,
cj.ProductID,
cj.VisitDate,
cj.stage,
cj.action,
cj.Duration
having count(*)>1;

--------------delete the duplicate record----------------

DELETE FROM customer_journey
WHERE JourneyID IN (
    SELECT JourneyID
    FROM customer_journey
    GROUP BY JourneyID, CustomerID, ProductID, VisitDate, stage, action, Duration
    HAVING COUNT(*) > 1
);

---------------------to check the unique journey id ----------------

SELECT JourneyID, COUNT(*) AS count
FROM customer_journey
GROUP BY JourneyID
HAVING COUNT(*) > 1;

---------------------Query to replace the null with the average of duration--------

with customer_average as 
(select JourneyID,
cast(avg(Duration) over (partition by VisitDate) as int) average_duration
from customer_journey )

select cj.JourneyID,
cj.CustomerID,
cj.ProductID,
CASE
When cj.stage = 'Checkout' then 'Check Out'
When cj.stage = 'ProductPage' then 'Product Page'
When cj.stage = 'Homepage' then 'Home page'
END as stage,
cj.VisitDate,
cj.action,
COALESCE(cj.Duration,ca.average_duration) as duration 
from customer_journey cj join customer_average ca
on ca.JourneyID = cj.JourneyID;


-- Query to create Fact_Customer_Journey Table -

create table Customer_Journey_Fact
(journey_id INT,
 customer_id INT,
 product_id INT,
 stage Varchar(100),
 visit_date Date,
 action Varchar(100),
 duration INT
)


;WITH customer_average AS (
    SELECT JourneyID,
           CAST(AVG(Duration) OVER (PARTITION BY VisitDate) AS INT) AS average_duration
    FROM customer_journey
)

INSERT INTO Customer_Journey_Fact(journey_id, customer_id, product_id, stage,visit_date, action, duration)
SELECT cj.JourneyID,
       cj.CustomerID,
       cj.ProductID,
       CASE
           WHEN cj.stage = 'Checkout' THEN 'Check Out'
           WHEN cj.stage = 'ProductPage' THEN 'Product Page'
           WHEN cj.stage = 'Homepage' THEN 'Home page'
       END AS stage,
       cj.VisitDate,
       cj.action,
       COALESCE(cj.Duration, ca.average_duration) AS duration
FROM customer_journey cj
JOIN customer_average ca ON ca.JourneyID = cj.JourneyID;

