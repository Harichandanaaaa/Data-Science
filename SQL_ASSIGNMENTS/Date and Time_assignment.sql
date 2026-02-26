-- Extract year from Order_Date.
select extract(year from order_date) as year from orders;

-- Extract month from Order_Date.
select extract(month from order_date) as month from orders;

-- Extract day from Order_Date.
select extract(day from order_date) as day from orders;

-- Find current date.
select current_date from orders;

-- Find current timestamp.
select current_timestamp from orders;

-- Add 7 days to Order_Date.
select order_date+7 as review_date from orders;

-- Subtract 30 days from Order_Date.
select order_date-30 as previous_date from orders;

-- Find difference between two dates.
select (current_date - order_date) as review_date from orders;

-- Find number of months between two dates.
select months_between(End_date,start_date) as number_months from orders;

-- Find last day of the month.
select last_day(order_date) as last_day from orders;

-- Get first day of the year.
select trunc(Order_Date, 'YYYY') AS First_Day_Of_Year from Orders;
 
-- Format date as 'DD-MM-YYYY'.
select to_char(Order_Date, 'DD-MM-YYYY') AS Formatted_Date from Orders;

-- Convert string to date.
select To_date('2026/02/20','YYYY/MM/DD') string_to_date;

-- Convert date to string.
select to_char(sysdate,'DD-MM-YYYY') date_to_string;

-- Find week number of the year.
select to_char(order_date, 'WW') as week from orders;

-- Find day name from date.
select to_char(order_date,'DAY') as Day from orders;

-- Find quarter of the year.
select to_char(order_date,'Q') as quarter from orders;

-- Calculate age from DOB.
select floor(months_between(sysdate, to_date('18-08-2001','DD-MM-yyyy'))/12) as age_years;

-- Check if date is weekend.



-- Find next Monday after a given date.
select order_date, next_day(order_date,'MONDAY') as Next_Monday from orders;