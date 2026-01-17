-- Create the Data Warehouse Database
CREATE DATABASE fleximart_dw;

-- Select the database to use
USE fleximart_dw;

-- Create Dimension Tables

-- 1. Date Dimension (Holds time data)
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY, -- Format: YYYYMMDD
    full_date DATE,
    day_of_week VARCHAR(10),
    month INT,
    month_name VARCHAR(10),
    quarter VARCHAR(2),
    year INT,
    is_weekend BOOLEAN
);

-- 2. Product Dimension (Holds item details)
CREATE TABLE dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY, -- Surrogate Key
    product_id INT, -- Original ID from source
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    current_unit_price DECIMAL(10, 2)
);

-- 3. Customer Dimension (Holds user details)
CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY, -- Surrogate Key
    customer_id INT, -- Original ID from source
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);


-- Create Fact Table (Holds the sales numbers and links)
CREATE TABLE fact_sales (
    sales_key INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Foreign Keys (Links to Dimensions)
    date_key INT,
    product_key INT,
    customer_key INT,
    
    -- Measures (The numbers we analyze)
    quantity_sold INT,
    unit_price DECIMAL(10, 2),
    discount_amount DECIMAL(10, 2),
    total_amount DECIMAL(12, 2),
    
    -- Connecting the links
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key),
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);

