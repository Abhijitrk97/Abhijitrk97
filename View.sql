CREATE OR REPLACE VIEW "CustomerDetailsByCountryView" AS
SELECT count(*) from customers group by country;

CREATE OR REPLACE VIEW "EmployeeDetailsByDeptNoView" AS
SELECT count(*) from employees group by deptno;

CREATE OR REPLACE VIEW "expiredTransactionDetails" AS 
SELECT * FROM transactions WHERE (card_expirydate - sysdate) < 0;

CREATE OR REPLACE VIEW "mostDissatisfiedCustomersView" AS
SELECT customerid, count(customerid) from returns group by customerid;

CREATE OR REPLACE VIEW "Recent Product Expiry Date" AS
SELECT max(expiry_date) from product where expiry_date < sysdate;

CREATE OR REPLACE VIEW "HighestPurchaseAmountByEachCustomerView" AS
SELECT customerid, COUNT(DISTINCT orderid), MAX(amount) FROM orders GROUP BY customerid ORDER BY 2 DESC;

CREATE OR REPLACE VIEW "HighestPurchase" AS
SELECT customerid, max(amount) from orders group by customerid;

CREATE OR REPLACE VIEW "MostReturnedProducts" AS
SELECT product_id, count(*) from returns group by product_id;

CREATE OR REPLACE VIEW "TotalAmountByCity" AS
SELECT customers.city,sum(order.amount) from 
customers join orders on customers.customerid = orders.customerid
group by customers.city;

CREATE OR REPLACE VIEW "TotalAmountByCountry" AS
SELECT customers.country,sum(order.amount) 
from customers join orders on customers.customerid = orders.customerid
group by customers.country;

CREATE OR REPLACE VIEW "CityOrdersByDate" AS
SELECT customers.city,orders.order_date, orders.amount 
from customers join orders on customers.customerid = orders.customerid
group by customers.city;

CREATE OR REPLACE VIEW "EmployeeContact" AS 
SELECT emdpid,firstname,lastname,email,phoneno,address
FROM employees emp join department dept
on emp.deptno = dept.deptno
order by firstname;







