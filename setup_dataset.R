# setup_dataset.R
# Creates the e-commerce dataset for the demo

# Install and load sqldf if not already installed
if (!requireNamespace("sqldf", quietly = TRUE)) install.packages("sqldf")
library(sqldf)

# India's top 10 cities
cities <- c("Delhi", "Mumbai", "Bangalore", "Hyderabad", "Ahmedabad", "Chennai", 
            "Kolkata", "Surat", "Pune", "Jaipur")

# Customers table (300 rows)
customers <- data.frame(
  customer_id = 1:300,
  name = paste("Customer", 1:300),
  email = paste("customer", 1:300, "@startup.com", sep=""),
  city = sample(cities, 300, replace=TRUE)
)

# Products table (100 rows)
products <- data.frame(
  product_id = 1:100,
  product_name = paste("Product", 1:100),
  category = sample(c("Electronics", "Fashion", "Books", "Home", "Toys"), 100, replace=TRUE),
  price = round(runif(100, 100, 1500), 2)
)

# Orders table (1500 rows)
set.seed(123)
orders <- data.frame(
  order_id = 1:1500,
  customer_id = sample(1:300, 1500, replace=TRUE),
  product_id = sample(1:100, 1500, replace=TRUE),
  quantity = sample(1:10, 1500, replace=TRUE),
  order_date = as.Date("2025-01-01") + sample(0:120, 1500, replace=TRUE)
)

# Quick peek at the tables
print("First 2 rows of customers:")
head(customers, 2)
print("First 2 rows of products:")
head(products, 2)
print("First 2 rows of orders:")
head(orders, 2)
