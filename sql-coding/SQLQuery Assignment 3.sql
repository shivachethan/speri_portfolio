USE CentralCollege

SELECT *
FROM Courses;

SELECT CourseNumber, CourseDescription, CourseUnits
FROM Courses
ORDER BY CourseNumber;
	--Ascending is default

SELECT 
	CONCAT (LastName, ', ', FirstName) AS FullName
FROM Students
WHERE LastName LIKE '[a-m]%'
ORDER BY LastName;

SELECT 
	Lastname,
	Firstname,
	CONCAT (LastName, ', ', FirstName) AS Instructor, 
	AnnualSalary

FROM Instructors

WHERE
	CONCAT (LastName, ', ', FirstName) IS NOT NULL
	AND AnnualSalary >= 60000

ORDER BY AnnualSalary DESC;

SELECT 
	Lastname,
	Firstname,
	CONCAT (LastName, ', ', FirstName) AS Instructor,
	HireDate

FROM Instructors

WHERE CONCAT (LastName, ', ', FirstName) IS NOT NULL
	AND HireDate BETWEEN '2019-01-01' AND '2019-12-31'

ORDER BY HireDate;

SELECT
	Firstname,
	Lastname,
	CONCAT (LastName, ', ', FirstName) AS Student,
	EnrollmentDate,
	GETDATE() AS CurrentDate,
	DATEDIFF(MONTH, EnrollmentDate, GETDATE()) AS MonthsAttended


FROM Students

WHERE CONCAT (LastName, ', ', FirstName) IS NOT NULL

ORDER BY MonthsAttended;

SELECT TOP (20) PERCENT
	Firstname,
	Lastname,
	CONCAT (LastName, ', ', FirstName) AS Instructor,
	AnnualSalary

FROM Instructors

ORDER BY AnnualSalary DESC


SELECT 
	Lastname,
	FirstName,
	CONCAT( LastName, ', ', FirstName) AS Student
	
FROM Students

WHERE LastName LIKE 'G%' AND LastName LIKE '%A%'

ORDER BY LastName

SELECT
	LastName,
	FirstName,
	CONCAT (LastName, ', ', FirstName) AS Student,
	EnrollmentDate,
	GraduationDate

FROM Students

WHERE EnrollmentDate > '2019-12-01'
	AND GraduationDate IS NULL;

SELECT 
    100 AS Price,
    0.07 AS TaxRate,
    100 * 0.07 AS TaxAmount,
    100 + (100 * 0.07) AS Total;



