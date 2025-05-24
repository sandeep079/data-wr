-- Active: 1747995697399@@127.0.0.1@3306@classicmodels
SELECT * 
FROM customers
 WHERE creditLimit > 20000;
#
#
#
#
SELECT e.*
FROM employees e
JOIN employees vp ON e.reportsTo = vp.employeeNumber
WHERE vp.jobTitle = 'VP Sales';

SELECT * 
FROM customers
WHERE state IS NOT NULL
  AND country = 'USA'
  AND creditLimit BETWEEN 100000 AND 200000;


SELECT e.*
FROM employees e
JOIN employees sm ON e.reportsTo = sm.employeeNumber
WHERE sm.jobTitle LIKE '%Sales Manager%';

#
SELECT country, AVG(creditLimit) AS avgCreditLimit
FROM customers
GROUP BY country;

#
#
SELECT customerNumber, orderDate, COUNT(*) AS totalOrders
FROM orders
GROUP BY customerNumber, orderDate
HAVING COUNT(*) > 10;
#

#
#
SELECT 
  e.firstName,
  e.lastName,
  e.jobTitle,
  (SELECT COUNT(*) FROM employees WHERE reportsTo = e.employeeNumber) AS totalSupervisees
FROM employees e
WHERE (SELECT COUNT(*) FROM employees WHERE reportsTo = e.employeeNumber) > 0;
#
#
SELECT 
  sup.firstName,
  sup.lastName,
  sup.jobTitle,
  COUNT(emp.employeeNumber) AS totalSupervisees
FROM employees sup
LEFT JOIN employees emp ON emp.reportsTo = sup.employeeNumber
GROUP BY sup.employeeNumber
HAVING totalSupervisees > 0;
#
#
#
WITH avgCredit AS (
  SELECT AVG(creditLimit) AS avgLimit FROM customers
)
SELECT * 
FROM customers
WHERE creditLimit > (SELECT avgLimit FROM avgCredit);
#
#
#


WITH ranked_customers AS (
  SELECT
    customerNumber,
    customerName,
    creditLimit,
    RANK() OVER (ORDER BY creditLimit DESC) AS credit_rank
  FROM customers
)
SELECT * FROM ranked_customers
LIMIT 100




#
#
###
#SELECT officeCode, COUNT(*) AS totalEmployees
#FROM employees
#GROUP BY officeCode;
###
#
SELECT officeCode, COUNT(*) AS totalCustomers
FROM customers
GROUP BY officeCode;

SELECT salesRepEmployeeNumber, COUNT(*) AS totalCustomers
FROM customers
GROUP BY salesRepEmployeeNumber;

#
#
SELECT o.officeCode, o.city, COUNT(DISTINCT c.customerNumber) AS totalCustomers
FROM customers c
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
GROUP BY o.officeCode, o.city;
#
#
#
SELECT o.officeCode, o.city, o.state, o.country, SUM(p.amount) AS totalPayments
FROM payments p
JOIN customers c ON p.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
GROUP BY o.officeCode, o.city, o.state, o.country;
#
#
#

SELECT o.officeCode, o.city, SUM(od.priceEach * od.quantityOrdered) AS totalSales
FROM orderdetails od
JOIN orders ord ON od.orderNumber = ord.orderNumber
JOIN customers c ON ord.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
GROUP BY o.officeCode, o.city;
#
#
#

SELECT
  o.officeCode,
  o.city,
  (SUM(od.priceEach * od.quantityOrdered) - IFNULL(SUM(p.amount), 0)) AS paymentPending
FROM orders ord
JOIN orderdetails od ON ord.orderNumber = od.orderNumber
JOIN customers c ON ord.customerNumber = c.customerNumber
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o ON e.officeCode = o.officeCode
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY o.officeCode, o.city;
#
#
#
#
#SELECT
#  customerNumber,
#  country,
#  creditLimit,
#  creditLimit / SUM(creditLimit) OVER (PARTITION BY country) AS proportion
#FROM customers;
#
#
#

CREATE VIEW customer_order_summary AS
SELECT
  c.customerName,
  CONCAT_WS(', ', c.addressLine1, c.addressLine2, c.city, c.state, c.postalCode, c.country) AS fullAddress,
  (SELECT COUNT(*) FROM orders o WHERE o.customerNumber = c.customerNumber) AS totalOrders
FROM customers c;

#
#
#
UPDATE customers
SET country = 'Canada'
WHERE customerNumber = 103;




DELETE FROM payments
WHERE amount < 20000;



INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (103, 'AB123456', CURDATE(), 25000);


-- Insert or update the row
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (103, 'AB123456', CURDATE(), 25000)
ON DUPLICATE KEY UPDATE
amount = VALUES(amount), paymentDate = VALUES(paymentDate);
SELECT * FROM payments
WHERE customerNumber = 103 AND checkNumber = 'AB123456';



-- 14.​Generate a report that shows total sales(in amount) by each office using order details
--table and other essential tables.
SELECT offices.`officeCode`, offices.state, offices.country, SUM(orderdetails.`quantityOrdered` * orderdetails.`priceEach`) as totalSales
FROM customers
JOIN employees
ON customers.`salesRepEmployeeNumber` = employees.`employeeNumber`
JOIN offices
ON employees.`officeCode` = offices.`officeCode`
JOIN orders
ON orders.`customerNumber` = customers.`customerNumber`
JOIN orderdetailsSELECT offices.`officeCode`, SUM(orderdetails.`quantityOrdered` * orderdetails.`priceEach`) as pendingPayment
FROM customers
JOIN employees
ON customers.`salesRepEmployeeNumber` = employees.`employeeNumber`
JOIN offices
ON employees.`officeCode` = offices.`officeCode`
JOIN orders
ON orders.`customerNumber` = customers.`customerNumber`
JOIN orderdetails
ON orderdetails.`orderNumber` = orders.`orderNumber`
WHERE orders.status IN ("On Hold", "Disputed", "In Process")
GROUP BY offices.`officeCode`
ORDER BY offices.`officeCode`;
ON orderdetails.`orderNumber` = orders.`orderNumber`
GROUP BY offices.`officeCode`, offices.city, offices.country;







