USE fleximart_dw;

-- -------------------------------------------------------
-- 1. Insert 30 Dates (Jan 2024)
-- -------------------------------------------------------
INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, FALSE),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, FALSE),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, FALSE),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, FALSE),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, TRUE),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, FALSE),
(20240123, '2024-01-23', 'Tuesday', 23, 1, 'January', 'Q1', 2024, FALSE),
(20240124, '2024-01-24', 'Wednesday', 24, 1, 'January', 'Q1', 2024, FALSE),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, FALSE),
(20240126, '2024-01-26', 'Friday', 26, 1, 'January', 'Q1', 2024, FALSE),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, TRUE),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, FALSE),
(20240130, '2024-01-30', 'Tuesday', 30, 1, 'January', 'Q1', 2024, FALSE);

-- -------------------------------------------------------
-- 2. Insert 15 Products (3 Categories)
-- -------------------------------------------------------
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
-- Electronics (High Value)
('E001', 'Smart TV 55 Inch', 'Electronics', 'Televisions', 45000.00),
('E002', 'Gaming Laptop Pro', 'Electronics', 'Computers', 85000.00),
('E003', 'Wireless Noise Cancelling Headphones', 'Electronics', 'Audio', 12000.00),
('E004', 'Smartphone Flagship', 'Electronics', 'Mobiles', 60000.00),
('E005', 'Smartwatch Series 5', 'Electronics', 'Wearables', 25000.00),
-- Home & Kitchen (Mid Value)
('H001', 'Microwave Oven', 'Home', 'Kitchen Appliances', 8000.00),
('H002', 'Queen Size Bed', 'Home', 'Furniture', 35000.00),
('H003', 'Ergonomic Office Chair', 'Home', 'Furniture', 12000.00),
('H004', 'Coffee Maker', 'Home', 'Kitchen Appliances', 4500.00),
('H005', 'Vacuum Cleaner Robot', 'Home', 'Cleaning', 28000.00),
-- Clothing (Low/Mid Value)
('C001', 'Men Formal Shirt', 'Clothing', 'Men', 1500.00),
('C002', 'Women Summer Dress', 'Clothing', 'Women', 2500.00),
('C003', 'Running Shoes', 'Clothing', 'Footwear', 4000.00),
('C004', 'Leather Jacket', 'Clothing', 'Outerwear', 8000.00),
('C005', 'Cotton T-Shirt Pack', 'Clothing', 'Men', 800.00);

-- -------------------------------------------------------
-- 3. Insert 12 Customers (4 Cities)
-- -------------------------------------------------------
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST001', 'Aarav Patel', 'Mumbai', 'Maharashtra', 'Premium'),
('CUST002', 'Isha Sharma', 'Mumbai', 'Maharashtra', 'Regular'),
('CUST003', 'Rohan Gupta', 'Mumbai', 'Maharashtra', 'New'),
('CUST004', 'Priya Singh', 'Delhi', 'Delhi', 'Premium'),
('CUST005', 'Vikram Malhotra', 'Delhi', 'Delhi', 'Regular'),
('CUST006', 'Anjali Verma', 'Delhi', 'Delhi', 'New'),
('CUST007', 'Suresh Reddy', 'Bangalore', 'Karnataka', 'Regular'),
('CUST008', 'Meera Nair', 'Bangalore', 'Karnataka', 'Premium'),
('CUST009', 'Karthik Iyer', 'Bangalore', 'Karnataka', 'New'),
('CUST010', 'Neha Joshi', 'Indore', 'Madhya Pradesh', 'Regular'),
('CUST011', 'Rajesh Kumar', 'Indore', 'Madhya Pradesh', 'Regular'),
('CUST012', 'Sanya Kapoor', 'Indore', 'Madhya Pradesh', 'Premium');

-- -------------------------------------------------------
-- 4. Insert 40 Sales Transactions
-- -------------------------------------------------------
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101, 1, 1, 1, 45000.00, 2000.00, 43000.00),
(20240102, 2, 2, 1, 85000.00, 5000.00, 80000.00),
(20240103, 5, 3, 2, 25000.00, 0.00, 50000.00),
(20240104, 11, 4, 3, 1500.00, 0.00, 4500.00),
(20240105, 12, 5, 2, 2500.00, 500.00, 4500.00),
(20240106, 13, 6, 1, 4000.00, 0.00, 4000.00), -- Weekend Sale
(20240106, 3, 7, 1, 12000.00, 1000.00, 11000.00), -- Weekend Sale
(20240107, 7, 8, 1, 35000.00, 0.00, 35000.00), -- Weekend Sale
(20240107, 15, 9, 5, 800.00, 0.00, 4000.00), -- Weekend Sale
(20240108, 2, 10, 1, 85000.00, 0.00, 85000.00),
(20240109, 4, 11, 1, 60000.00, 2000.00, 58000.00),
(20240110, 6, 12, 1, 8000.00, 0.00, 8000.00),
(20240111, 8, 1, 2, 12000.00, 2400.00, 21600.00),
(20240112, 9, 2, 1, 4500.00, 0.00, 4500.00),
(20240113, 10, 3, 1, 28000.00, 1000.00, 27000.00), -- Weekend Sale
(20240113, 1, 4, 1, 45000.00, 0.00, 45000.00), -- Weekend Sale
(20240114, 14, 5, 1, 8000.00, 800.00, 7200.00), -- Weekend Sale
(20240115, 5, 6, 1, 25000.00, 0.00, 25000.00),
(20240116, 2, 7, 1, 85000.00, 4000.00, 81000.00),
(20240117, 3, 8, 2, 12000.00, 0.00, 24000.00),
(20240118, 11, 9, 4, 1500.00, 600.00, 5400.00),
(20240119, 12, 10, 1, 2500.00, 0.00, 2500.00),
(20240120, 6, 11, 1, 8000.00, 0.00, 8000.00), -- Weekend Sale
(20240120, 7, 12, 1, 35000.00, 3500.00, 31500.00), -- Weekend Sale
(20240121, 13, 1, 2, 4000.00, 0.00, 8000.00), -- Weekend Sale
(20240122, 15, 2, 10, 800.00, 800.00, 7200.00),
(20240123, 1, 3, 1, 45000.00, 0.00, 45000.00),
(20240124, 2, 4, 1, 85000.00, 8500.00, 76500.00),
(20240125, 4, 5, 1, 60000.00, 0.00, 60000.00),
(20240126, 8, 6, 4, 12000.00, 4800.00, 43200.00),
(20240127, 9, 7, 2, 4500.00, 0.00, 9000.00), -- Weekend Sale
(20240127, 10, 8, 1, 28000.00, 0.00, 28000.00), -- Weekend Sale
(20240128, 11, 9, 2, 1500.00, 0.00, 3000.00), -- Weekend Sale
(20240128, 14, 10, 1, 8000.00, 0.00, 8000.00), -- Weekend Sale
(20240129, 3, 11, 1, 12000.00, 1200.00, 10800.00),
(20240130, 5, 12, 1, 25000.00, 0.00, 25000.00),
(20240130, 6, 1, 1, 8000.00, 0.00, 8000.00),
(20240130, 12, 2, 3, 2500.00, 0.00, 7500.00),
(20240130, 13, 3, 1, 4000.00, 400.00, 3600.00),
(20240130, 15, 4, 5, 800.00, 0.00, 4000.00);