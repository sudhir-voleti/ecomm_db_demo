# ecomm_db_demo
# E-commerce Database Demo
Overview
This repository contains a toy demo for a 1-hour class on database essentials, focusing on SQL and API-like queries using sqldf in R. It’s designed for young startup co-founders learning to Design-Build-Deploy (DBD) apps with vibe-coding assistance. The demo uses a synthetic e-commerce dataset with tables for customers, products, and orders, and simulates API endpoints to query the data.

Live Documentation
View the API documentation here: https://sudhir-voleti.github.io/ecomm_db_demo/.

For AI prompts, use the raw link: https://raw.githubusercontent.com/sudhir-voleti/ecomm_db_demo/main/index.html.

Files
index.html: The API documentation, hosted on GitHub Pages.
setup_dataset.R: Creates the e-commerce dataset (customers, products, orders).
api_endpoints.R: Defines API endpoint functions to query the dataset.
Getting Started
Set Up R Environment:
Use RStudio or Colab with an R kernel.
Ensure sqldf and jsonlite are installed (install.packages(c("sqldf", "jsonlite"))).
Load the Dataset:
R

Copy
source("https://raw.githubusercontent.com/sudhir-voleti/ecomm_db_demo/main/setup_dataset.R")
Run API Endpoints:
R

Copy
source("https://raw.githubusercontent.com/sudhir-voleti/ecomm_db_demo/main/api_endpoints.R")
This will define the endpoint functions and run example queries.
Explore with AI:
Use the API documentation raw link to prompt an AI for SQL queries. Example:
“I have an API with documentation at [https://raw.githubusercontent.com/sudhir-voleti/ecomm_db_demo/main/index.html]. Using sqldf in R, write an SQL query to find the top 3 best-selling products (by total quantity) in Hyderabad.”
License
This project is for educational purposes and uses synthetic data. Feel free to adapt it for your own learning!
