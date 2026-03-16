-- Assign row numbers to each order.
SELECT Order_ID,
       ROW_NUMBER() OVER (ORDER BY Order_Date) AS Row_Num
FROM Orders;

-- Rank products by price.
SELECT Product_Name,
       RANK() OVER (ORDER BY Unit_Price DESC) AS Price_Rank
FROM Orders;

-- Dense rank products by sales.
SELECT Product_Name,
       DENSE_RANK() OVER (ORDER BY (Unit_Price * Quantity) DESC) AS Sales_Rank
FROM Orders;

-- Find running total of sales.
SELECT Order_Date,
       SUM(Unit_Price * Quantity) 
       OVER (ORDER BY Order_Date) AS Running_Total
FROM Orders;

-- Calculate cumulative sum by month.
SELECT Order_Date,
       SUM(Unit_Price * Quantity)
       OVER (PARTITION BY TO_CHAR(Order_Date,'MM')
             ORDER BY Order_Date) AS Monthly_Cumulative_Sum
FROM Orders;

-- Find moving average of last 3 days
SELECT Order_Date,
       AVG(Unit_Price * Quantity)
       OVER (ORDER BY Order_Date
             ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Avg_3_Days
FROM Orders;

-- Calculate lag of previous day sales.
SELECT Order_Date,
       (Unit_Price * Quantity) AS Sales,
       LAG(Unit_Price * Quantity)
       OVER (ORDER BY Order_Date) AS Previous_Day_Sales
FROM Orders;

-- Calculate lead of next day sales.
SELECT Order_Date,
       (Unit_Price * Quantity) AS Sales,
       LEAD(Unit_Price * Quantity)
       OVER (ORDER BY Order_Date) AS Next_Day_Sales
FROM Orders;

-- Find difference between current and previous sale.
SELECT Order_Date,
       (Unit_Price * Quantity) -
       LAG(Unit_Price * Quantity)
       OVER (ORDER BY Order_Date) AS Sales_Difference
FROM Orders;

-- Partition sales by region.
SELECT Region,
       SUM(Unit_Price * Quantity)
       OVER (PARTITION BY Region) AS Region_Total_Sales
FROM Orders;

-- Find top 3 products per category.
SELECT *
FROM (
    SELECT Category,
           Product_Name,
           RANK() OVER (PARTITION BY Category
                        ORDER BY Unit_Price DESC) AS Rank_Value
    FROM Orders
)
WHERE Rank_Value <= 3;

-- Find bottom 2 customers by sales.
SELECT *
FROM (
    SELECT Customer_Name,
           SUM(Unit_Price * Quantity) AS Total_Sales,
           RANK() OVER (ORDER BY SUM(Unit_Price * Quantity)) AS Rank_Value
    FROM Orders
    GROUP BY Customer_Name
)
WHERE Rank_Value <= 2;

-- Calculate percentage of total sales.
SELECT Order_ID,
       (Unit_Price * Quantity) /
       SUM(Unit_Price * Quantity) OVER () * 100 AS Sales_Percentage
FROM Orders;

-- Calculate NTILE distribution of customers.
SELECT Customer_Name,
       NTILE(4) OVER (ORDER BY SUM(Unit_Price * Quantity) DESC) AS Sales_Group
FROM Orders
GROUP BY Customer_Name;

-- Find first order per customer.
SELECT *
FROM (
    SELECT Customer_Name,
           Order_Date,
           ROW_NUMBER() OVER (PARTITION BY Customer_Name
                              ORDER BY Order_Date) AS RN
    FROM Orders
)
WHERE RN = 1;

-- Find last order per customer.
SELECT *
FROM (
    SELECT Customer_Name,
           Order_Date,
           ROW_NUMBER() OVER (PARTITION BY Customer_Name
                              ORDER BY Order_Date DESC) AS RN
    FROM Orders
)
WHERE RN = 1;

-- Calculate average salary within department.
SELECT Department,
       AVG(Salary) OVER (PARTITION BY Department) AS Avg_Department_Salary
FROM Employees;

-- Compare current row with max value in partition.
SELECT Region,
       Unit_Price,
       MAX(Unit_Price) OVER (PARTITION BY Region) AS Max_In_Region
FROM Orders;

-- Identify duplicate records using ROW_NUMBER.
SELECT *
FROM (
    SELECT Order_ID,
           ROW_NUMBER() OVER (PARTITION BY Order_ID ORDER BY Order_Date) AS RN
    FROM Orders
)
WHERE RN > 1;

-- -- Find cumulative distinct count.
SELECT Order_Date,
       COUNT(DISTINCT Customer_Name)
       OVER (ORDER BY Order_Date
             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
       AS Cumulative_Distinct_Customers
FROM Orders;