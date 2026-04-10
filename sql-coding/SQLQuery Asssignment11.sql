
--ANSWER1

SELECT 
	DATENAME(WEEKDAY, OrderDate) AS DayOfWeek,
	SUM(TotalDue) AS TotalRevenue,
	COUNT(*) AS NumberOfOrders,
	SUM(TotalDue) / COUNT(*) As RevenuePerOrder
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY DATENAME(WEEKDAY, OrderDate)
ORDER BY RevenuePerOrder DESC;

--ANSWER2

SELECT 
	CASE 
	WHEN EmailPromotion = 0 THEN 'Contact does not wish to receive email promotions'
	WHEN EmailPromotion = 1 THEN 'Contact does wish to receive email promotions from AdventureWorks'
	WHEN EmailPromotion = 2 THEN 'Contact does wish to receive email promotions from AdventureWorks and selected partners'
	END AS EmailPreference,
	COUNT(*) AS Count
FROM Person.Person
WHERE PersonType = 'IN'
GROUP BY ROLLUP(EmailPromotion);

--ANSWER3

SELECT 
    CASE 
	WHEN GROUPING(st.Name) = 1 THEN 'GrandTotal' 
	ELSE st.Name
	END AS Territory,
    COUNT(*) AS TotalOrders,
    FORMAT(100.0 * COUNT(CASE WHEN soh.OnlineOrderFlag = 0 THEN 1 END) / COUNT(*), 'N2') + '%' AS RetailOrders,
	FORMAT(100.0 * COUNT(CASE WHEN soh.OnlineOrderFlag = 1 THEN 1 END) / COUNT(*), 'N2') + '%' AS OnlineOrders
FROM Sales.SalesOrderHeader AS soh
	JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
GROUP BY ROLLUP(st.Name)
ORDER BY GROUPING(st.Name);

--ANSWER4

SELECT 
	CONCAT(p.LastName, ', ', p.FirstName) AS SalesPerson,
	sp.CommissionPct,
	sp.Bonus,
	RANK() OVER (ORDER BY sp.CommissionPct DESC, sp.Bonus DESC) AS Rank
FROM Sales.SalesPerson sp
	JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID;

--ANSWER 5

WITH EmployeeQuartiles AS (
     SELECT 
        BusinessEntityID,
        DATEDIFF(MONTH, HireDate, '2017-01-01') AS MonthsEmployed,
        Gender,
        NTILE(4) OVER (ORDER BY DATEDIFF(MONTH, HireDate, '2017-01-01')) AS Quartile
     FROM HumanResources.Employee)

SELECT 
    Quartile,
    COUNT(*) AS Employees,
    FORMAT(100.0 * COUNT(CASE WHEN Gender = 'M' THEN 1 END) / COUNT(*), 'N2') + '%' AS PercentMale,
    FORMAT(100.0 * COUNT(CASE WHEN Gender = 'F' THEN 1 END) / COUNT(*), 'N2') + '%' AS PercentFemale,
    AVG(MonthsEmployed) AS AvgMonthsEmployed
FROM EmployeeQuartiles
GROUP BY Quartile;
