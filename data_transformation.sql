-- Creating database and Using it
Create database retail_sales;

Use retail_sales;

--Creating table with table import
SHOW TABLES;

--Renaming TABLE train TO retail_sales_raw;
RENAME TABLE train TO retail_sales_raw;

-- Row Count
SELECT COUNT (*)
FROM retail sales_raw;

select * from retail sales raw;

-- Descibing data
DESCRIBE retail_sales_raw;

-- Creating a cleaned table
CREATE TABLE retail_sales_clean AS 
SELECT
'RoW ID' AS row_id,
'Order ID' AS order_id,
STR_TO_DATE (' Order Date','&d/m/%Y') AS order_date,
STR_TO_DATE('Ship Date','%d/%m/%Y') AS ship_date,
'Ship Mode' AS ship_mode,
'Customer ID' AS customer_id,
'Customer Name' AS customer_name,
'Segment' AS segment,
'Country' AS country,
'City' AS city,
'State' AS state,
'Postal Code' AS postal_code,
'Region' AS region,
'Product ID' AS product_id,
'Category' AS category,
'Sub-Category' AS sub_category,
'Product Name' AS product_name,
 Sales AS sales,
DATEDIFF(
  STR TO DATE ('Ship Date'
  STR TO DATE Order Date
) AS shipping_days
FROM retail_sales_raw;

-- validating the cleaned table
SELECT COUNT (*) FROM retail sales clean;


-- Adding additional column in the table
Alter table retail sales clean
ADD COLUMN order_year INT, 
ADD COLUMN order_month INT, 
ADD COLUMN order_month_name VARCHAR (15);

-- Updating retail_sales_clean table
UPDATE retail sales clean
SET
  order_year = YEAR(order_date),
  order_month = MONTH (order_date),
  order_month_name = MONTHNAME(order_date);

-- Checking for nulls
SELECT
COUNT (*) AS total_rows,
SUM (order_date IS NULL) AS null_order_date,
SUM( ship date IS NULL) AS null_ship_date,
SUM (sales IS NULL) AS null sales
FROM
retail sales_clean;

-- Checking for negative or zero sales
SELECT
  COUNT (*) AS negative_or_zero_sales
FROM retail sales_clean
WHERE sales <= 0;

-- Adding a customer_order count column
ALTER TABLE retail sales clean
ADD COLUMN
customer_order_count INT;

UPDATE retail sales clean c
JOIN (
  SELECT
    customer_id,
    COUNT (DISTINCT order_id) AS order_ent
FROM retail sales clean
GROUP BY customer_id
) t
ON c. customer id = t.customer id
SET c. customer_order_count = t. order_cnt;


-- Adding a sales category column
ALTER TABLE retail sales_clean
ADD COLUMN sales_category VARCHAR (20);

UPDATE retail sales clean
SET sales_category = CASE
  WHEN sales >= 1000 THEN 'High Value' 
  WHEN sales >= 500 THEN 'Medium Value'
  WHEN sales >= 100 THEN 'Low Value'
  ELSE 'Very Low Value'
END;

-- Adding a shipping performance column
ALTER TABLE retail sales clean
ADD COLUMN shipping_performance VARCHAR (20);

UPDATE retail sales clean
SET shipping_performance = CASE
  WHEN shipping days <= 2 THEN 'Fast'
  WHEN shipping_days <= 4 THEN 'Standard'
  ELSE 'Slow'
END;

-- Creating a customer summary table
CREATE TABLE customer_summary AS 
SELECT
  customer_id, 
  customer name, 
  segment, 
  region, 
  state.
  COUNT (DISTINCT order_id) AS total_orders,
  SUM (sales) AS lifetime value,
  AVG (sales) AS avg_order value,
  MIN (order_date) AS first_order_date,
  MAX (order_date) AS last_order_date,
FROM retail_sales_clean;
