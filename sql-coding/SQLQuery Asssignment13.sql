--ANSWER1

SELECT 
	YEAR(OrderDate) AS Year,
	DATENAME(MONTH, OrderDate) AS Month,
	SUM(sod.OrderQty) AS TotalQty,
	SUM(sod.OrderQty*sod.UnitPrice*(1-sod.UnitPriceDiscount)) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON p.ProductID = sod.ProductID
	JOIN Production.ProductSubCategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE 
	sc.Name = 'Road Bikes'
	AND YEAR(OrderDate) IN (2013,2014) 
	AND MONTH(OrderDate) = 05
GROUP BY YEAR(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY TotalQty DESC;

--ANSWER2

SELECT 
	p.Name AS ProductName,
	SUM(i.Quantity) AS QtyOnHand
FROM Production.Product p
	JOIN Production.ProductInventory i on i.ProductID = p.ProductID
WHERE ProductNumber = 'BK-R93R-48'
GROUP BY p.Name;


--ANSWER3

WITH TotalQtyOnHand AS (
    SELECT ProductID, SUM(Quantity) AS QtyOnHand
    FROM Production.ProductInventory
    GROUP BY ProductID
),
TotalQuantityOnOrder AS (
    SELECT ProductID, SUM(OrderQty) AS QtyOnOrder
    FROM Purchasing.PurchaseOrderDetail
    WHERE DueDate > '2014-06-05' AND DueDate <= '2014-12-24'
    GROUP BY ProductID
)

SELECT 
	pp.ProductID,
    pp.Name AS ComponentName,
    tqh.QtyOnHand,
    tqo.QtyOnOrder
FROM 
    Production.Product p
    JOIN Production.BillOfMaterials bom ON p.ProductID = bom.ProductAssemblyID
    JOIN Production.Product pp ON bom.ComponentID = pp.ProductID 
    LEFT JOIN TotalQtyOnHand tqh ON pp.ProductID = tqh.ProductID
    LEFT JOIN TotalQuantityOnOrder tqo ON pp.ProductID = tqo.ProductID
WHERE p.ProductNumber = 'BK-R93R-48'
Group by pp.ProductID,pp.Name,QtyOnHand,QtyOnOrder
ORDER BY pp.Name;

--Answer5

SELECT 
	p.Name AS ProductName,
    SUM(sod.OrderQty) AS Total#Sold,
    SUM(sod.OrderQty*sod.UnitPrice*(1-sod.UnitPriceDiscount)) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE 
	p.ProductNumber = 'BK-R64Y-40'
	AND YEAR(soh.OrderDate) = 2013
	AND MONTH(OrderDate) IN (11,12)
GROUP BY p.Name;

--ANSWER6

--Analysing monthly sales of BK-R93R-48 in Nov/Dec 2013
SELECT 
	p.Name AS ProductName,
    SUM(sod.OrderQty) AS Total#Sold,
    SUM(sod.OrderQty*sod.UnitPrice*(1-sod.UnitPriceDiscount)) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE 
	p.ProductNumber = 'BK-R93R-48'
	AND YEAR(soh.OrderDate) = 2013
	AND MONTH(OrderDate) IN (11,12)
GROUP BY p.Name;

--Analysing monthly sales of BK-R93R-48 in Nov/Dec 2012
SELECT 
	p.Name AS ProductName,
    SUM(sod.OrderQty) AS Total#Sold,
    SUM(sod.OrderQty*sod.UnitPrice*(1-sod.UnitPriceDiscount)) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE 
	p.ProductNumber = 'BK-R93R-48'
	AND YEAR(soh.OrderDate) = 2012
	AND MONTH(OrderDate) IN (11,12)
GROUP BY p.Name;

--Answer7

SELECT TOP 3
	p.Name AS ProductName,
	SUM(OrderQty) AS QtySold
	
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
	JOIN Production.ProductSubcategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
	JOIN Production.ProductCategory pc ON pc.ProductCategoryID = sc.ProductCategoryID
WHERE pc.Name = 'bikes'
	AND YEAR(OrderDate) = 2014
	AND MONTH(OrderDate) IN (1,2,3,4,5)
GROUP BY p.Name
ORDER BY QtySold DESC;

--ANSWER8

SELECT TOP 3
	p.Name AS ProductName,
	SUM(OrderQty*UnitPrice*(1-UnitPriceDiscount)) AS Revenue
	
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
	JOIN Production.ProductSubcategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
	JOIN Production.ProductCategory pc ON pc.ProductCategoryID = sc.ProductCategoryID
WHERE pc.Name = 'bikes'
	AND YEAR(OrderDate) = 2014
	AND MONTH(OrderDate) IN (1,2,3,4,5)
GROUP BY p.Name
ORDER BY Revenue DESC;

--ANSWER10

SELECT 
    p.Name AS ProductName,
    SUM(OrderQty*UnitPrice*(1-UnitPriceDiscount)) AS Revenue,
    SUM(OrderQty * StandardCost) AS TotalCost,
	SUM(OrderQty*UnitPrice*(1-UnitPriceDiscount)- OrderQty*StandardCost) AS Profit,
    CAST(100.0 * (SUM(OrderQty * UnitPrice * (1 - UnitPriceDiscount)) - SUM(OrderQty * StandardCost))/
		SUM(OrderQty * UnitPrice * (1 - UnitPriceDiscount)) AS DECIMAL(10,4)) AS 'ProfitMargin%'
		
FROM Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
	JOIN Production.Product p ON sod.ProductID = p.ProductID
	JOIN Production.ProductSubcategory sc ON sc.ProductSubcategoryID = p.ProductSubcategoryID
	JOIN Production.ProductCategory pc ON pc.ProductCategoryID = sc.ProductCategoryID
WHERE 
    sc.Name = 'Road Bikes'
    AND YEAR(OrderDate) = 2014
	AND MONTH(OrderDate) IN (1,2,3,4,5)
GROUP BY p.Name
ORDER BY 'ProfitMargin%' DESC;
