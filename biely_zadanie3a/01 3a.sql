CREATE DATABASE datacraftinglab_db;

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    region VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ship_mode VARCHAR(30) NOT NULL,
    sales DECIMAL(10,2) NOT NULL,
    profit DECIMAL(10,2) NOT NULL
);

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

CREATE OR REPLACE PROCEDURE get_sales_between(start_date DATE, end_date DATE)
LANGUAGE plpgsql
AS $$
DECLARE
    total_sales NUMERIC;
BEGIN
    -- Výpočet súčtu stĺpca sales pre vybrané obdobie (predpokladá sa názov tabuľky napr. 'orders' alebo 'predaje')
    SELECT COALESCE(SUM(sales), 0)
    INTO total_sales
    FROM orders -- Nahraďte 'orders' skutočným názvom vašej tabuľky s objednávkami, ak sa líši
    WHERE order_date BETWEEN start_date AND end_date; -- Upravte názov stĺpca s dátumom podľa vašej schémy (napr. order_date, date, atď.)

    -- Výpis pomocou RAISE NOTICE podľa zadania
    RAISE NOTICE 'Začiatok obdobia: %, Konec obdobia: %, Celkový predaj: %', start_date, end_date, total_sales;
END;
$$;

