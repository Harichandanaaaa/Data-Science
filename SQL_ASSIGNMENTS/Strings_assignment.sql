 SET DEFINE OFF;

 CREATE TABLE Orders (
    Order_ID NUMBER PRIMARY KEY,
    Order_Date DATE,
     Customer_ID VARCHAR2(10),
    Customer_Name VARCHAR2(100),
    Product_Category VARCHAR2(100),
    Product_Name VARCHAR2(150),
    Quantity NUMBER,
    Unit_Price NUMBER(10,2),
    Payment_Mode VARCHAR2(50),
    Store_Location VARCHAR2(100)
);
INSERT ALL
    INTO Orders VALUES (1001, TO_DATE('2026-02-01','YYYY-MM-DD'), 'C001', 'Ravi Kumar', 'Electronics', 'Wireless Mouse', 2, 799, 'UPI', 'Bangalore')
    INTO Orders VALUES (1002, TO_DATE('2026-02-02','YYYY-MM-DD'), 'C002', 'Sneha Reddy', 'Grocery', 'Basmati Rice 5kg', 1, 650, 'Credit Card', 'Hyderabad')
    INTO Orders VALUES (1003, TO_DATE('2026-02-03','YYYY-MM-DD'), 'C003', 'Arjun Mehta', 'Fashion', 'Men''s T-Shirt', 3, 499, 'Cash', 'Chennai')
    INTO Orders VALUES (1004, TO_DATE('2026-02-04','YYYY-MM-DD'), 'C004', 'Priya Sharma', 'Electronics', 'Bluetooth Speaker', 1, 1499, 'Debit Card', 'Mumbai')
    INTO Orders VALUES (1005, TO_DATE('2026-02-05','YYYY-MM-DD'), 'C005', 'Kiran Rao', 'Home', 'Mixer Grinder', 1, 2499, 'UPI', 'Bangalore')
    INTO Orders VALUES (1006, TO_DATE('2026-02-06','YYYY-MM-DD'), 'C006', 'Neha Verma', 'Beauty', 'Face Cream', 4, 299, 'Credit Card', 'Delhi')
    INTO Orders VALUES (1007, TO_DATE('2026-02-07','YYYY-MM-DD'), 'C007', 'Rahul Das', 'Grocery', 'Cooking Oil 1L', 5, 180, 'Cash', 'Kolkata')
    INTO Orders VALUES (1008, TO_DATE('2026-02-08','YYYY-MM-DD'), 'C008', 'Anjali Nair', 'Fashion', 'Women''s Jeans', 2, 1199, 'UPI', 'Kochi')
    INTO Orders VALUES (1009, TO_DATE('2026-02-09','YYYY-MM-DD'), 'C009', 'Suresh Patel', 'Electronics', 'Smartphone', 1, 15999, 'Debit Card', 'Ahmedabad')
    INTO Orders VALUES (1010, TO_DATE('2026-02-10','YYYY-MM-DD'), 'C010', 'Meena Iyer', 'Home', 'Pressure Cooker', 1, 1899, 'Credit Card', 'Pune')
SELECT * FROM DUAL;

COMMIT;
select * from ORDERS;/
--Write a query to convert all customer names to uppercase.
select upper(customer_name) as customer_name from orders;

--Extract the first 5 characters from Product_Name.
select substr(Product_name,1,5) as first_five_char from orders;

--Find the length of each Customer_Name.
select length(Customer_Name) as length_name from orders;

--Replace the word "Rice" with "Premium Rice" in Product_Name.
select replace(Product_Name,'Rice','Premium Rice') as updated_name from orders;

--Remove leading and trailing spaces from Customer_Name.
select trim(Customer_Name),length(trim(CUSTOMER_NAME))as Len_Name from orders;

--Concatenate First_Name and Last_Name as Full_Name.
select concat(Fisrt_Name,Last_Name) as Full_Name from orders;

--Find customers whose names start with 'A'.
select * from orders where customer_name  Like 'A%';

--Extract the domain name from Email_ID.
select substr(email,1,instr(email,'@')-1) as domain from orders;

--Find the position of '@' in Email_ID.
select instr(email,'@') as position_at from orders;

--Reverse the Product_Name.
select product_name,reverse(product_name) as reversed_name from orders;

--Convert the first letter of each word in Product_Name to uppercase.
select Product_name, INITCAP(PRODUCT_NAME)  as up_name from orders;

--Extract the last 3 characters from Order_ID.
select Order_id, substr(order_id,-3) extracted_id from orders;

--Count how many times letter 'a' appears in Customer_Name.
select customer_name, regexp_count(customer_name,'a') as counts_letter_a from ORDERS;

--Mask the last 4 digits of a phone number.
select substr(phone_number,1,length(phone_number)-4)||'**' as masked_num from orders;

--Split Full_Name into First_Name and Last_Name.
select full_name, substr(full_name,1,instr(full_name,'')-1) as first_name, substr(full-name,instr(full_name,'')+1) as last_name from orders;

--Remove all special characters from Product_Code.
select Product_code, regexp_replace(Product_Code,'[&@#*%]','') as clean_code from orders;

--Compare two columns ignoring case sensitivity.
select *from orders,where upper(column1)=upper(column2);

--Find customers whose name contains 'kumar'.
select Customer_name from orders where lower(Customer_Name) LIKE '%kumar%';

--Pad Order_ID with leading zeros to make it 6 digits.
SELECT LPAD(Order_ID, 6, '0') AS padded_order_id FROM "ORDERS";

--Extract substring between two characters.
SELECT substr(email, instr(email, '@')+1,
    instr(email, '.') - instr(email, '@') -1
) as domain
from hr.EMPLOYEES;