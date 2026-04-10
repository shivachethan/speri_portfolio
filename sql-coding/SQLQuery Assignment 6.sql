--ANSWER1

USE CentralCollege

SELECT 
	COUNT(*) AS NumberOfInstructors,
	AVG(AnnualSalary) AS AvgAnnualSalary

FROM Instructors

WHERE Status = 'F';

--ANSWER2

SELECT 
	d.DepartmentName,
	COUNT (i.InstructorID) AS NumberOfInstructors,
	MAX(i.AnnualSalary) AS HighestSalary 

FROM Departments d 
	 JOIN Instructors i ON d.DepartmentID = i.DepartmentID

GROUP BY d.DepartmentName

ORDER BY NumberOfInstructors DESC;

--ANSWER3

SELECT 
	CONCAT (i.FirstName, ' ',i.LastName) AS InstructorName,
	COUNT(c.CourseID) AS NumberOfCourses,
	SUM(c.CourseUnits) AS TotalUnits

FROM Instructors i 
	JOIN Courses c ON i.InstructorID = c.InstructorID
	
GROUP BY CONCAT (i.FirstName, ' ',i.LastName)

ORDER BY TotalUnits DESC;

--ANSWER4

SELECT 
	d.DepartmentName,
	c.CourseDescription,
	COUNT(sc.StudentID) AS NumberOfStudents

FROM Departments d
	JOIN Courses c ON d.DepartmentID = c.DepartmentID
	JOIN StudentCourses sc ON c.CourseID = sc.CourseID

GROUP BY d.DepartmentName, c.CourseDescription

ORDER BY d.DepartmentName, NumberOfStudents;

--ANSWER5

SELECT 
	s.StudentID,
	SUM(c.CourseUnits) AS TotalUnits

FROM  Students s
	JOIN StudentCourses sc ON s.StudentID = sc.StudentID
	JOIN Courses c ON sc.CourseID = c.CourseID

GROUP BY s.StudentID

ORDER BY TotalUnits DESC;

--ANSWER6

SELECT 
	s.StudentID,
	SUM(c.CourseUnits) AS TotalUnits

FROM  Students s
	JOIN StudentCourses sc ON s.StudentID = sc.StudentID
	JOIN Courses c ON sc.CourseID = c.CourseID

WHERE s.GraduationDate IS NULL

GROUP BY s.StudentID

HAVING SUM(c.CourseUnits) > 9 

ORDER BY TotalUnits DESC;

--ANSWER7

SELECT 
	CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName,
	COUNT(c.CourseID) AS TotalCourses

FROM Instructors i 
	JOIN Courses c ON i.InstructorID = c.InstructorID

WHERE i.Status = 'P'

GROUP BY ROLLUP(CONCAT(i.FirstName, ' ', i.LastName));

--ANSWER8

USE AdventureWorks2017

SELECT 
	d.Name AS Department,
	COUNT(*) AS NumberEmployees

FROM HumanResources.EmployeeDepartmentHistory AS edh
	JOIN HumanResources.Department AS d ON edh.DepartmentID = d.DepartmentID

WHERE edh.EndDate IS NULL

GROUP BY ROLLUP(d.Name)

ORDER BY d.Name;