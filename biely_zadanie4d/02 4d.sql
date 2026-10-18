WITH ranked_orders AS (
    SELECT 
        c.customer_name,
        o.order_id,
        o.order_date,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id

    -----------------------------------------------------------------------------------------------------------
)
SELECT 
    customer_name,
    order_id,
    order_date
FROM ranked_orders
WHERE rn <= 2
ORDER BY customer_name ASC, rn ASC;


--------------------------------------------------------------------------------

WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)::date
),
sales_lag AS (
    SELECT 
        month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY month ASC) AS prev_month_sales
    FROM monthly_sales
)
SELECT 
    month,
    monthly_sales,
    prev_month_sales,
    (monthly_sales - prev_month_sales) AS sales_change,
    ROUND(CAST(((monthly_sales - prev_month_sales) / prev_month_sales) * 100 AS numeric), 2) AS growth_percentage
FROM sales_lag
ORDER BY month ASC;

-------------------------------------------------------------------------------------------------------------------------------
WITH product_sales AS (
    SELECT 
        p.category,
        p.product_name,
        SUM(o.sales) AS product_sales
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY p.category, p.product_name
),
category_totals AS (
    SELECT 
        category,
        product_name,
        product_sales,
        SUM(product_sales) OVER (PARTITION BY category) AS category_total
    FROM product_sales
)
SELECT 
    category,
    product_name,
    product_sales,
    category_total,
    ROUND(CAST((product_sales * 100.0 / category_total) AS numeric), 2) AS pct_of_category
FROM category_totals
ORDER BY category ASC, pct_of_category DESC;

-------------------------------------------------------------
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;