# Venice Airbnb Price Estimation

This project analyzes Airbnb listings in Venice, Italy using statistical learning methods. The goal is to understand what drives listing prices and to identify meaningful market segments.

## Project Objectives

- Identify the key factors influencing Airbnb prices
- Segment listings into distinct groups using clustering
- Compare predictive models for price estimation

## Dataset

- Original dataset: 8,590 listings, 79 variables
- Final dataset: 6,452 listings, 33 variables
- Removed:
  - URLs, text descriptions, images
  - date-related variables
- All missing values removed (complete-case approach)

## Data Preprocessing

- Converted price from string to numeric
- Removed top 1% of price outliers
- Applied log transformation:
  - `log_price = log(price)`
- Selected variables related to:
  - property size (accommodates, bedrooms, bathrooms, beds)
  - host characteristics
  - reviews and ratings
  - availability and booking rules

## Exploratory Data Analysis

Key findings:

- Price is highly right-skewed → log transformation improves distribution
- Larger listings tend to have higher prices
- Significant variation remains across listings

Visualizations include:
- Price histogram
- Log-price histogram
- Price vs accommodates scatterplot

## Correlation Analysis

Strongest relationships with price:

- accommodates (0.44)
- bedrooms (0.41)
- bathrooms (0.38)
- beds (0.34)

Conclusion:
- Property size is the main driver of price
- Review scores also have a moderate effect

## Principal Component Analysis (PCA)

PCA identified key dimensions:

1. Review quality
2. Property size
3. Listing activity/popularity
4. Host behavior

This helped guide clustering.

## Clustering (K-Means)

- Used elbow method → optimal clusters = 4
- Market segments identified:

1. Premium large listings (high price, large size)
2. High-rated listings
3. Mid-range listings
4. Smaller budget listings

This shows the Airbnb market is not homogeneous.

## Supervised Learning Models

Target variable: `log_price`  
Train-test split: 70/30

### Models used:

- Multiple Linear Regression  
  - R² ≈ 0.40  
  - RMSE ≈ 0.425  

- LASSO Regression  
  - RMSE ≈ 0.425  
  - No improvement → model already well specified  

- Decision Tree  
  - RMSE ≈ 0.432  
  - Less stable, higher variance  

- Random Forest ✅ (Best model)  
  - RMSE ≈ 0.354  
  - ~17% improvement over linear regression  

## Key Insights

- Property size is the strongest determinant of price
- Entire homes are significantly more expensive than private/shared rooms
- Review ratings positively impact pricing
- Market segmentation (clusters) captures real structure in the data
- Random Forest captures nonlinear relationships better than linear models

## Project Structure

- `sl-venice.R` → main analysis script  
- `.png` files → visualizations  
- `.Rproj` → project configuration  

## How to Run

1. Open the project in RStudio or VS Code
2. Run the script
3. The script performs:
- data cleaning
- analysis
- modeling
- visualization

## Tools Used

- R
- Statistical Learning methods:
- Linear Regression
- LASSO
- Decision Trees
- Random Forest
- PCA
- K-Means Clustering

---

## Author

Pardis Attar