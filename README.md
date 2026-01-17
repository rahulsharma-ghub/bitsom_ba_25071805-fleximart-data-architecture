
# FlexiMart Data Architecture Project

**Student Name:** Rahul Sharma
**Student ID:** bitsom_ba_25071805
**Email:** rahulshar208@gmail.com
**Date:** 2026-01-08

## Project Overview
This project implements a data architecture for FlexiMart, including an ETL pipeline for customer and sales data and NoSQL analysis for product catalogs.

## Project Overview
This project implements a comprehensive data architecture for FlexiMart. It includes an ETL pipeline for relational data, NoSQL analysis for product catalogs, and a Data Warehouse for business analytics.

## Repository Structure
```text
├── data/                       # Input CSV files
├── part1-database-etl/         # ETL scripts and SQL queries
├── part2-nosql/                # MongoDB operations and analysis
│   ├── mongodb_operations.js
│   ├── products_catalog
│   └── nosql_analysis.md
├── part3-datawarehouse/        # Data Warehouse design and SQL
│   ├── warehouse_schema.sql
│   ├── warehouse_data.sql
│   ├── analytics_queries.sql
│   ├── star_schema_design.md
│   ├── insert_data.sql
│   └── schema.sql
├── .gitignore
└── README.md

Technologies Used
Python 3.x, pandas
MySQL 8.0
MongoDB 6.0

Setup Instructions
1. Database Setup & ETL
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

# Run ETL Pipeline
python part1-database-etl/etl_pipeline.py

2. MongoDB Setup
# Import NoSQL data
mongosh < part2-nosql/mongodb_operations.js

3. Data Warehouse Setup
# Build Warehouse Schema and Analytics
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

Key Learnings
Learned how to design a Star Schema for data warehousing and implement complex SQL analytics. I also gained experience integrating Python ETL scripts with both SQL and NoSQL databases.

Challenges Faced
Designing the dimension tables to correctly map to the fact table in the data warehouse.
Writing MongoDB queries to handle unstructured product data efficiently.
