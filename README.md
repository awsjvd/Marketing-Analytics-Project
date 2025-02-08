# Marketing Analytics Using SQL, Python & Power BI  

## Project Overview  
This project analyzes ShopEasy's marketing data using SQL for data transformation, Python for Sentiment Analysis, and Power BI for visualization. The goal is to improve customer engagement and conversion rates by deriving key marketing insights.  

## Tech Stack  
- SQL Server (Data Cleaning and Transformation)  
- Python (Sentiment Analysis)  
- Power BI (Data Modeling and Dashboard Insights)  

## Process  
1. **Data Extraction and Transformation**  
   - The dataset was available as an SQL dump and imported into SQL Server.  
   - SQL queries were used to clean and structure the data in the form of Fact and Dimension tables.  
   - Sentiment analysis was performed using Python, with results stored back into SQL Server.  

2. **Power BI Modeling**  
   - Data relationships were defined using a Star Schema model.  
   - Fact and Dimension tables were linked using Primary and Foreign keys.  

3. **Dashboard Creation**  
   - Customer Engagement Dashboard tracks campaign performance and conversion rates.  
   - Customer Sentiment Analysis Dashboard provides insights into positive and negative reviews.  
   - Product Performance Dashboard highlights conversion rates per product.  

## Data Model and ERD Diagram  
The data model follows a **Star Schema** structure:  
- **Fact Tables:** Store transactional and analytical data.  
- **Dimension Tables:** Contain reference data used for analysis.  

[View ERD Diagram](https://github.com/awsjvd/Marketing-Analytics-Project/blob/main/ERD/ERD.JPG)  

![ERD Diagram](https://github.com/awsjvd/Marketing-Analytics-Project/blob/main/ERD/ERD.JPG)  

## Dashboard Preview  
![Dashboard](https://github.com/awsjvd/Marketing-Analytics-Project/blob/main/Power%20BI/Marketing_Analytics.pdf)  

## Insights  
- **Customer Engagement**  
  - January had the highest conversion rate (18 percent), indicating effective campaigns.  
  - April and October had the lowest conversion rates, suggesting areas for improvement.  

- **Product Performance**  
  - High-performing products include Hockey Stick, Baseball Glove, and Cycling Helmet.  
  - Low-performing products like Swim Goggles and Running Shoes need targeted marketing efforts.  

- **Sentiment Analysis**  
  - Majority of customer reviews are positive, but common negative themes include pricing concerns, delivery speed, and product durability.  
  - Seasonal trends affect sentiment, with spikes in negative reviews during holidays.  

## How to Use  
1. Ensure Power BI Desktop is installed  
2. Open the `.pbix` file in Power BI  
3. Refresh the data connection if required  
4. Interact with the dashboards to explore insights   

## GitHub Repository  
[Marketing Analytics Project Repository](https://github.com/awsjvd/Marketing-Analytics-Project)  

This project provides actionable insights for improving marketing strategies. Let me know if you need any refinements.
