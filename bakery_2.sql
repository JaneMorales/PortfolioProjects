-- Create the bakery database
CREATE DATABASE IF NOT EXISTS bakery2;
USE bakery2;

-- Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Insert sample data into the products table
INSERT INTO products (product_name, description, price, stock_quantity)
VALUES
('Chocolate Cake', 'Rich and moist chocolate cake', 15.00, 50),
('Vanilla Cupcake', 'Soft vanilla cupcake with frosting', 2.50, 100),
('Croissant', 'Flaky buttery croissant', 3.00, 80),
('Apple Pie', 'Homemade apple pie with cinnamon', 12.00, 30),
('Donut', 'Glazed donut', 1.75, 120),
('Banana Bread', 'Freshly baked banana bread', 5.00, 60);

-- Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255) NOT NULL
);

-- Insert sample data into the customers table
INSERT INTO customers (first_name, last_name, email, phone, address)
VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Maple St, Cityville'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak Rd, Townsville'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-8765', '789 Pine Ave, Villagecity'),
('Bob', 'Brown', 'bob.brown@example.com', '555-4321', '101 Birch Blvd, Suburbia');

-- Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data into the orders table
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
(1, '2023-12-01', 30.00),
(2, '2023-12-05', 25.50),
(3, '2023-12-10', 12.50),
(4, '2023-12-15', 50.00);

-- Create the order_details table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into the order_details table
INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 15.00),  -- John ordered 2 Chocolate Cakes
(1, 2, 5, 2.50),  -- John ordered 5 Vanilla Cupcakes
(2, 3, 6, 3.00),  -- Jane ordered 6 Croissants
(2, 4, 2, 12.00),  -- Jane ordered 2 Apple Pies
(3, 5, 3, 1.75),  -- Alice ordered 3 Donuts
(4, 6, 4, 5.00);  -- Bob ordered 4 Banana Breads

----------------------------------------------------------------------------------------------------------------------------------
-- USED CHATGPT for the table 
-- products table: Stores information about the products offered by the bakery, such as the product name, description, price, and the quantity in stock.
-- customers table: Holds details about customers, including their name, email, phone number, and address.
-- orders table: Keeps track of customer orders, including the customer who placed the order, the order date, and the total amount of the order.
-- order_details table: Tracks which products were included in each order, linking to both the orders and products tables.

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Select All Products
-- Write a query to retrieve all the columns from the products table.

SELECT *
FROM products;

-- 2. Find Customers Who Ordered Certain Products
-- Write a query to find all customers who have ordered "Chocolate Cake". Display the customer’s first name, last name, and email.

SELECT DISTINCT c.first_name, c.last_name, c.email
FROM customers c
JOIN orders o 
	ON c.customer_id = o.customer_id
JOIN order_details od 
	ON od.order_id = o.order_id
JOIN products p
	ON od.product_id = p.product_id
WHERE p.product_name = 'Chocolate Cake';
    
-- 3. Total Sales Per Product
-- Write a query to calculate the total sales (total revenue) for each product. You should return the product name and the total revenue generated from it.

SELECT p.product_name, SUM(od.quantity * od.price) AS total_sales
FROM products p
JOIN order_details od
	ON p.product_id = od.product_id
GROUP BY p.product_name;

-- 4. Find Orders for a Specific Date
-- Write a query to find all orders placed on '2023-12-01'. Return the order ID, customer name, and the total amount for the order.

SELECT o.order_id, c.first_name, c.last_name, o.total_amount
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
WHERE o.order_date = '2023-12-01';

-- 5. Order Details for a Specific Customer
-- Write a query to find the details of all the orders placed by 'John Doe'. Display the order ID, product name, quantity ordered, and the price for each product.

SELECT od.order_id, p.product_name, od.quantity, od.price
FROM customers c
JOIN orders o 
	ON c.customer_id = o.customer_id
JOIN order_details od 
	ON od.order_id = o.order_id
JOIN products p
	ON od.product_id = p.product_id
WHERE c.first_name = 'John' AND c.last_name = 'Doe';

-- 6. Find Products Low on Stock
-- Write a query to find all products with a stock quantity of less than 50. Display the product name and its stock quantity.

SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity < 50;

-- 7. Customer’s Total Spending
-- Write a query to calculate the total amount spent by each customer across all their orders. Display the customer’s full name and the total amount spent.

SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
GROUP BY c.customer_id;

