# api_endpoints.R
# Defines API endpoint functions for the e-commerce dataset

# Install and load required packages
if (!requireNamespace("jsonlite", quietly = TRUE)) install.packages("jsonlite")
library(jsonlite)

# Ensure the dataset is loaded (assumes setup_dataset.R has been sourced)
if (!exists("customers") || !exists("products") || !exists("orders")) {
  stop("Please source setup_dataset.R first to load the dataset.")
}

# Endpoint 1: Total sales of the best-selling product in a city
get_best_selling_product_sales_in_city <- function(city) {
  query <- sprintf("
    SELECT p.product_name, SUM(p.price * o.quantity) AS total_sales
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id
    WHERE c.city = '%s'
    GROUP BY p.product_name
    ORDER BY total_sales DESC
    LIMIT 1", city)
  result <- sqldf(query)
  return(toJSON(result, pretty=TRUE))
}

# Endpoint 2: Bottom N cities by total sales
get_bottom_cities_by_sales <- function(num_cities) {
  query <- sprintf("
    SELECT c.city, SUM(p.price * o.quantity) AS total_sales
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id
    GROUP BY c.city
    ORDER BY total_sales ASC
    LIMIT %d", num_cities)
  result <- sqldf(query)
  return(toJSON(result, pretty=TRUE))
}

# Endpoint 3: Top N products by quantity sold in a city
get_top_products_by_quantity_in_city <- function(city, num_products) {
  query <- sprintf("
    SELECT p.product_name, SUM(o.quantity) AS total_quantity
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id
    WHERE c.city = '%s'
    GROUP BY p.product_name
    ORDER BY total_quantity DESC
    LIMIT %d", city, num_products)
  result <- sqldf(query)
  return(toJSON(result, pretty=TRUE))
}

# Endpoint 4: Number of orders in a city for a given month and year
get_orders_count_by_city_and_month <- function(city, month, year) {
  query <- sprintf("
    SELECT COUNT(*) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE c.city = '%s'
    AND strftime('%%m', o.order_date) = '%02d'
    AND strftime('%%Y', o.order_date) = '%d'", city, month, year)
  result <- sqldf(query)
  return(toJSON(result, pretty=TRUE))
}

# Endpoint 5: Average order value for a category in a city
get_avg_order_value_by_category_and_city <- function(category, city) {
  query <- sprintf("
    SELECT AVG(p.price * o.quantity) AS avg_order_value
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON o.product_id = p.product_id
    WHERE p.category = '%s' AND c.city = '%s'", category, city)
  result <- sqldf(query)
  return(toJSON(result, pretty=TRUE))
}

# Example calls to the endpoints
cat("Calling Endpoint 1: Best-selling product in Chennai\n")
response1 <- get_best_selling_product_sales_in_city("Chennai")
cat("Response:\n")
cat(response1, "\n\n")

cat("Calling Endpoint 2: Bottom 3 cities by sales\n")
response2 <- get_bottom_cities_by_sales(3)
cat("Response:\n")
cat(response2, "\n\n")

cat("Calling Endpoint 3: Top 5 products by quantity in Bangalore\n")
response3 <- get_top_products_by_quantity_in_city("Bangalore", 5)
cat("Response:\n")
cat(response3, "\n\n")

cat("Calling Endpoint 4: Number of orders in Hyderabad, March 2025\n")
response4 <- get_orders_count_by_city_and_month("Hyderabad", "03", 2025)
cat("Response:\n")
cat(response4, "\n\n")

cat("Calling Endpoint 5: Average order value for Electronics in Mumbai\n")
response5 <- get_avg_order_value_by_category_and_city("Electronics", "Mumbai")
cat("Response:\n")
cat(response5, "\n\n")

# Reformat one response into a DataFrame (Endpoint 3)
top_products_df <- fromJSON(response3)
print("Top 5 Products in Bangalore (as DataFrame):")
print(top_products_df)
