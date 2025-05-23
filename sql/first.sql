#-- Active: 1747995697399@@127.0.0.1@3306@classicmodels
#SELECT * 
#FROM customers
# WHERE creditLimit > 20000;
#
#
#
#
##SELECT e.*
##FROM employees e
##JOIN employees vp ON e.reportsTo = vp.employeeNumber
##WHERE vp.jobTitle = 'VP Sales';
##
#
#SELECT * 
#FROM customers
#WHERE state IS NOT NULL
#  AND country = 'USA'
#  AND creditLimit BETWEEN 100000 AND 200000;
#
#
#SELECT e.*
#FROM employees e
#JOIN employees sm ON e.reportsTo = sm.employeeNumber
#WHERE sm.jobTitle LIKE '%Sales Manager%';
#
#
#SELECT country, AVG(creditLimit) AS avgCreditLimit
#FROM customers
#GROUP BY country;
#
#
#
SELECT customerNumber, orderDate, COUNT(*) AS totalOrders
FROM orders
GROUP BY customerNumber, orderDate
HAVING COUNT(*) > 10;
#
#
#
#SELECT 
#  e.firstName,
#  e.lastName,
#  e.jobTitle,
#  (SELECT COUNT(*) FROM employees WHERE reportsTo = e.employeeNumber) AS totalSupervisees
#FROM employees e
#WHERE (SELECT COUNT(*) FROM employees WHERE reportsTo = e.employeeNumber) > 0;
#
#
#SELECT 
#  sup.firstName,
#  sup.lastName,
#  sup.jobTitle,
#  COUNT(emp.employeeNumber) AS totalSupervisees
#FROM employees sup
#LEFT JOIN employees emp ON emp.reportsTo = sup.employeeNumber
#GROUP BY sup.employeeNumber
#HAVING totalSupervisees > 0;
#
#
#
#WITH avgCredit AS (
#  SELECT AVG(creditLimit) AS avgLimit FROM customers
#)
#SELECT * 
#FROM customers
#WHERE creditLimit > (SELECT avgLimit FROM avgCredit);
#
#
#
#WITH ranked_customers AS (
#  SELECT
#    customerNumber,
#    customerName,
#    creditLimit,
#    RANK() OVER (ORDER BY creditLimit DESC) AS rank
#  FROM customers
#)
SELECT * 
FROM ranked_customers
WHERE rank = 3;


#
#
#
#SELECT officeCode, COUNT(*) AS totalEmployees
#FROM employees
#GROUP BY officeCode;
#
#
#
#
#SELECT o.officeCode, o.city, COUNT(DISTINCT c.customerNumber) AS totalCustomers
#FROM customers c
#JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
#JOIN offices o ON e.officeCode = o.officeCode
#GROUP BY o.officeCode, o.city;
#
#
#
#SELECT o.officeCode, o.city, o.state, o.country, SUM(p.amount) AS totalPayments
#FROM payments p
#JOIN customers c ON p.customerNumber = c.customerNumber
#JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
#JOIN offices o ON e.officeCode = o.officeCode
#GROUP BY o.officeCode, o.city, o.state, o.country;
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


