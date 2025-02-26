# R_Sales_Data_Analysis

This repository contains an analysis of daily sales data for a store in Germany (store ID: 558) for the year 2014. The dataset, provided in the included rossmann_sales_data.xlsx file, includes sales data for each day in 2014. The analysis focuses on exploring various aspects of sales performance, including sales trends, correlations with customer numbers, and forecasts for future sales.

### Data Overview
The dataset consists of the following columns:

- sklep_id: Store ID
- dzien_tyg: Day of the week (numeric representation)
- data: Date (YYYY-MM-DD)
- sprzedaz: Daily sales amount
- liczba_klientow: Number of customers
- czy_otwarty: Store open status (Yes/No)
- czy_promocja: Whether there was a promotion (Yes/No)
- czy_swieto: Whether it was a holiday (Yes/No)
- czy_swieto_szkolne: Whether it was a school holiday (Yes/No)
- sklep_typ: Store type (Basic, Premium, etc.)
- sklep_asort: Store assortment type
- sklep_konkurencja: Competitor store sales figure

### Analysis Process
The analysis follows several steps:

#### Data Loading and Preview:
- The dataset is loaded using the openxlsx package, and a preview of the data is provided using the head() function.

#### Basic Sales Statistics:
- Summary statistics are calculated for the daily sales (sprzedaz) using the summary() and descr() functions.

#### Data Filtering:
- The dataset is filtered to include only the days when the store was open (czy_otwarty == "Tak").

#### Exploratory Data Visualization:
- A histogram and a boxplot are created to visualize the distribution of daily sales.

#### Correlation Analysis:
- The correlation between the number of customers and daily sales is computed, and a linear regression model is built to predict sales based on the number of customers.

#### Sales Forecasting:
- A time series model is used to forecast sales trends based on monthly sales data, including visualizations and model performance evaluation.

#### Scatter Plot and Regression Line:
- A scatter plot with a regression line is created to further investigate the relationship between the number of customers and daily sales.

#### Monthly Sales Analysis:
- Monthly sales totals are calculated and visualized to identify overall trends.

#### Sales Forecast for January 2015:
- A forecast for the next month (January 2015) is made using the time series model.

### Libraries Used
- **`dplyr`**: Data manipulation and transformation
- **`ggplot2`**: Data visualization (e.g., histograms, boxplots, scatter plots)
- **`summarytools`**: Descriptive statistics and summary reports
- **`knitr`**: Table formatting and report generation
- **`lubridate`**: Date and time manipulation
- **`forecast`**: Time series analysis and forecasting

### Files Included
- rossmann_sales_data.xlsx: Excel file containing the sales data
- rossmann_sales_analysis.R: R code implementing the data analysis and visualization
