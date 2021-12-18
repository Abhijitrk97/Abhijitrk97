CREATE OR REPLACE VIEW EmployeeDetailsWithGreaterSalaryThanManagers AS
SELECT a.empid as empid, a.salary as employeesalary, b.empid as managerid, b.salary as managersalary  FROM employees a
join employees b on a.mgrid = b.empid 
where a.salary > b.salary;


CREATE OR REPLACE VIEW expiredTransactionDetails AS 
SELECT * FROM transactions WHERE (card_expirydate - sysdate) < 0;



CREATE OR REPLACE VIEW mostDissatisfiedCustomersView AS
SELECT  customerid, count(customerid) 
as return_frequency 
from returns 
group by customerid 
order by count(customerid) desc fetch first 1 rows only;


CREATE OR REPLACE VIEW RecentProductExpiryDate AS
SELECT productid, product_name,brand, description,expiry_date from product where expiry_date < sysdate order by expiry_date desc fetch first 1 rows only;


CREATE OR REPLACE VIEW MostPurchaseByCustomer AS
SELECT customerid, sum(amount) as total from orders group by customerid order by total desc fetch first 1 rows only;



CREATE OR REPLACE VIEW MostReturnedProducts AS
SELECT product_id, count(*) as frequency from returns group by product_id;


CREATE OR REPLACE VIEW TotalAmountByCity AS
SELECT customers.city,sum(orders.amount) as total from 
customers join orders on customers.customerid = orders.customerid
group by customers.city;



CREATE OR REPLACE VIEW TotalAmountByCountry AS
SELECT customers.country,sum(orders.amount) as total 
from customers join orders on customers.customerid = orders.customerid
group by customers.country;


CREATE OR REPLACE VIEW CityOrdersByDate AS
SELECT customers.city,orders.order_date, orders.amount 
from customers join orders on customers.customerid = orders.customerid;


CREATE OR REPLACE VIEW CustomerView AS
SELECT p.productid,p.product_name,p.brand,p.description,p.expiry_date,c.category_id,c.sub_category,c.category_main
from product p join category c on c.category_id = p.category_id;

CREATE OR REPLACE VIEW InventoryDetails AS
SELECT i.inventory_id,i.inventory_name,i.storage_space,s.supplierno,Product_id from 
inventory i join supplier_inventory s on i.inventory_id = s.inventory_id;

CREATE OR REPLACE VIEW RecentOrders AS
SELECT orderid,customerid,amount,order_date from orders order by abs(order_date-sysdate) desc;

CREATE OR REPLACE VIEW YearlyAndMonthlyOrderCount AS
SELECT  EXTRACT(year from order_date) year, EXTRACT (month from order_date) month, COUNT(orderid) order_count FROM orders
GROUP BY EXTRACT(YEAR FROM order_date),EXTRACT(MONTH FROM order_date) Order by year desc,month;

CREATE OR REPLACE VIEW YearlySales AS
SELECT  EXTRACT(year from order_date) year, sum(amount) as total FROM orders
GROUP BY EXTRACT(YEAR FROM order_date) Order by year desc;
