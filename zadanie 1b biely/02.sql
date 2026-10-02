SELECT product_name, total_amount
FROM flourmills_sales
WHERE total_amount > (SELECT AVG(total_amount) FROM flourmills_sales);

SELECT *
FROM flourmills_sales
WHERE product_category = (
    SELECT product_category
    FROM flourmills_sales
    GROUP BY product_category
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
)
ORDER BY sales_id ASC;

SELECT 
    product_name, 
    total_amount, 
    (SELECT AVG(total_amount) FROM flourmills_sales) AS avg_amount
FROM flourmills_sales;

SELECT 
    product_name, 
    total_amount, 
    total_amount / (SELECT SUM(total_amount) FROM flourmills_sales) AS amount_share
FROM flourmills_sales;

SELECT month, monthly_sales
FROM (
    SELECT EXTRACT(MONTH FROM sale_date) AS month, SUM(total_amount) AS monthly_sales
    FROM flourmills_sales
    GROUP BY EXTRACT(MONTH FROM sale_date)
) AS sub
ORDER BY monthly_sales DESC;

SELECT product_category, total_sales
FROM (
    SELECT product_category, SUM(total_amount) AS total_sales
    FROM flourmills_sales
    GROUP BY product_category
) AS sub
WHERE total_sales > 50000000
ORDER BY total_sales DESC;

SELECT product_name, product_category, total_amount
FROM flourmills_sales AS f1
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM flourmills_sales AS f2
    WHERE f1.product_category = f2.product_category
);

SELECT 
    product_name, 
    region, 
    total_amount, 
    (SELECT MIN(total_amount) FROM flourmills_sales AS f2 WHERE f2.region = f1.region) AS region_min_amount
FROM flourmills_sales AS f1;

SELECT *
FROM flourmills_sales AS f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.product_name = f1.product_name
    GROUP BY f2.product_name
    HAVING COUNT(DISTINCT EXTRACT(MONTH FROM f2.sale_date)) > 1
);

SELECT product_category, product_name, total_amount
FROM flourmills_sales AS f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.product_category = f1.product_category
      AND f2.total_amount > 200000
);

SELECT DISTINCT product_category
FROM flourmills_sales AS f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.product_category = f1.product_category
    GROUP BY f2.product_category
    HAVING COUNT(DISTINCT region) > 3
);

SELECT *
FROM flourmills_sales AS f1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.region = f1.region
      AND EXTRACT(YEAR FROM f2.sale_date) = 2024
);

SELECT DISTINCT product_category
FROM flourmills_sales AS f1
WHERE NOT EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.product_category = f1.product_category
      AND f2.total_amount > 500000
);

SELECT DISTINCT region
FROM flourmills_sales AS f1
WHERE NOT EXISTS (
    SELECT 1
    FROM flourmills_sales AS f2
    WHERE f2.region = f1.region
      AND f2.product_category = 'Flour'
);