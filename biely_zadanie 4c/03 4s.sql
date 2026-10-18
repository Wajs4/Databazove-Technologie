SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE TRIM(stock_code) = '18882'
  AND country = 'EIRE'
ORDER BY invoice_date;

SELECT DISTINCT stock_code, country 
FROM retail_sales 
WHERE stock_code LIKE '%18882%';

SELECT stock_code, country 
FROM retail_sales 
LIMIT 20;

SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE stock_code = '18882'


-------------------------------------
SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE TRIM(stock_code) LIKE '%18882%'
ORDER BY invoice_date;



SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE country = 'EIRE'
  AND stock_code LIKE '%18882%';

  SELECT DISTINCT stock_code, country 
FROM retail_sales 
WHERE stock_code LIKE '18%' 
LIMIT 5;

SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE stock_code = '18882'
ORDER BY invoice_date;



SELECT 
    stock_code,
    country,
    invoice_date,
    quantity,
    ROUND(
        AVG(quantity) OVER (
            PARTITION BY stock_code, country 
            ORDER BY invoice_date 
            RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW
        ), 2
    ) AS avg_quantity_7_days
FROM retail_sales
WHERE stock_code = '18882'
ORDER BY invoice_date;

SELECT stock_code, country, invoice_date, quantity 
FROM retail_sales 
WHERE stock_code = '18882';