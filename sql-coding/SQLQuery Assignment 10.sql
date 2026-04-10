DROP FUNCTION IF EXISTS uf_LNFN;
GO

CREATE FUNCTION uf_LNFN (@FN nvarchar(50), @LN nvarchar(50)) 
RETURNS nvarchar(102)
AS
BEGIN
	RETURN RTRIM(@LN) + ', ' + @FN
END;
GO

SELECT dbo.uf_LNFN('John','Smith')

--ANSWER3

SELECT 
	dbo.uf_LNFN(p.FirstName,p.LastName) AS EmployeeName,
	d.Name AS Department,
	e.JobTitle
FROM 
	HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL;

--ANSWER4

SELECT 
	dbo.uf_LNFN(p.FirstName,p.LastName) AS EmployeeName,
	d.Name AS Department,
	e.JobTitle,
	a.City,
	a.PostalCode,
	a.SpatialLocation
FROM 
	HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
	JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
	JOIN Person.Address a ON bea.AddressID = a.AddressID
	JOIN Person.AddressType at ON at.AddressTypeID = bea.AddressTypeID
WHERE edh.EndDate IS NULL
	AND at.Name = 'Home';

--ANSWER5
SELECT 
	dbo.uf_LNFN(p.FirstName,p.LastName) AS EmployeeName,
	d.Name AS Department,
	e.JobTitle,
	a.City,
	SpatialLocation.Lat AS Latitude,
	SpatialLocation.Long AS Longitude,
	a.PostalCode,
	a.SpatialLocation
FROM 
	HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
	JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
	JOIN Person.Address a ON bea.AddressID = a.AddressID
	JOIN Person.AddressType at ON at.AddressTypeID = bea.AddressTypeID
WHERE edh.EndDate IS NULL
	AND AT.Name = 'Home';

--ANSWER6
CREATE TABLE EmployeeHomeAddress(
    EmployeeName NVARCHAR(102),
    Department NVARCHAR(50),
    JobTitle NVARCHAR(50),
    City NVARCHAR(50),
    Latitude FLOAT,
    Longitude FLOAT,
    PostalCode NVARCHAR(20),
	SpatialLocation GEOGRAPHY);

INSERT INTO EmployeeHomeAddress(
    EmployeeName,
    Department,
    JobTitle,
    City,
    Latitude,
    Longitude,
    PostalCode,
	SpatialLocation)

SELECT 
	dbo.uf_LNFN(p.FirstName,p.LastName) AS EmployeeName,
	d.Name AS Department,
	e.JobTitle,
	a.City,
	SpatialLocation.Lat AS Latitude,
	SpatialLocation.Long AS Longitude,
	a.PostalCode,
	a.SpatialLocation
FROM 
	HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
	JOIN Person.BusinessEntityAddress bea ON e.BusinessEntityID = bea.BusinessEntityID
	JOIN Person.Address a ON bea.AddressID = a.AddressID
	JOIN Person.AddressType at ON at.AddressTypeID = bea.AddressTypeID
WHERE edh.EndDate IS NULL
	AND AT.Name = 'Home';


--Select * from EmployeeHomeAddress
--DROP table EmployeeHomeAddress;

--ANSWER7
ALTER TABLE EmployeeHomeAddress
ADD Distance float

DECLARE @g geography
SET @g = geography::STGeomFromText('POINT(-122.136626 47.642275)', 4326)
UPDATE EmployeeHomeAddress
SET Distance = SpatialLocation.STDistance(@g)/1609.344

SELECT EmployeeName, Department, City, Latitude, Longitude, Distance
FROM EmployeeHomeAddress;
