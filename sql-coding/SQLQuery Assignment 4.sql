--ANSWER1

USE CentralCollege;

SELECT 
	c.CourseNumber,
	c.CourseDescription,
	d.DepartmentName

FROM Courses AS c JOIN Departments AS d ON c.DepartmentID = d.DepartmentID

ORDER BY D.DepartmentName, C.CourseNumber;

--Answer2

SELECT 
	i.LastName, 
    i.FirstName, 
    c.CourseNumber, 
    c.CourseDescription

FROM Instructors AS i JOIN Courses AS c ON i.InstructorID = c.InstructorID

WHERE i.Status = 'P'

ORDER BY i.LastName, i.FirstName;

--Answer3

SELECT 
	d.DepartmentName,
	c.CourseDescription,
	i.FirstName,
	i.LastName

FROM Departments AS d 
	JOIN Courses AS c ON d.DepartmentID = c.DepartmentID
	JOIN Instructors AS i ON c.InstructorID = i.InstructorID

WHERE c.CourseUnits = '3'

ORDER BY d.DepartmentName, c.CourseDescription;

--Answer4

SELECT 
	d.DepartmentName,
	c.CourseDescription,
	s.LastName,
	s.FirstName
	

FROM Departments AS d
	JOIN Courses AS c ON d.DepartmentID = c.DepartmentID
	JOIN StudentCourses AS sc ON c.CourseID = sc.CourseID
	JOIN Students AS s ON sc.StudentID = s.StudentID

WHERE d.DepartmentName = 'English'

ORDER BY d.DepartmentName, c.CourseDescription;

--Answer5

SELECT 
	d_instructors.DepartmentName AS InstructorDept,
	i.LastName,
	i.FirstName,
	c.CourseDescription,
	d_courses.DepartmentName AS CourseDept

FROM Courses AS c 
	JOIN Instructors AS i ON c.InstructorID = i.InstructorID
	JOIN Departments AS d_instructors ON i.DepartmentID = d_instructors.DepartmentID
	JOIN Departments AS d_courses ON c.DepartmentID = d_courses.DepartmentID

WHERE d_instructors.DepartmentID != d_courses.DepartmentID;

--Answer6

USE AdventureWorks2017;

SELECT 
	e.BusinessEntityID,
	p.LastName,
	p.FirstName,
	e.JobTitle,
	e.BirthDate
	
FROM HumanResources.Employee AS e
	JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID

ORDER BY p.LastName, p.FirstName;

--ANSWER7

SELECT TOP 5
	CONCAT( p.LastName, ', ', p.FirstName) AS SalesPersonName,
	s.SalesYTD AS SalesYTD,
	s.CommissionPct AS Commission

FROM Sales.SalesPerson AS s
	JOIN Person.Person AS p ON s.BusinessEntityID = p.BusinessEntityID

ORDER BY SalesYTD DESC;

--ANSWER8

SELECT 
    CONCAT(p.LastName, ', ', p.FirstName) AS EmployeeName, 
    eaddr.EmailAddress AS Email

FROM HumanResources.Employee AS e
	JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory AS edh ON e.BusinessEntityID = edh.BusinessEntityID
	JOIN HumanResources.Department AS d ON edh.DepartmentID = d.DepartmentID
	JOIN Person.EmailAddress AS eaddr ON e.BusinessEntityID = eaddr.BusinessEntityID

WHERE edh.EndDate IS NULL 
	AND d.GroupName = 'Executive General and Administration'

ORDER BY p.LastName;

--ANSWER9

SELECT 
	CONCAT(p.FirstName,' ', p.LastName  ) AS EmployeeName,
	e.JobTitle,
	e.BirthDate,
	CONCAT(addr.AddressLine1, ', ', addr.City, ', ', sp.Name, ' ', addr.PostalCode) AS CSZ,
	pp.PhoneNumber,
	pnt.Name AS PhoneType


FROM HumanResources.Employee AS e
	JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS bea ON p.BusinessEntityID = bea.BusinessEntityID
	JOIN Person.Address AS addr ON bea.AddressID = addr.AddressID
	JOIN Person.StateProvince AS sp ON addr.StateProvinceID = sp.StateProvinceID
	JOIN Person.PersonPhone AS pp ON p.BusinessEntityID = pp.BusinessEntityID
	JOIN Person.PhoneNumberType AS pnt ON pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID

---ANSWER10

SELECT 
	BusinessEntityID,
	FirstName,
	MiddleName,
	LastName

FROM Person.Person

WHERE LastName LIKE 'z%'
	  AND FirstName LIKE '[e,i,n]_____';































