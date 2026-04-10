--ANSWER1

USE CentralCollege

SELECT 
	i.LastName, 
	i.FirstName, 
	c.CourseDescription

FROM Instructors AS i
	LEFT JOIN Courses AS c ON i.InstructorID = c.InstructorID

ORDER BY i.LastName, I.FirstName;

--ANSWER2

SELECT 
    'UNDERGRAD' AS Status, 
    FirstName, 
    LastName, 
    EnrollmentDate, 
    GraduationDate
FROM Students
WHERE GraduationDate IS NULL

UNION

SELECT 
    'GRADUATED' AS Status, 
    FirstName, 
    LastName, 
    EnrollmentDate, 
    GraduationDate
FROM Students
WHERE GraduationDate IS NOT NULL

ORDER BY EnrollmentDate;

--ANSWER3

SELECT 
	d.DepartmentName,
	c.CourseID

FROM Departments AS d
	LEFT JOIN Courses AS c ON d.DepartmentID = c.DepartmentID

WHERE c.CourseID IS NULL;

--ANSWER4

USE AdventureWorks2017

SELECT 
	p.BusinessEntityID,
	p.PersonType,
	p.LastName,
	p.FirstName

FROM Person.Person AS p
	LEFT JOIN Person.BusinessEntityContact AS b ON p.BusinessEntityID = b.PersonID
	

WHERE p.PersonType NOT IN ('IN', 'EM')
	AND b.PersonID IS NULL

ORDER BY p.LastName, p.FirstName;

--ANSWER5

SELECT 
	so.SpecialOfferID,
	so.Description AS SpecialOfferDescription,
	so.EndDate AS SpecialOfferEndDate

FROM Sales.SpecialOffer AS so
	LEFT JOIN Sales.SpecialOfferProduct AS sop ON so.SpecialOfferID = sop.SpecialOfferID

WHERE sop.SpecialOfferID IS NULL
	AND so.EndDate >= '2012-01-01'
	AND so.DiscountPct > 0;	   	  
