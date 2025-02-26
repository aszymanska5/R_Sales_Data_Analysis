rossmann <- openxlsx::read.xlsx("rossmann_sales_data.xlsx")

# Loading libraries
library(dplyr)  
library(ggplot2) 
library(summarytools)
library(knitr)
library(lubridate)
library(forecast)

# Data preview
head(rossmann)  

# Basic daily sales statistics
summary(rossmann$sprzedaz)

view(descr(rossmann$sprzedaz))

view(dfSummary(rossmann$sprzedaz))

# Filtering data on days when the store was open
sales_data <- rossmann %>% filter(czy_otwarty == "Tak")

# Changing the data type to date
sales_data$data <- as.Date(sales_data$data, format="%Y-%m-%d")

# Daily sales histogram
ggplot(sales_data, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 50, fill = "blue", color = "black") +
  scale_x_continuous(breaks = c(2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500)) +
  xlab("Sales") +
  ylab("Frequency") 

# Daily sales boxplot
ggplot(sales_data, aes(x = "", y = sprzedaz)) +
  geom_boxplot(fill = "lightblue", color = "black", width = 0.3) +
  ylab("Daily sales") +
  xlab(NULL) +
  theme_minimal()

# Correlation coefficien
correlation <- cor(sales_data$sprzedaz, sales_data$liczba_klientow)
print(paste("Correlation coefficien: ", round(correlation, 2)))

# Linear regression model
model <- lm(sprzedaz ~ liczba_klientow, data=sales_data)
summary(model)

# Predicted sales for 100 customers
predicted_sales <- predict(model, data.frame(liczba_klientow=100))
print(paste("Predicted sales for 100 customers: ", round(predicted_sales, 2)))

# Scatter plot with regression line
plot(sales_data$liczba_klientow, sales_data$sprzedaz, 
     main="Sales vs. Number of customers", 
     xlab="Number of customers", 
     ylab="Sales", 
     pch=16, col="blue")
abline(model, col="red", lwd=2)

# Total monthly sales
monthly_sales <- sales_data %>%
  mutate(rok_miesiac = format(data, "%Y-%m")) %>%
  group_by(rok_miesiac) %>%
  summarise(sprzedaz_miesieczna = sum(sprzedaz))

print(monthly_sales)
kable(monthly_sales)

# Sales trend based on monthly sales data
ts_sales <- ts(monthly_sales$sprzedaz_miesieczna, start=c(min(year(sales_data$data)), min(month(sales_data$data))), frequency=12)
trend_model <- tslm(ts_sales ~ trend)
summary(trend_model)
checkresiduals(trend_model)
accuracy(trend_model)

# Scatter plot to visualize the relationship between the number of customers and sales
ggplot(sales_data, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point() +  
  ylab("Sales") +
  xlab("Number of custommers") +
  geom_smooth(method = "lm", se = FALSE, color = "blue")  

# Forecast sales for the next month (January 2015)
forecast_jan_2015 <- forecast(trend_model, h=1)
print(forecast_jan_2015)

# Plot the original time series along with the fitted trend model
autoplot(ts_sales) +
  autolayer(trend_model$fitted.values, series="Trend", color="red") +
  ggtitle("Monthly sales") +
  xlab("Time") + ylab("Sales") +
  theme_minimal()