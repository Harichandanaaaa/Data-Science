-- 1. Create CUSTOMERS Table
CREATE TABLE CUSTOMERS (
    CUSTOMER_ID NUMBER PRIMARY KEY,
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50),
    CITY VARCHAR2(50),
    PHONE_NUMBER VARCHAR2(20),
    LOYALTY_POINTS NUMBER
);

select * from CUSTOMERS;


-- 2. Create ORDERS Table
CREATE TABLE ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    TOTAL_AMOUNT NUMBER(10, 2),
    DISCOUNT_AMT NUMBER(10, 2), -- Can be NULL if no discount
    SHIPPING_DATE DATE          -- Can be NULL if not shipped yet
);

-- 3. Insert Data with intentional NULL values
-- Customers
INSERT INTO CUSTOMERS VALUES (101, 'John', 'Doe', 'New York', '555-0100', 500);
INSERT INTO CUSTOMERS VALUES (102, 'Jane', 'Smith', NULL, '555-0101', 120);
INSERT INTO CUSTOMERS VALUES (103, 'Robert', 'Brown', 'Chicago', NULL, 0);
INSERT INTO CUSTOMERS VALUES (104, 'Emily', 'Davis', NULL, NULL, NULL); -- Lots of NULLs
INSERT INTO CUSTOMERS VALUES (105, 'Michael', 'Wilson', 'Miami', '555-0105', NULL);

-- Orders
INSERT INTO ORDERS VALUES (5001, 101, DATE '2023-10-01', 150.00, 10.00, DATE '2023-10-03');
INSERT INTO ORDERS VALUES (5002, 102, DATE '2023-10-02', 200.50, NULL, DATE '2023-10-05'); -- No discount
INSERT INTO ORDERS VALUES (5003, 101, DATE '2023-10-05', 75.00, 5.00, NULL); -- Not shipped
INSERT INTO ORDERS VALUES (5004, 104, DATE '2023-10-06', 300.00, NULL, NULL); -- No discount, Not shipped
INSERT INTO ORDERS VALUES (5005, 105, DATE '2023-10-07', 50.00, 0.00, DATE '2023-10-08');
INSERT INTO ORDERS VALUES (5006, NULL, DATE '2023-10-08', 20.00, NULL, DATE '2023-10-09'); -- Orphan order

COMMIT;
select * from orders;

-- 1.(Inner Join) List the FIRST_NAME of the customer and the TOTAL_AMOUNT for all orders that have a Discount (DISCOUNT_AMT is not null).
select c.first_name, o.total_amount 
from customers c join orders o on c.customer_id = o.customer_id
where o.discount_amt is not null;

-- 2.(Left Join) List all Customers. If they have an order, display the ORDER_DATE. If not, ensure the row still appears with a NULL date.
select c.first_name||' '||c.last_name as full_name, o.order_date
from customers c left join orders o 
on c.customer_id= o.customer_id;

-- 3.(Right Join) Display ORDER_ID and FIRST_NAME. We want to see all orders, including the one with CUSTOMER_ID NULL (Order 5006).
select c.first_name, o.order_id 
from customers c right join orders o 
on c.customer_id = o.customer_id;

-- 4.(Full Outer Join) Find the count of rows returned when you Full Outer Join Customers and Orders. (Try to predict the number before running it).
select count(*) 
from customers c full outer join orders o
on c.customer_id = o.customer_id;

-- 7 must be the total rows
select count(*)
from customers c full OUTER join orders o 
on c.customer_id = o.customer_id;

-- 5.(Left Join - Anti Join) Find the CUSTOMER_IDs that exist in the CUSTOMERS table but do NOT exist in the ORDERS table.
select o.order_id,c.customer_id,c.FIRST_NAME
from customers c left join orders o
on c.customer_id=o.customer_id
where o.customer_id is null;

-- 6.(Self Join) Find pairs of Orders (O1, O2) that were placed on the exact same ORDER_DATE
select o1.order_id as order1,
o2.order_id as order2,
o1.order_date
from orders o1 
join orders o2
on o1.order_date =o2.order_date
where o1.order_id <> o2.order_id;

-- 7.(Cross Join) Create a list showing every Customer paired with every unique CITY found in the Customer table.
select c.first_name,ct.city
from customers c cross JOIN
(select distinct city from customers where city is not null)ct;

