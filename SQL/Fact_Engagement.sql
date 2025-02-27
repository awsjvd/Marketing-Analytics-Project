------Query to check the duplicate values----------

select 
eg.EngagementDate,
eg.ContentID,
eg.ContentType,eg.CampaignID,
eg.ProductID,
count(*) as count
from engagement_data eg
where eg.Contenttype ! = 'NewsLetter'
group by eg.EngagementDate,
eg.ContentID,
eg.ContentType,
eg.EngagementDate,eg.CampaignID,
eg.ProductID
having count(*) > 1;

---------------Clean the Table ---------------------

select 
eg.ContentID,eg.CampaignID,eg.productid,eg.EngagementDate,
lower(replace(eg.ContentType,'Socialmedia','Social media ')) ContentType,
SUBSTRING(eg.ViewsClicksCombined,1,CHARINDEX('-',eg.ViewsClicksCombined)-1) as views,
SUBSTRING(eg.ViewsClicksCombined,CHARINDEX('-',eg.ViewsClicksCombined)+1,LEN(eg.ViewsClicksCombined)) as clicks,
eg.likes
from engagement_data eg
where eg.Contenttype ! = 'NewsLetter'

------Create the Fact Table -----

CREATE TABLE Fact_Engagement
(
    content_id INT,
    campaign_id INT,
    product_id INT,
    engagement_date DATE,
    content_type VARCHAR(255),
    views INT,
    clicks INT,
    likes INT
);

--------------Insert the clean data in the Fact Table ----------------

INSERT INTO Engagement_Fact(content_id, campaign_id, product_id, engagement_date, content_type, views, clicks, likes)
SELECT 
    eg.ContentID, 
    eg.CampaignID, 
    eg.productid, 
    eg.EngagementDate,
    LOWER(REPLACE(eg.ContentType, 'Socialmedia', 'Social media ')) AS ContentType,
    SUBSTRING(eg.ViewsClicksCombined, 1, CHARINDEX('-', eg.ViewsClicksCombined) - 1) AS views,
    SUBSTRING(eg.ViewsClicksCombined, CHARINDEX('-', eg.ViewsClicksCombined) + 1, LEN(eg.ViewsClicksCombined)) AS clicks,
    eg.likes
FROM engagement_data eg
WHERE eg.Contenttype != 'NewsLetter';


