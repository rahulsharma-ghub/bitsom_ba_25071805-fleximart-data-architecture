Part 2: NoSQL Database Analysis (20 Marks)

Task 2.1: NoSQL Justification Report

Section A: Limitations of RDBMS

Explain why the current relational database would struggle with:

1. Products having different attributes (e.g., laptops have RAM/processor, shoes have size/color)
Answer -
The current relational database design struggles when products have different attributes because relational tables require a fixed schema. All rows in a table must contain the same set of columns, which makes it difficult to model products with varying characteristics, such as laptops having RAM and processor details while shoes have size and color. To accommodate this diversity, the database would either need many nullable columns or multiple specialized tables, both of which increase complexity and reduce maintainability. This results in sparse tables with excessive NULL values and complicated queries, making the system less efficient and harder to scale as new product types are added.


2. Frequent schema changes when adding new product types
Answer-
Relational databases are not well suited for frequent schema changes because modifying a table structure requires explicit schema alteration operations. Each time a new product type with different attributes is introduced, the database schema must be updated, which can be time-consuming and risky, especially in production environments. Such changes may cause application downtime, impact existing queries, and require extensive testing. As the product catalog evolves rapidly, the rigidity of the relational schema reduces flexibility and slows down development, making it difficult to adapt quickly to changing business requirements.


3. Storing customer reviews as nested data
Answer-
Storing customer reviews in a relational database typically requires separate tables and relationships, which increases complexity when retrieving product and review data together. This approach relies heavily on joins, which can negatively impact performance for read-heavy operations and make queries harder to write and maintain. Additionally, representing hierarchical or nested data structures, such as reviews belonging to a specific product, is not natural in a relational model. This limitation makes relational databases less efficient for handling nested and semi-structured data compared to document-based databases.


Section B: NoSQL Benefits

Explain how MongoDB solves these problems using:

Flexible schema (document structure)
Embedded documents (reviews within products)
Horizontal scalability

Answer -

1. Flexible Schema (Document Structure)

MongoDB uses a flexible, schema-less document model that allows each document in a collection to have a different structure. This solves the problem of handling diverse products because each product can store only the attributes relevant to it without enforcing a fixed set of columns. New product types can be introduced without modifying existing documents or database structure, eliminating the need for costly schema alterations. This flexibility makes MongoDB highly suitable for environments where product attributes vary widely and evolve frequently, enabling faster development and easier maintenance compared to rigid relational schemas.

2. Embedded Documents (Reviews Within Products)

MongoDB supports embedded documents, allowing related data such as customer reviews to be stored directly within the product document. This approach naturally represents one-to-many relationships and avoids the need for complex joins across multiple tables. As a result, product and review information can be retrieved together in a single query, improving read performance and simplifying data access. Embedded documents also make the data model more intuitive and aligned with real-world business objects, which is particularly beneficial for read-heavy applications like product catalogs.

3. Horizontal Scalability

MongoDB is designed for horizontal scalability through sharding, which allows data to be distributed across multiple servers. As the volume of products, reviews, and user interactions grows, MongoDB can scale out by adding more nodes rather than upgrading a single server. This ensures high availability, better performance, and fault tolerance under heavy workloads. In contrast, traditional relational databases often rely on vertical scaling, which has hardware and cost limitations. MongoDB’s horizontal scalability makes it well suited for rapidly growing and high-traffic applications like FlexiMart.



Section C: Trade-offs

What are two disadvantages of using MongoDB instead of MySQL for this product catalog?

1. Lack of Strong Schema Enforcement and Data Consistency

MongoDB’s flexible schema, while beneficial for handling diverse product attributes, can also be a disadvantage because it does not strictly enforce a predefined structure. Without strong schema constraints, there is a higher risk of inconsistent or incomplete data being stored, such as missing required fields or varying data types for the same attribute. In contrast, MySQL enforces data integrity through strict schemas, constraints, and data types, which helps maintain consistency and reliability. Managing and validating data quality in MongoDB often requires additional application-level logic, increasing development complexity.

2. Limited Support for Complex Transactions and Joins

MongoDB is not as well suited as MySQL for handling complex transactional operations involving multiple entities. While modern versions of MongoDB support transactions, they are generally less mature and less efficient compared to relational databases for multi-table operations. Additionally, MongoDB does not naturally support complex joins, making certain analytical queries more difficult or less performant. MySQL, with its robust ACID-compliant transactions and powerful join capabilities, is better suited for scenarios requiring strong consistency and complex relational queries.


