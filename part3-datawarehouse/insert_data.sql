USE fleximart_dw;

-- 1. Insert Sample Products
INSERT INTO dim_product (product_id, product_name, category, brand, current_unit_price) VALUES
(101, 'Gaming Laptop', 'Electronics', 'Alienware', 150000.00),
(102, 'Wireless Mouse', 'Accessories', 'Logitech', 1500.00);

-- 2. Insert Sample Customers
INSERT INTO dim_customer (customer_id, customer_name, email, city, state, country) VALUES
(1, 'Rahul Sharma', 'rahul@example.com', 'Indore', 'MP', 'India'),
(2, 'Priya Singh', 'priya@example.com', 'Mumbai', 'MH', 'India');

-- 3. Insert Sample Dates
INSERT INTO dim_date (date_key, full_date, day_of_week, month, month_name, quarter, year, is_weekend) VALUES
(20240115, '2024-01-15', 'Monday', 1, 'January', 'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday', 1, 'January', 'Q1', 2024, FALSE);

-- 4. Insert Sales Transactions
-- Notice we use the ID numbers (1, 2) generated above, not the names.
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240115, 1, 1, 1, 150000.00, 5000.00, 145000.00), -- Rahul bought 1 Laptop
(20240116, 2, 2, 2, 1500.00, 0.00, 3000.00);      -- Priya bought 2 Mice