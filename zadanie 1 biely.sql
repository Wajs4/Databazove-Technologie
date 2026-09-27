CREATE DATABASE superstore;
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100)
)

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(10,2),
    profit DECIMAL(10,2)
);

#uloha:2
SELECT o.order_id,c.customer_name,o.sales FROM orders o JOIN customers c ON o.customer_id  =c.customer_id WHERE o.sales > 500 ORDER BY o.sales DESC;

#uloha:3
SELECT o.order_id,c.customer_name,p.category,o.sales FROM orders o JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

#uloha:4
SELECT c.region,SUM(o.sales) AS total_sales FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.region;

#uloha:5
SELECT p.product_name,SUM(o.sales) AS total_sales FROM products p LEFT JOIN orders o ON p.product_id = o.product_id GROUP BY p.product_name;

#uloha:6
SELECT c.customer_name,o.order_id,o.sales FROM customers c FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;

#uloha:7
SELECT c.region,SUM(o.sales) AS total_sales FROM customers c JOIN orders o ON c.customer_id = o.customer_id GROUP BY c.region;
