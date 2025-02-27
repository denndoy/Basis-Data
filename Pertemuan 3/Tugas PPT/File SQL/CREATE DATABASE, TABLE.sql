CREATE DATABASE CustomerDB;
USE CustomerDB;
CREATE TABLE customers (
	customerID INT PRIMARY KEY, 
	customerName VARCHAR(100), 
	contactName VARCHAR(100), 
	address VARCHAR(255), 
	city VARCHAR(100), 
	postalCode VARCHAR(20), 
	country VARCHAR(100) 
);

CREATE TABLE PRODUCT (
	ProductID INT PRIMARY KEY,    
	ProductName VARCHAR(100),    
	SupplierID INT,    
	CategoryID INT,    
	Unit VARCHAR(50),    
	Price DECIMAL(10, 2)
);

