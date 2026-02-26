-- Round Unit_Price to 2 decimal places.
select round(Unit_Price, 2) AS rounded_price
from orders;

-- Find total sales per order.
select ORDER_ID,sum(Unit_Price) as total_sales from orders group by Order_id;

-- Calculate average order value.
select avg(Unit_Price) as total_avg from orders;

-- Find highest product price.
select max(Unit_Price) as highest_price from orders;

-- Find lowest product price.
select min(Unit_price) as lowest_price from orders;
select * from ORDERS;

-- Calculate percentage discount applied.

-- Find modulus of Quantity divided by 2.
select Quantity, mod(Quantity,2) as modules from orders;

-- Convert negative values to positive.
select abs(Unit_Price) from orders;

-- Truncate price without rounding.

-- Find square root of total sales.
select exp(5) as exponential_values from duals;

-- Calculate exponential value of a number.
select exp(5) as exponential_value from dual;
-- Calculate power of 2^5.
select pow(2,5) as  power_value from dual;

-- Find absolute difference between two prices.

-- Calculate sales growth percentage.
select round((newsales-oldsales)/oldsales)*100) as growth_perc from orders;

-- Find random number between 1 and 100.
select trunc(dbms_random.values(1,101)) as random_numbers from dual;

-- Divide total sales by number of orders.
select sum(unit_price*Quantity) / count(order_id) as total_sales from orders;

-- Find ceiling value of price.
select ceil(unit_price) from orders;

-- Find floor value of price.
select floor(unit_price) from orders;

-- Convert decimal to integer.
select round(unit_price) from orders;
-- Calculate compound interest.
select principal,rate,time,(principal*power((1+rate/100),time))-principal as compound_int from orders;