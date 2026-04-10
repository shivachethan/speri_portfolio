USE CentralCollege

--ANSWER1

SELECT DISTINCT LastName, FirstName
FROM Instructors i
	JOIN Courses c ON i.InstructorID = c.InstructorID
ORDER BY LastName, FirstName

SELECT DISTINCT LastName, FirstName
FROM Instructors
WHERE InstructorID IN
	(SELECT DISTINCT InstructorID
	 FROM Courses)
ORDER BY LastName, FirstName;

--ANSWER2

SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary > 
	(SELECT AVG(AnnualSalary)
	 FROM Instructors)
ORDER BY AnnualSalary DESC;

--ANSWER3

SELECT LastName, FirstName
FROM Instructors i
WHERE NOT EXISTS 
	(SELECT *
	 FROM Courses c
	 WHERE i.InstructorID = c.InstructorID)
ORDER BY i.LastName, i.FirstName;

--ANSWER4

SELECT s.LastName, s.FirstName, COUNT(sc.CourseID) AS NumberOfCourses
FROM Students s
	JOIN StudentCourses sc ON s.StudentID = sc.StudentID
WHERE s.StudentID IN
	(SELECT StudentID
	 FROM StudentCourses
	 GROUP BY StudentID
	 HAVING COUNT(CourseID) > 1)
GROUP BY s.LastName, s.FirstName
ORDER BY s.LastName, s.FirstName;

--ANSWER5

SELECT LastName, FirstName, AnnualSalary
FROM Instructors
WHERE AnnualSalary IN
	(SELECT AnnualSalary
	 FROM Instructors
	 GROUP BY AnnualSalary
	 HAVING COUNT(AnnualSalary) = 1 )
ORDER BY LastName, FirstName;

--ANSWER6

WITH RecentEnrollments AS 
    (SELECT sc.CourseID, MAX(s.EnrollmentDate) AS MostRecentEnrollmentDate
    FROM StudentCourses sc
		JOIN Students s ON sc.StudentID = s.StudentID
    GROUP BY sc.CourseID)

SELECT c.CourseDescription, s.LastName, s.FirstName, s.EnrollmentDate
FROM RecentEnrollments re
	JOIN StudentCourses sc ON re.CourseID = sc.CourseID
	JOIN Students s ON sc.StudentID = s.StudentID 
	JOIN Courses c ON re.CourseID = c.CourseID
WHERE s.EnrollmentDate = re.MostRecentEnrollmentDate;

--ANSWER7

WITH FullTimeStudents AS
	(SELECT s.StudentID, SUM(c.CourseUnits) AS TotalCourseUnits
	 FROM Students s 
	 JOIN StudentCourses sc ON s.StudentID = sc.StudentID
	 JOIN Courses c ON sc.CourseID = c.CourseID
	GROUP BY s.StudentID
	HAVING SUM(c.CourseUnits) > 9 )

SELECT fts.StudentID, fts.TotalCourseUnits, t.FullTimeCost+(t.PerUnitCost*fts.TotalCourseUnits) AS Tuition
FROM FullTimeStudents fts
	CROSS JOIN Tuition t;

--ANSWER8

USE AdventureWorks2017

SELECT d.Name AS DepartmentName, MAX(ph.Rate) AS LargestPayRate
FROM HumanResources.Department d
	JOIN HumanResources.EmployeeDepartmentHistory dh ON d.DepartmentID = dh.DepartmentID
	JOIN HumanResources.EmployeePayHistory ph ON dh.BusinessEntityID = ph.BusinessEntityID
WHERE dh.EndDate IS NULL
GROUP BY d.Name
ORDER BY LargestPayRate DESC;


