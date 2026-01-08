
# FlexiMart Data Architecture Project

**Student Name:** Rahul Sharma
**Student ID:** bitsom_ba_25071805
**Email:** rahulshar208@gmail.com
**Date:** 2026-01-08

## Project Overview
This project implements a data architecture for FlexiMart, including an ETL pipeline for customer and sales data and NoSQL analysis for product catalogs.

## Repository Structure
├── data/                       # Input CSV files
├── part1-database-etl/         # ETL scripts and SQL queries
├── part2-nosql/                # NoSQL analysis
├── .gitignore
└── README.md

## Technologies Used
- Python 3.x, pandas, mysql-connector-python
- MySQL 8.0
- MongoDB 6.0

## Setup Instructions
### Database Setup
```bash
# Create database
mysql -u root -p -e "CREATE DATABASE fleximart;"

# Run Part 1 - ETL Pipeline
python part1-database-etl/etl_pipeline.py

Key Learnings
I learned how to clean raw CSV data using Python and normalize it into a relational database structure. I also learned about handling data quality issues like duplicates and missing values.

Challenges Faced
Handling inconsistent phone number formats in the raw data.
Mapping CSV data types to the correct SQL data types during insertion.