-- 8.(Inner Join + Aggregates) Calculate the total DISCOUNT_AMT given to customers living in 'New York'.
select c.first_name||' '||c.last_name as full_name, sum(o.discount_amt) as total_discount,c.city
from customers c inner join orders o on c.customer_id = o.customer_id
where city='New York'
group by c.first_name,c.last_name,c.city;

-- 9.(Left Join + NVL) Select FIRST_NAME and the SHIPPING_DATE. If the shipping date is NULL (either because the order isn't shipped OR the customer has no order), display 'Not Shipped'.
select c.first_name,o.SHIPPING_DATE, nvl(to_char(shipping_date,'dd/mm/yyyy'),'Not shippid')
from customers c left join orders o on c.customer_id= o.customer_id;

-- 10.(Right Join) Find the sum of TOTAL_AMOUNT for orders that do not have a linked Customer (Orphan orders).
select sum(o.total_amount) as sum_amount
from customers c right join orders o on c.customer_id = o.customer_id
where c.first_name is null;

-- 11.(Natural Join) Use a Natural Join to display LAST_NAME and TOTAL_AMOUNT. (Be careful: does LOYALTY_POINTS exist in both tables? No? Then it uses CUSTOMER_ID).
select c.last_name, o.total_amount
from customers c NATURAL JOIN orders o;

-- 12.(Left Join with Multiple Conditions) Join Customers to Orders, but ONLY link orders where the TOTAL_AMOUNT is greater than 100. Customers with small orders should look like they have NULL orders.
select c.first_name||' '||c.last_name as full_name,o.total_amount
from customers c left join orders o on c.customer_id =o.CUSTOMER_ID
and o.total_amount > 100;

-- 13.(Inner Join) List FIRST_NAME and ORDER_ID for customers who have a Phone Number (IS NOT NULL).
select c.first_name, o.order_id, c.PHONE_NUMBER
from customers c join orders o 
on c.customer_id = o.CUSTOMER_ID
where c.phone_number is not null;

-- 14.(Full Join + Coalesce) Display a list of IDs. If it's a Customer without an order, show Customer ID. If it's an Order without a Customer, show Order ID. Use COALESCE.
select coalesce(c.customer_id,o.order_id) as id
from customers c full join ORDERS o
on c.customer_id=o.customer_id;

-- 15.(Self Join) Find customers who have the same LOYALTY_POINTS value as another customer.
select c1.customer_id as customer1,
c2.customer_id as customer2,
c1.LOYALTY_POINTS
from customers c1 
join customers c2
on c1.loyalty_points=c2.loyalty_points
AND c1.customer_id <> c2.customer_id;

-- 16.(Inner Join) Display FIRST_NAME, CITY, and ORDER_DATE for orders that have actually been shipped (SHIPPING_DATE is not null).
select c.first_name,c.city, o.order_date
from customers c inner join orders o 
on c.customer_id = o.CUSTOMER_ID
where o.shipping_date is not null;

-- 17.(Left Join) Calculate the Average TOTAL_AMOUNT per Customer. Ensure customers with no orders show up (likely as NULL or 0 depending on how you write the Average).
select c.first_name, nvl(avg(o.total_amount),0) as Avg_value
from customers c left join orders o 
on c.customer_id =o.customer_id
-- where o.total_amount is null
group by c.first_name; 

-- 18.(Cartesian/Cross) Count how many rows are generated if you Cross Join CUSTOMERS (5 rows) and ORDERS (6 rows).
select count(*)
from customers 
cross join ORDERS ;

-- 19.(Join with Date Comparison) Find Customers who placed an order on the same day their account was created? (Wait, we don't have account creation date. Instead: Find Orders placed after the shipping date? This checks for data errors).
select * from orders;
select c.first_name, o.order_date,o.shipping_date
from customers c join orders o
on c.customer_id=o.customer_id
where o.order_date< o.shipping_date;

-- 20.(Three-way Simulation) Advanced Challenge: Perform a Left Join from Customers to Orders, and then Self Join that result to find Customers who have placed more than one order.

SELECT a.customer_id, a.first_name
FROM (
    SELECT c.customer_id, c.first_name, o.order_id
    FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id
) a
JOIN (
    SELECT c.customer_id, c.first_name, o.order_id
    FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id
) b
ON a.customer_id = b.customer_id
AND a.order_id <> b.order_id;

 