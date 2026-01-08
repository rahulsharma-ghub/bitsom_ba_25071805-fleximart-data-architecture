import mysql.connector
import csv
from datetime import datetime

# Function to read a CSV file and convert it into a list of dictionaries
def read_csv(file_name):
    data = []
    # Open file with utf-8 encoding to handle special characters
    with open(file_name, mode='r', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            data.append(row)
    return data


# Filters out customers with duplicate emails
def remove_duplicate_customers(customers):
    unique = {}
    for customer in customers:
        # Normalize email to lowercase and remove spaces for accurate comparison
        email = customer['email'].strip().lower()
        # Only add to the dictionary if we haven't seen this email before
        if email not in unique:
            unique[email] = customer
    return list(unique.values())


# Removes customer records where the email field is empty
def drop_customers_missing_email(customers):
    cleaned = []
    for customer in customers:
        if customer['email'].strip() != "":
            cleaned.append(customer)
    return cleaned


# Formats phone numbers into a standard "+91-XXXXXXXXXX" format
def standardize_phone(phone):
    if phone is None:
        return None

    # Remove existing spaces and dashes
    phone = phone.strip().replace(" ", "").replace("-", "")

    # Handle different prefixes to extract the raw 10-digit number
    if phone.startswith("+91"):
        number = phone[3:]
    elif phone.startswith("0"):
        number = phone[1:]
    else:
        number = phone

    # Validate length and digit-only content before returning formatted string
    if len(number) == 10 and number.isdigit():
        return "+91-" + number

    return None


# Wrapper function to apply phone standardization to the entire list
def apply_phone_standardization(customers):
    for customer in customers:
        customer['phone'] = standardize_phone(customer['phone'])
    return customers


# Converts city names to Title Case (e.g., "new york" -> "New York")
def standardize_city(customers):
    for customer in customers:
        customer['city'] = customer['city'].strip().title()
    return customers


# Parses various date formats and converts them to standard SQL format (YYYY-MM-DD)
def standardize_date(date_str):
    if date_str is None or date_str.strip() == "":
        return None

    # Try matching the input string against a list of known date formats
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%m-%d-%Y"):
        try:
            return datetime.strptime(date_str.strip(), fmt).strftime("%Y-%m-%d")
        except ValueError:
            continue # Try the next format if this one fails

    return None


# Wrapper function to apply date standardization to customer registration dates
def apply_date_standardization(customers):
    for customer in customers:
        customer['registration_date'] = standardize_date(customer['registration_date'])
    return customers


# Removes duplicate products based on product name
def remove_duplicate_products(products):
    unique = {}
    for product in products:
        name = product['product_name'].strip().lower()
        if name not in unique:
            unique[name] = product
    return list(unique.values())


# Drops products that do not have a price listed
def drop_products_missing_price(products):
    cleaned = []
    for product in products:
        if product['price'].strip() != "":
            cleaned.append(product)
    return cleaned


# Sets stock quantity to "0" if the field is empty
def fill_missing_stock(products):
    for product in products:
        if product['stock_quantity'].strip() == "":
            product['stock_quantity'] = "0"
    return products


# Normalizes category names (fixes capitalization issues)
def standardize_category(products):
    for product in products:
        category = product['category'].strip().lower()
        if category == "electronics":
            product['category'] = "Electronics"
        elif category == "fashion":
            product['category'] = "Fashion"
        elif category == "groceries":
            product['category'] = "Groceries"
    return products


# Removes whitespace from product names
def trim_product_names(products):
    for product in products:
        product['product_name'] = product['product_name'].strip()
    return products


# Deduplicates sales records based on transaction_id
def remove_duplicate_sales(sales):
    unique = {}
    for row in sales:
        txn_id = row['transaction_id'].strip()
        if txn_id not in unique:
            unique[txn_id] = row
    return list(unique.values())


# Ensures sales records link to both a customer and a product
def drop_sales_missing_ids(sales):
    cleaned = []
    for row in sales:
        if row['customer_id'].strip() != "" and row['product_id'].strip() != "":
            cleaned.append(row)
    return cleaned


# Standardizes transaction dates
def apply_sales_date_standardization(sales):
    for row in sales:
        row['transaction_date'] = standardize_date(row['transaction_date'])
    return sales


# Aggregates individual sales rows into unique Order objects
# This handles cases where one transaction ID has multiple items
def create_orders(sales):
    orders = {}

    for row in sales:
        txn_id = row['transaction_id']
        customer_id = row['customer_id']
        order_date = row['transaction_date']
        status = row['status']

        # Calculate line item amount
        quantity = int(row['quantity'])
        unit_price = float(row['unit_price'])
        amount = quantity * unit_price

        # If order exists, add to total amount; otherwise create new order entry
        if txn_id not in orders:
            orders[txn_id] = {
                'transaction_id': txn_id,
                'customer_id': customer_id,
                'order_date': order_date,
                'status': status,
                'total_amount': amount
            }
        else:
            orders[txn_id]['total_amount'] += amount

    return list(orders.values())


# Extracts individual line items from the sales data for the order_items table
def create_order_items(sales):
    order_items = []

    for row in sales:
        quantity = int(row['quantity'])
        unit_price = float(row['unit_price'])

        order_items.append({
            'transaction_id': row['transaction_id'],
            'product_id': row['product_id'],
            'quantity': quantity,
            'unit_price': unit_price,
            'subtotal': quantity * unit_price
        })

    return order_items


# --- PROCESSING DATA ---
# Reading and cleaning Customers
customers = read_csv("customers_raw.csv")
customers = remove_duplicate_customers(customers)
customers = drop_customers_missing_email(customers)
customers = apply_phone_standardization(customers)
customers = standardize_city(customers)
customers = apply_date_standardization(customers)
print(customers[0])


# Reading and cleaning Products
products = read_csv("products_raw.csv")
products = remove_duplicate_products(products)
products = drop_products_missing_price(products)
products = fill_missing_stock(products)
products = standardize_category(products)
products = trim_product_names(products)
print(products[0])


# Reading and cleaning Sales (Orders + Items)
sales = read_csv("sales_raw.csv")
sales = remove_duplicate_sales(sales)
sales = drop_sales_missing_ids(sales)
sales = apply_sales_date_standardization(sales)
orders = create_orders(sales)
order_items = create_order_items(sales)
print(orders[0])
print(order_items[0])


# Function to insert a single customer (Optional/Helper)
def insert_one_customer(connection, customer):
    cursor = connection.cursor()

    sql = """
        INSERT INTO customers
        (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    values = (
        customer['first_name'],
        customer['last_name'],
        customer['email'],
        customer['phone'],
        customer['city'],
        customer['registration_date']
    )

    cursor.execute(sql, values)
    connection.commit()

    cursor.close()

# Batch inserts all customers into the database
def insert_all_customers(connection, customers):
    cursor = connection.cursor()

    sql = """
        INSERT INTO customers
        (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
    """

    for customer in customers:
        values = (
            customer['first_name'],
            customer['last_name'],
            customer['email'],
            customer['phone'],
            customer['city'],
            customer['registration_date']
        )
        cursor.execute(sql, values)

    connection.commit()
    cursor.close()


# Batch inserts all products into the database
def insert_all_products(connection, products):
    cursor = connection.cursor()

    sql = """
        INSERT INTO products
        (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
    """

    for product in products:
        values = (
            product['product_name'],
            product['category'],
            product['price'],
            product['stock_quantity']
        )
        cursor.execute(sql, values)

    connection.commit()
    cursor.close()

# Retrieves a mapping of Email -> DB Customer ID for Foreign Key linking
def get_customer_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT customer_id, email FROM customers")

    mapping = {}
    for customer_id, email in cursor.fetchall():
        mapping[email] = customer_id

    cursor.close()
    return mapping


# Inserts orders, mapping CSV data to valid Database Foreign Keys
def insert_all_orders(connection, orders, customer_id_map, customers):
    cursor = connection.cursor()

    sql = """
        INSERT INTO orders
        (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
    """

    # Helper to look up emails by the CSV's raw ID
    email_lookup = {c['customer_id']: c['email'] for c in customers}

    skipped = 0

    for order in orders:
        csv_customer_id = order['customer_id']

        # Skip insertion if the customer was removed during cleaning
        if csv_customer_id not in email_lookup:
            skipped += 1
            continue

        # Skip if order_date is missing
        if order['order_date'] is None:
            skipped += 1
            continue

        # Find the real database ID for this customer
        email = email_lookup[csv_customer_id]
        mysql_customer_id = customer_id_map[email]

        values = (
            mysql_customer_id,
            order['order_date'],
            order['total_amount'],
            order['status']
        )

        cursor.execute(sql, values)

    connection.commit()
    cursor.close()

    print(f"Skipped {skipped} orders due to missing customer or date")

# Helper to fetch Order IDs generated by the database
def get_order_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT order_id, customer_id, order_date, total_amount FROM orders")

    # We map in insertion order, so we track order_id sequentially
    order_ids = cursor.fetchall()
    cursor.close()

    return [row[0] for row in order_ids]

# Helper to map Product Names to their Database IDs
def get_product_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT product_id, product_name FROM products")

    mapping = {}
    for product_id, product_name in cursor.fetchall():
        mapping[product_name] = product_id

    cursor.close()
    return mapping


# Inserts order items, linking them to the correct Order ID and Product ID
def insert_all_order_items(connection, orders, order_items, products):
    cursor = connection.cursor()

    sql = """
        INSERT INTO order_items
        (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (%s, %s, %s, %s, %s)
    """

    product_lookup = {p['product_id']: p['product_name'] for p in products}
    product_id_map = get_product_id_mapping(connection)

    order_index = 0

    for item in order_items:
        if order_index >= len(orders):
            break

        csv_product_id = item['product_id']
        product_name = product_lookup.get(csv_product_id)

        if product_name not in product_id_map:
            continue

        # Using logic to link item to order (assuming sequential ID generation)
        values = (
            order_index + 1,  # order_id (AUTO_INCREMENT sequence)
            product_id_map[product_name],
            item['quantity'],
            item['unit_price'],
            item['subtotal']
        )

        cursor.execute(sql, values)

    connection.commit()
    cursor.close()


# --- DATABASE CONNECTION & EXECUTION ---
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1125",
    database="fleximart"
)

print("MySQL connection successful")

# 1. Insert Customers
insert_all_customers(connection, customers)
print("All customers inserted")

# 2. Insert Products
insert_all_products(connection, products)
print("All products inserted")

# 3. Get ID Map and Insert Orders
customer_id_map = get_customer_id_mapping(connection)
insert_all_orders(connection, orders, customer_id_map, customers)

# 4. Insert Order Items
insert_all_order_items(connection, orders, order_items, products)
print("All order items inserted")


connection.close()