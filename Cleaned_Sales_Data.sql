--Cleaning Data in SQL Queries

------------------------------------------------------------------------------------

SELECT *
FROM dbo.orders

------------------------------------------------------------------------------------

-- Standardize Data Format

SELECT ORDERDATE

ALTER TABLE dbo.orders
ADD ORDERDATES Date;

UPDATE dbo.orders
SET ORDERDATES = CONVERT(Date,ORDERDATE)

ALTER TABLE dbo.orders
DROP COLUMN ORDERDATE

------------------------------------------------------------------------------------

-- CONCAT addresses into one column

SELECT 
	CONCAT(ADDRESSLINE1,' ', ADDRESSLINE2) as ADDRESS
	, ADDRESSLINE1
	, ADDRESSLINE2
FROM dbo.orders

UPDATE dbo.orders
SET ADDRESSLINE1 = CONCAT(ADDRESSLINE1,' ', ADDRESSLINE2)

SELECT ADDRESSLINE1
FROM dbo.orders

ALTER TABLE dbo.orders
DROP COLUMN ADDRESSLINE2

------------------------------------------------------------------------------------

-- Round out the price and sales number 

SELECT
	ROUND(PRICEEACH,2) as PRICE
	,ROUND(SALES,2) as SALES
FROM dbo.orders

UPDATE dbo.orders
SET PRICEEACH = ROUND(PRICEEACH,2)

UPDATE dbo.orders
SET SALES = ROUND(SALES,2)

------------------------------------------------------------------------------------

-- Deal with null values

SELECT 
	COALESCE(STATE, 'Intl') -- International State Abbreviation
	,COALESCE(POSTALCODE, 'N/A') -- International Postal Code
FROM dbo.orders 

UPDATE dbo.orders
SET STATE = COALESCE(STATE, 'Intl')

UPDATE dbo.orders
SET POSTALCODE = COALESCE(POSTALCODE, 'N/A')
------------------------------------------------------------------------------------

-- Delete Unused Columns

SELECT *
FROM dbo.orders

ALTER TABLE dbo.orders
DROP COLUMN 
	PHONE
	, TERRITORY
	, MSRP
	, POSTALCODE
	, STATE
	, CITY
	, ORDERLINENUMBER

ALTER TABLE dbo.orders
DROP COLUMN
	PRODUCTCODE
