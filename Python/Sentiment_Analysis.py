import pandas as pd
from sqlalchemy import create_engine
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# (Optional) Uncomment the next line if you haven't already downloaded the VADER lexicon
# nltk.download('vader_lexicon')

def connect_SQL():
   # Define connection parameters
   server = r'<YOUR_SERVER_NAME>'  # Replace with your server name
   database = '<YOUR_DATABASE_NAME>'  # Replace with your database name
      
    # Connection string for Windows Authentication
    connection_url = (
        f"mssql+pyodbc://@{server}/{database}"
        f"?driver=ODBC+Driver+17+for+SQL+Server&Trusted_Connection=yes"
    )
    
    # Create the SQLAlchemy engine
    engine = create_engine(connection_url)  # echo=True can be added for debugging
    
    # Fetch data from SQL table
    query = (
        "SELECT review_id, customer_id, product_id, review_date, rating, review_text "
        "FROM Fact_Customer_Reviews"
    )
    df = pd.read_sql(query, engine)
    print("Data loaded successfully!")
    print(df.head())
    
    # Return both the engine and the DataFrame so we can write back to SQL Server later
    return engine, df

# Get the engine and customer reviews DataFrame from SQL Server
engine, customer_reviews_df = connect_SQL()

# Initialize the VADER sentiment intensity analyzer
sia = SentimentIntensityAnalyzer()

def calculate_sentiment(review):
    """Calculate the compound sentiment score for a given review text."""
    sentiment = sia.polarity_scores(review)
    return sentiment['compound']

def categorize_sentiment(score, rating):
    """
    Categorize sentiment based on the VADER compound score and the numerical rating.
    Returns one of the sentiment categories.
    """
    if score > 0.05:  # Positive sentiment score
        if rating >= 4:
            return 'Positive'  # High rating and positive sentiment
        elif rating == 3:
            return 'Mixed Positive'  # Neutral rating but positive sentiment
        else:
            return 'Mixed Negative'  # Low rating but positive sentiment
    elif score < -0.05:  # Negative sentiment score
        if rating <= 2:
            return 'Negative'  # Low rating and negative sentiment
        elif rating == 3:
            return 'Mixed Negative'  # Neutral rating but negative sentiment
        else:
            return 'Mixed Positive'  # High rating but negative sentiment
    else:  # Neutral sentiment score
        if rating >= 4:
            return 'Positive'  # High rating with neutral sentiment
        elif rating <= 2:
            return 'Negative'  # Low rating with neutral sentiment
        else:
            return 'Neutral'  # Neutral rating and neutral sentiment

def sentiment_bucket(score):
    """
    Bucket the sentiment score into a defined range.
    Returns a string representing the bucket.
    """
    if score >= 0.5:
        return '0.5 to 1.0'  # Strongly positive sentiment
    elif 0.0 <= score < 0.5:
        return '0.0 to 0.49'  # Mildly positive sentiment
    elif -0.5 <= score < 0.0:
        return '-0.49 to 0.0'  # Mildly negative sentiment
    else:
        return '-1.0 to -0.5'  # Strongly negative sentiment

# Apply sentiment analysis on the review text
customer_reviews_df['SentimentScore'] = customer_reviews_df['review_text'].apply(calculate_sentiment)

# Categorize sentiment by combining the text sentiment score and the review rating
customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: categorize_sentiment(row['SentimentScore'], row['rating']), axis=1)

# Bucket the sentiment scores into defined ranges
customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)

# Display the first few rows of the DataFrame with sentiment data
print(customer_reviews_df.head())

# Write the processed DataFrame to a new SQL Server table.
# The table 'customer_reviews_facts_with_sentiment' will be created or replaced if it exists.
customer_reviews_df.to_sql('customer_reviews_facts_with_sentiment', engine, if_exists='replace', index=False)
print("Data stored successfully in SQL Server!")
