CREATE FUNCTION uf_LNFN (@FN nvarchar(50), @LN nvarchar(50)) RETURNS nvarchar(102)
BEGIN
RETURN RTRIM(@LN) + ', ' + @FN
END

SELECT dbo.uf_LNFN('John','Smith')

--ANSWER3

SELECT 
    dbo.uf_LNFN(P.FirstName, p.LastName) AS EmployeeName,
    d.Name AS Department,
    e.JobTitle AS JobTitle
FROM 
    HumanResources.Employee e
	JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
WHERE 
    edh.EndDate IS NULL;

--ANSWER4

SELECT 
    dbo.uf_LNFN(p.FirstName, p.LastName) AS EmployeeName,
    d.Name AS Department,
    e.JobTitle AS JobTitle,
    a.City,
    a.PostalCode,
    a.SpatialLocation
FROM 
    HumanResources.Employee e
    JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
    JOIN Person.Address a ON bea.AddressID = a.AddressID
    JOIN Person.AddressType at ON bea.AddressTypeID = at.AddressTypeID
WHERE 
    edh.EndDate IS NULL
    AND at.Name = 'Home';

