USE AdventureWorksDW2025

-- Truy vấn cơ bản
-- Bài tập 1

SELECT 
	AccountKey, 
	AccountDescription, 
	AccountType
FROM DimAccount;

-- Bài tập 2

SELECT 
	CustomerKey, 
	FirstName, 
	MiddleName, 
	LastName, 
	BirthDate, 
	MaritalStatus, 
	Gender, 
	EmailAddress
FROM DimCustomer;

SELECT *, 
	FirstName + 
	CASE WHEN MiddleName IS NOT NULL THEN ' ' + MiddleName + ' ' ElSE ' ' END 
	+ LastName AS FullName 
FROM DimCustomer;

-- Bài tập 3:

SELECT 
	OrderDate, 
	ProductKey, 
	CustomerKey, 
	SalesAmount, 
	OrderQuantity, 
	UnitPrice
FROM FactInternetSales
ORDER BY OrderDate ASC;

-- Bài tập 4

SELECT
	OrderDate, 
	ProductKey, 
	CustomerPOnumber, 
	SalesAmount, 
	OrderQuantity, 
	UnitPrice
FROM FactInternetSales
ORDER BY OrderDate ASC, ProductKey ASC, SalesAmount DESC

-- Truy vấn WHERE
-- Bài tập 1

SELECT * FROM DimCustomer 
WHERE FirstName = 'Hannah' AND MiddleName = 'E' AND LastName = 'Long'
OR FirstName = 'Mason' AND MiddleName = 'D' AND LastName = 'Roberts'
OR FirstName = 'Jennifer ' AND MiddleName = 'S' AND LastName = 'Cooper'
ORDER BY Birthdate ASC

-- Bài tập 2

SELECT 
	OrderDate,
	SalesOrderNumber, 
	ProductKey, 
	UnitPrice, 
	OrderQuantity 
FROM FactResellerSales
WHERE ResellerKey = 322;

-- Bài tập 3

SELECT * FROM FactFinance
WHERE AccountKey = 61;

-- Bài tập 4

SELECT * FROM FactCallCenter
WHERE Shift = 'AM' AND Calls >= 400
ORDER BY Calls DESC;

-- Bài tập 5

SELECT 
	Date
FROM FactCallCenter
WHERE IssuesRaised > 2 AND AverageTimePerIssue > 60;

-- Bài tập 6

SELECT 
	EnglishProductName, 
	ProductKey, 
	ListPrice,
	StandardCost
FROM DimProduct
WHERE ListPrice < 50 AND COLOR <> 'Black';

-- Bài tập 7

SELECT * FROM DimEmployee
WHERE Title = 'Sales Representative' AND SalesTerritoryKey = 10 OR SalesTerritoryKey = 1; 

-- Bài tập về ORDER BY và TOP 
-- Bài tập 1
 
SELECT TOP 9 * FROM DimProduct
WHERE Status = 'Current' 
AND ReorderPoint > 300 AND SafetyStockLevel > 400 
OR ListPrice BETWEEN 100 AND 300;

-- Bài tập về toán tử 
-- Bài tập 1

SELECT
	ProductKey,
	(ListPrice - DealerPrice) * 1.1 AS GapPrice
FROM DimProduct
WHERE Color IS NOT NULL 
ORDER BY GapPrice DESC

-- Bài tập 2

SELECT *,
	Freight / OrderQuantity AS FreightPerUnit,
	SalesAmount + TaxAmt + Freight AS TotalAmount,
	TaxAmt / (SalesAmount + TaxAmt + Freight) AS TaxPercentage,
	SalesAmount - TotalProductCost AS Profit
FROM FactInternetSales
WHERE ShipDate <= DueDate
AND OrderDate BETWEEN '2012-01-01' AND '2013-12-31';

-- Bài tập về IN 
-- Bài tập 1

SELECT * FROM DimCustomer
WHERE EnglishEducation IN ('Partial High School', 'High School', 'Graduate Degree');

-- Bài tập 2

SELECT * FROM DimCustomer
WHERE EnglishEducation IN ('Partial High School', 'High School', 'Graduate Degree')
AND EnglishOccupation = 'Professional' AND CommuteDistance = '10+ Miles'
OR EnglishOccupation = 'Clerical' AND CommuteDistance = '0-1 Miles';

-- Truy vấn lồng với IN 
-- Bài tập 1

SELECT CustomerKey FROM DimCustomer 
WHERE DimCustomer.GeographyKey IN 
	(SELECT GeographyKey FROM DimGeography
	WHERE DimGeography.SalesTerritoryKey IN 
		(SELECT SalesTerritoryKey FROM FactInternetSales
		WHERE SalesAmount > 2000
		)
	)

-- Bài tập 2

SELECT TOP 5 * FROM DimProduct 
JOIN 
	(SELECT ProductKey, SalesAmount FROM FactInternetSales
    UNION ALL
    SELECT ProductKey, SalesAmount FROM FactResellerSales) 
AS SalesInformation 
ON DimProduct.ProductKey = SalesInformation.ProductKey
WHERE DimProduct.Color = 'Red' AND DimProduct.ListPrice > 500
ORDER BY SalesAmount DESC

-- Bài tập luyện tập hàm Logic 
-- Bài tập 1

SELECT TOP 20
	FactInternetSales.ProductKey,
	FactInternetSales.SalesAmount,
	DimProduct.EnglishProductName,
	DimProduct.ListPrice,
	CASE 
		WHEN DimProduct.ListPrice > 2000 THEN 'Expensive'
		WHEN DimProduct.ListPrice BETWEEN 1000 AND 2000 THEN 'Affordable'
		ELSE 'Cheap'
	END PriceRange
FROM FactInternetSales JOIN DimProduct 
ON FactInternetSales.ProductKey = DimProduct.ProductKey
ORDER BY FactInternetSales.SalesAmount DESC

-- Bài tập 2

SELECT TOP 20
	FactInternetSales.CustomerKey,
	FactInternetSales.SalesAmount,
	CASE 
		WHEN DimCustomer.Birthdate > '1997-12-31' THEN 'Gen Z'
		WHEN DimCustomer.Birthdate BETWEEN '1981-01-01' AND '1997-12-31' THEN 'Millennial'
		ELSE 'Older'
	END AgeGeneration
FROM FactInternetSales JOIN DimCustomer 
ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
ORDER BY FactInternetSales.SalesAmount DESC