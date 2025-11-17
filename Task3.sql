-- ===========================================
-- TASK 3 : SQL DATABASE (E-COMMERCE Dataset)
-- ===========================================

-- -------------------------
-- 1. CREATE TABLES
-- -------------------------

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    city TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_date TEXT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

-- -------------------------
-- 2. INSERT DATA
-- -------------------------

INSERT INTO customers VALUES
(1, 'Sneha', 'Delhi'),
(2, 'Siya', 'Mumbai'),
(3, 'Aarav', 'Delhi'),
(4, 'Riya', 'Pune');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Headphones', 'Electronics', 2500),
(103, 'Shoes', 'Fashion', 1800),
(104, 'Watch', 'Fashion', 3000);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2024-05-01'),
(1002, 2, 102, 2, '2024-05-03'),
(1003, 3, 103, 1, '2024-05-05'),
(1004, 1, 104, 1, '2024-05-10'),
(1005, 4, 101, 1, '2024-05-12'),
(1006, 2, 103, 2, '2024-05-15');

-- -------------------------
-- 3. INDEXES 
-- -------------------------

CREATE INDEX idx_customer_city ON customers(city);
CREATE INDEX idx_product_category ON products(category);

-- -------------------------
-- 4. BASIC SELECTS
-- -------------------------

SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM customers;

-- -------------------------
-- 5. WHERE
-- -------------------------

SELECT * FROM orders
WHERE quantity > 1;

-- -------------------------
-- 6. ORDER BY
-- -------------------------

SELECT * FROM products
ORDER BY price DESC;

-- -------------------------
-- 7. GROUP BY
-- -------------------------

SELECT p.product_name, SUM(p.price * o.quantity) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

SELECT c.customer_name, AVG(p.price * o.quantity) AS avg_spend
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.product_id
GROUP BY c.customer_name;

-- -------------------------
-- 8. JOINS
-- -------------------------

-- INNER JOIN
SELECT c.customer_name, p.product_name, o.quantity
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON o.product_id = p.product_id;

-- LEFT JOIN
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- -------------------------
-- 9. SUBQUERY
-- -------------------------

SELECT * FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);

-- -------------------------
-- 10. VIEWS
-- -------------------------

CREATE VIEW high_value_orders AS
SELECT o.order_id, c.customer_name, p.product_name, p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON p.product_id = o.product_id
WHERE p.price > 5000;

CREATE VIEW high_value_orders1 AS
SELECT o.order_id, c.customer_name, p.product_name, p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON p.product_id = o.product_id
WHERE p.price > 5000;

SELECT * FROM high_value_orders1;