-- 8. Find the Most Popular Product
-- Write a query to find the most popular product based on the total quantity ordered. Return the product name and the total quantity ordered.

SELECT p.product_name, SUM(od.quantity) AS total_quantity_ordered
FROM order_details od
JOIN products p
	ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_ordered DESC
LIMIT 1;

-- 9. Update Product Price
-- Write a query to increase the price of "Donut" by 20%. Make sure to update the price column in the products table.

UPDATE products
SET price = ROUND(price * 1.20, 2)
WHERE product_name = 'Donut';

-- 10. Delete an Order
-- Write a query to delete the order with order ID 3 from the orders table. Make sure to remove the corresponding data from the order_details table as well (use CASCADE or delete separately if necessary).

-- First, delete the order details related to the order
DELETE FROM order_details WHERE order_id = 3;

-- Then, delete the order from the orders table
DELETE FROM orders WHERE order_id = 3;

-- 11. Find Orders with Multiple Products
-- Write a query to find all orders that contain more than one product. Display the order ID and the number of products in each order.

SELECT order_id, COUNT(*) AS num_of_products
FROM order_details 
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 12. Display Top 3 Most Expensive Orders
-- Write a query to display the top 3 orders with the highest total amounts. Return the order ID and total amount.

SELECT order_id, total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 3;

-- 13. Find Customers Who Haven't Ordered Anything
-- Write a query to find customers who haven't placed any orders. Display their first name, last name, and email.

SELECT c.first_name, c.last_name, c.email
FROM customers c
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- or --

SELECT first_name, last_name, email
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
----------------------------------------------------------------------------------------------------------------------------------------------
-- FOR QUESTION 13:
-- This query works as follows: The subquery checks if any orders exist for each customer by comparing customer_id in the customers table to customer_id in the orders table. NOT EXISTS ensures that only customers who have no matching orders (i.e., customers who haven't ordered anything) are returned.

-- When using EXISTS or NOT EXISTS, the database engine evaluates whether the subquery returns any rows or no rows. The actual data returned by the subquery doesn't matter—only whether or not it returns something.
-- The 1 is commonly used in subqueries within an EXISTS clause because:
-- It's a constant value, so it doesn't interfere with the query's logic.
-- It avoids the need to select any specific columns.
-- It keeps the subquery as efficient as possible because it doesn't need to return any actual data—just the presence of rows.

-- Subquery: The subquery checks whether there are any rows in the orders table that match the current customer. The condition WHERE o.customer_id = c.customer_id links the orders table to the customers table.
-- EXISTS / NOT EXISTS: If the subquery returns any rows, the EXISTS condition is TRUE and the customer is excluded from the results (because of NOT EXISTS). If the subquery returns no rows (meaning the customer has no orders), NOT EXISTS becomes TRUE, and the customer is included in the final result.
-- SELECT 1: The SELECT 1 in the subquery is just a placeholder. It doesn't affect the result of the EXISTS clause because EXISTS is only concerned with whether rows are returned, not with the actual data in those rows. You could technically use SELECT *, SELECT NULL, or any other value in place of 1—they all work the same way.
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 14. Find Products Ordered by a Specific Customer
-- Write a query to find all products ordered by 'Jane Smith'. Display the product name, quantity ordered, and the price.

SELECT p.product_name, od.quantity, od.price
FROM products p
JOIN order_details od
	ON p.product_id = od.product_id
JOIN orders o
	ON od.order_id = o.order_id
JOIN customers c
	ON o.customer_id = c.customer_id
WHERE c.first_name = 'Jane' AND c.last_name = 'Smith';

-- 15. Find the Most Expensive Order for Each Customer
-- Write a query to find the most expensive order placed by each customer. Display the customer’s name and the order ID with the highest total amount.

SELECT c.first_name, c.last_name, o.order_id, o.total_amount
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
WHERE o.total_amount = (
	SELECT MAX(total_amount)
    FROM orders
    WHERE customer_id = c.customer_id
);

-- Explanation: JOIN customers c ON c.customer_id = o.customer_id: This joins the customers table with the orders table, so we can work with the customer's name and their orders. Subquery (SELECT MAX(total_amount) FROM orders WHERE customer_id = c.customer_id): The subquery finds the maximum total_amount for each customer by grouping them using customer_id. This returns the highest total_amount for each customer. WHERE Clause: The WHERE clause in the main query compares the total_amount of each order with the maximum total amount for that specific customer (returned by the subquery). This ensures that only the most expensive order for each customer is selected.