-- First, check how many payments will be affected
SELECT COUNT(*) as payments_to_delete
FROM payments 
WHERE amount < 20000;

-- Delete payments below 20,000
DELETE FROM payments 
WHERE amount < 20000;

-- Verify deletion
SELECT COUNT(*) as remaining_payments
FROM payments;



--20
SELECT customerNumber, customerName 
FROM customers 
WHERE customerNumber = 103;
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (103, 'CHK001', '2024-01-15', 25000.00);
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (103, 'CHK002', '2024-02-15', 30000.00);
SELECT * FROM payments 
WHERE customerNumber = 103 
ORDER BY paymentDate DESC;






--19
SELECT COUNT(*) as payments_to_delete
FROM payments 
WHERE amount < 20000;
SELECT * FROM payments WHERE amount < 20000;
DELETE FROM payments 
WHERE amount < 20000;
SELECT COUNT(*) as remaining_payments
FROM payments;
SELECT COUNT(*) as payments_above_20000
FROM payments 
WHERE amount >= 20000;





--18
SELECT customerNumber, customerName, country 
FROM customers 
WHERE customerNumber = 103;
UPDATE customers 
SET country = 'Canada' 
WHERE customerNumber = 103;
SELECT customerNumber, customerName, country 
FROM customers 
WHERE customerNumber = 103;





CREATE VIEW customer_order_summary AS
SELECT 
    c.customerNumber,
    c.customerName,
    CONCAT(c.addressLine1, 
           CASE WHEN c.addressLine2 IS NOT NULL THEN CONCAT(', ', c.addressLine2) ELSE '' END,
           ', ', c.city,
           CASE WHEN c.state IS NOT NULL THEN CONCAT(', ', c.state) ELSE '' END,
           ', ', c.postalCode,
           ', ', c.country) as complete_address,
    COUNT(o.orderNumber) as total_orders
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName, complete_address
ORDER BY total_orders DESC;

--17
CREATE VIEW customer_order_summary AS
SELECT 
    c.customerNumber,
    c.customerName,
    CONCAT(c.addressLine1, 
           CASE WHEN c.addressLine2 IS NOT NULL THEN CONCAT(', ', c.addressLine2) ELSE '' END,
           ', ', c.city,
           CASE WHEN c.state IS NOT NULL THEN CONCAT(', ', c.state) ELSE '' END,
           ', ', c.postalCode,
           ', ', c.country) AS complete_address,
    COUNT(o.orderNumber) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY 
    c.customerNumber, 
    c.customerName, 
    c.addressLine1, c.addressLine2, c.city, c.state, c.postalCode, c.country
ORDER BY total_orders DESC;







--15
WITH order_totals AS (
    SELECT 
        c.customerNumber,
        SUM(od.quantityOrdered * od.priceEach) AS total_order_value
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY c.customerNumber
),
payment_totals AS (
    SELECT 
        customerNumber,
        SUM(amount) AS total_paid
    FROM payments
    GROUP BY customerNumber
),
customer_balances AS (
    SELECT 
        c.customerNumber,
        c.salesRepEmployeeNumber,
        COALESCE(ot.total_order_value, 0) - COALESCE(pt.total_paid, 0) AS payment_pending
    FROM customers c
    LEFT JOIN order_totals ot ON c.customerNumber = ot.customerNumber
    LEFT JOIN payment_totals pt ON c.customerNumber = pt.customerNumber
)
SELECT 
    o.officeCode,
    o.city,
    o.state,
    o.country,
    SUM(cb.payment_pending) AS payment_pending
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customer_balances cb ON e.employeeNumber = cb.salesRepEmployeeNumber
GROUP BY o.officeCode, o.city, o.state, o.country
ORDER BY payment_pending DESC;






--14
WITH customer_sales AS (
    SELECT 
        c.salesRepEmployeeNumber,
        SUM(od.quantityOrdered * od.priceEach) AS total_sales
    FROM customers c
    JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY c.salesRepEmployeeNumber
)
SELECT 
    o.officeCode,
    o.city,
    o.state,
    o.country,
    COALESCE(SUM(cs.total_sales), 0) AS total_sales
FROM offices o
LEFT JOIN employees e ON o.officeCode = e.officeCode
LEFT JOIN customer_sales cs ON e.employeeNumber = cs.salesRepEmployeeNumber
GROUP BY o.officeCode, o.city, o.state, o.country
ORDER BY total_sales DESC;







--6
SELECT o.orderDate, o.customerNumber, c.customerName, COUNT(*) AS total_orders
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY o.orderDate, o.customerNumber, c.customerName
HAVING COUNT(*) > 10
ORDER BY total_orders DESC;





SELECT offices.`officeCode`, SUM(orderdetails.`quantityOrdered` * orderdetails.`priceEach`) as pendingPayment
FROM customers
JOIN employees
ON customers.`salesRepEmployeeNumber` = employees.`employeeNumber`
JOIN offices
ON employees.`officeCode` = offices.`officeCode`
JOIN orders
ON orders.`customerNumber` = customers.`customerNumber`
JOIN orderdetails
ON orderdetails.`orderNumber` = orders.`orderNumber`
WHERE orders.status IN ("On Hold", "Disputed", "In Process")
GROUP BY offices.`officeCode`
ORDER BY offices.`officeCode`;