USE fleximart_dw;

-- REPORT 1: Total Revenue by Product Category
-- This tells FlexiMart which category is making the most money.
SELECT 
    p.category, 
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category;

-- REPORT 2: Customer Purchase History
-- This shows who bought what and when (Human readable!).
SELECT 
    c.customer_name, 
    p.product_name,
    f.quantity_sold,
    f.total_amount, 
    d.full_date
FROM fact_sales f
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.date_key = d.date_key;