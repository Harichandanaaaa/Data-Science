-- Find sine value of an angle./
select round(sin(45*(acos(-1)/180)),5) as sin_val from dual;

-- Find cosine value of an angle.
select round(cos(30*(acos(-1)/180)),5) as cosine_val from dual;

-- Find tangent value.
select round(tan(30*(acos(-1)/180)),5) as tan_val from dual;

-- Convert degrees to radians.
select round(45*(acos(-1)/180),5) as degree_rad from dual;

-- Convert radians to degrees.
select round(1*(180)/3.14,5) as rad_degree from dual;

-- Find logarithm (base 10) of a number.
select log(10,100) as log_base_10 from dual;

-- Find natural log of a number.
select ln(3) as natural_log_num from dual;

-- Find square of a number.
select power(2,2) as square_no from dual;
select 3*2 as square_no from dual;

-- Find cube of a number.
select power(2,3) as cube_no from dual;

-- Calculate factorial of a number.
select 5 as n,round(exp(sum(ln(level)))) as factorial from dual connect by level <=5;
 
-- Find greatest value among three numbers.
select greatest(12,34,14) as greatest_num from dual;

-- Find least value among three numbers.
select least(12,34,14) as least_num from dual;

-- Calculate variance of sales.
select VARIANCE(quantity*Unit_Price) as sales_variance from orders;

-- Calculate standard deviation of sales.
select stddev(Quantity*Unit_Price) as sales_deviation from orders;

-- Find average deviation.
select avg(ABS(sales - avg_sal)) AS avg_deviation
FROM (SELECT QUANTITY*unit_price as sales, AVG(QUANTITY*unit_price) over() AS avg_sal FROM ORDERS);

-- Calculate geometric mean.
SELECT EXP(AVG(LN(QUANTITY*unit_price))) AS geometric_mean
FROM ORDERS WHERE QUANTITY*unit_price > 0;

-- Calculate harmonic mean.
SELECT COUNT(QUANTITY*unit_price) / SUM(1 / QUANTITY*unit_price) AS harmonic_mean
FROM ORDERS WHERE QUANTITY*unit_price IS NOT NULL AND QUANTITY*unit_price <> 0;

-- Find sum of squares.
select sum(power(quantity,2)) sum_of_squares from ORDERS; 

-- Calculate correlation between two columns.
select corr(quantity*unit_price, unit_price) correlation from orders;

-- Calculate regression slope.
select REGR_SLOPE(quantity*unit_price, unit_price) reg_slope from orders;