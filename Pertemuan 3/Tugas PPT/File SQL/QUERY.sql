SELECT * FROM customers;
DESCRIBE customers;

SELECT * FROM product;
DESCRIBE product;

#Menyaring Data
SELECT * FROM customers WHERE country = 'Mexico';
SELECT * FROM customers WHERE city IN('Paris', 'London');
SELECT * FROM product WHERE price >= 30;
SELECT * FROM product WHERE price BETWEEN 50 AND 60;
SELECT * FROM customers WHERE city LIKE 'S%';
SELECT * FROM customers WHERE country = 'Germany' AND city = 'Berlin';
SELECT * FROM customers WHERE country = 'Germany' OR country = 'Spain';
SELECT * FROM customers WHERE NOT country = 'Germany';
SELECT customername, contactname, address FROM customers WHERE address IS NULL;
SELECT MIN(Price) AS SmallestPrice FROM Product;
SELECT MAX(Price) AS LargestPrice FROM Product;
SELECT city FROM customers UNION SELECT city FROM SupplierID ORDER BY city;
SELECT ProductName FROM product WHERE productid = ANY(SELECT productid FROM product WHERE price = 10);
SELECT ALL ProductName FROM product WHERE TRUE;
SELECT * FROM product WHERE price > SOME (SELECT price FROM product WHERE price > 20);
SELECT * FROM product WHERE EXISTS (SELECT price FROM product WHERE price > 50);
SELECT * FROM product ORDER BY price ASC;
SELECT * FROM product ORDER BY ProductName DESC;
SELECT * FROM customers ORDER BY country ASC, CustomerName DESC;
SELECT productname, categoryid FROM product LIMIT 15;
SELECT city, count(*) AS customername FROM customers GROUP BY city;
SELECT customerName, City, country FROM customers;
SELECT customerName AS customer, contactName AS "Contact Person" FROM customers;
SELECT customerID AS ID, CustomerName AS Customer FROM customers;
SELECT DISTINCT city FROM customers;
SELECT COUNT(DISTINCT Country) FROM customers;

