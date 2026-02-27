-- Replace NULL price with 0.
select nvl(null,0) as rep_null from dual;

-- Replace NULL Customer_Name with 'Unknown'.
select Customer_Name,nvl(Customer_Name,'unknown') as name_replaced from orders;

-- Count NULL values in Product_Name.
select count(*) as null_count from orders where Product_Name is null;

-- Find rows where Order_Date is NULL.
select Order_date from orders where Order_Date is Null;

-- Use COALESCE to return first non-null value.
select coalesce(store_location,'kolkata') from orders;

-- Use NVL to replace NULL values.
select nvl(store_location,'Kolkata') as store_location from orders;
-- (UPDATE orders
-- SET store_location = NULL
-- WHERE store_location = 'Kolkata';)

-- Use IFNULL function.
-- update orders SET store_location='kolkata'
-- where store_location=null;
select nvl(store_location,'kolkata') from orders;

-- Check if column is NULL.
select * from orders where price is null;

-- Check if column is NOT NULL.
select * from orders where price is not null;

-- Use NULLIF between two columns.
SELECT order_price,
       discount,
       NULLIF(order_price, discount) AS price_diff
FROM orders;

-- Replace blank values with NULL.
UPDATE orders
SET store_location = NULL
WHERE store_location = '';

-- Count non-null values.
SELECT COUNT(price) AS non_null_prices
FROM orders;

-- Filter records where price is NULL or 0.
SELECT *
FROM orders
WHERE price IS NULL OR price = 0;

-- Use CASE to handle NULL values.
SELECT order_id,
       CASE 
           WHEN price IS NULL THEN 0
           ELSE price
       END AS price_fixed
FROM orders;

-- Compare NULL values properly.
SELECT * 
FROM orders
WHERE price IS NULL; 

-- Handle NULL in aggregation.
SELECT AVG(price) AS avg_price FROM orders;

-- Sum ignoring NULL
SELECT SUM(price) AS total_price FROM orders;

-- Find average excluding NULL values.
SELECT AVG(price) AS avg_price
FROM orders;

-- Find sum ignoring NULL values.
SELECT SUM(price) AS total_price
FROM orders;

-- Identify columns containing NULL using metadata.
SELECT column_name
FROM user_tab_columns
WHERE table_name = 'ORDERS'
  AND nullable = 'Y';

-- Convert NULL to default system date.
SELECT NVL(order_date, SYSDATE) AS order_date_fixed
FROM orders;