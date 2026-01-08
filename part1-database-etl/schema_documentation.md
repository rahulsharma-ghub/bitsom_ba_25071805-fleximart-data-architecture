Assignment 2

Task 1.2: Database Schema Documentation (5 marks)


Schema Documentation — FlexiMart Database

ENTITY: customers
Purpose - Stores customer master information.

Attributes
-customer_id (INT, Primary Key, AUTO_INCREMENT)
Unique identifier for each customer.

-first_name (VARCHAR(50), NOT NULL)
Customer’s first name.

-last_name (VARCHAR(50), NOT NULL)
Customer’s last name.

-email (VARCHAR(100), UNIQUE, NOT NULL)
Customer’s email address. Used as a unique identifier during ETL.

-phone (VARCHAR(20))
Customer’s phone number, standardized to +91-XXXXXXXXXX.

-city (VARCHAR(50))
City of residence, standardized to title case.

-registration_date (DATE)
Date when the customer registered, stored in YYYY-MM-DD format.

Relationships
One customer can place many orders
Relationship: customers (1) → orders (M)
Linked via orders.customer_id


ENTITY: products
Purpose - Stores product master data.

Attributes
-product_id (INT, Primary Key, AUTO_INCREMENT)
Unique identifier for each product.

-product_name (VARCHAR(100), NOT NULL)
Name of the product (extra spaces removed).

-category (VARCHAR(50), NOT NULL)
Product category, standardized (Electronics, Fashion, Groceries).

-price (DECIMAL(10,2), NOT NULL)
Unit price of the product.

-stock_quantity (INT, DEFAULT 0)
Available stock quantity.

Relationships
One product can appear in many order items
Relationship: products (1) → order_items (M)
Linked via order_items.product_id

ENTITY: orders
Purpose - Stores order-level information derived from sales transactions.

Attributes

-order_id (INT, Primary Key, AUTO_INCREMENT)
Unique identifier for each order.

-customer_id (INT, NOT NULL, Foreign Key)
References customers.customer_id.

-order_date (DATE, NOT NULL)
Date when the order was placed.

-total_amount (DECIMAL(10,2), NOT NULL)
Total order value calculated from order items.

-status (VARCHAR(20), DEFAULT 'Pending')
Order status (e.g., Completed, Pending).

Relationships
Each order belongs to one customer
Relationship: customers (1) → orders (M)
One order can contain many order items
Relationship: orders (1) → order_items (M)



ENTITY: order_items
Purpose - Stores individual product line items for each order.

Attributes
-order_item_id (INT, Primary Key, AUTO_INCREMENT)
Unique identifier for each order item.

-order_id (INT, NOT NULL, Foreign Key)
References orders.order_id.

-product_id (INT, NOT NULL, Foreign Key)
References products.product_id.

-quantity (INT, NOT NULL)
Quantity of the product ordered.

-unit_price (DECIMAL(10,2), NOT NULL)
Price per unit at the time of purchase.

-subtotal (DECIMAL(10,2), NOT NULL)
Calculated as quantity × unit_price.

Relationships
Each order item belongs to one order
Relationship: orders (1) → order_items (M)
Each order item refers to one product
Relationship: products (1) → order_items (M)



Relationship Summary (Textual ER Description)
A customer can place many orders, but an order belongs to only one customer.
An order can contain many order items, but an order item belongs to only one order.
A product can appear in many order items, but an order item refers to only one product.


Note -

All primary keys use AUTO_INCREMENT surrogate keys.
Foreign key constraints enforce referential integrity.
Invalid or incomplete records are filtered out during the ETL process before loading.




Normalization Explanation

Why This Design Is in Third Normal Form (3NF)

The FlexiMart database schema is designed according to Third Normal Form (3NF) principles to ensure data integrity, eliminate redundancy, and prevent data anomalies.

First Normal Form (1NF) is satisfied because all tables contain atomic values only. Each column holds a single value, there are no repeating groups, and each record can be uniquely identified using a primary key (e.g., customer_id, product_id, order_id, order_item_id).

Second Normal Form (2NF) is achieved because all non-key attributes in each table are fully functionally dependent on the entire primary key. Since all tables use single-column surrogate keys (AUTO_INCREMENT primary keys), there are no partial dependencies. For example, in the order_items table, attributes such as quantity, unit_price, and subtotal depend entirely on order_item_id and not on a subset of attributes.

Third Normal Form (3NF) is satisfied because there are no transitive dependencies. Non-key attributes do not depend on other non-key attributes. For instance, customer-related information (name, email, city) is stored only in the customers table and not repeated in the orders table. Similarly, product details (name, category, price) are stored only in the products table and referenced via foreign keys in order_items.

By separating customers, products, orders, and order items into distinct tables and linking them using foreign keys, the schema ensures that each fact is stored exactly once. This results in a normalized, maintainable, and scalable design that conforms fully to Third Normal Form.


Normalization Explanation (3NF Justification)

The database design is in Third Normal Form (3NF) because it satisfies all normalization rules up to 3NF. Each table contains atomic attributes with a unique primary key, satisfying First Normal Form (1NF). Since all tables use single-column primary keys, there are no partial dependencies, which satisfies Second Normal Form (2NF). The design also has no transitive dependencies, as non-key attributes depend only on the primary key and not on other non-key attributes. For example, customer details are stored only in the customers table and not repeated in orders, and product details are stored only in the products table and referenced through foreign keys. This ensures minimal redundancy and confirms that the schema is in Third Normal Form (3NF).


How the Design Avoids Update, Insert, and Delete Anomalies

Update Anomalies
The schema avoids update anomalies by storing each piece of information only once. For example, customer details are stored exclusively in the customers table. Updating a customer’s email or phone number requires changing only one record, rather than multiple rows across orders.

Insert Anomalies
Insert anomalies are avoided because entities can be added independently. New customers and products can be inserted without requiring an order. Similarly, an order can be created without duplicating customer or product information, thanks to foreign key references.

Delete Anomalies
Delete anomalies are prevented by separating transactional data from master data. Deleting an order does not remove customer or product information. Customer and product records remain intact even if all associated orders are deleted, preserving historical and master data integrity.