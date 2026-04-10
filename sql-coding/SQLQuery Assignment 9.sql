--SSMS v20.2.30.0

--ANSWER1
/*Write a SELECT statement that returns these columns from the Instructors table:
AnnualSalary
MonthlySalary
the result of dividing the AnnualSalary column by 12
MonthlySalaryRounded
Calculation of the monthly salary and then use the ROUND function to round the result to 2 decimal places*/

SELECT 
	AnnualSalary,
	AnnualSalary/12 AS MonthlySalary,
	ROUND(AnnualSalary/12, 2) AS MonthlySlaryRounded
FROM Instructors;

--ANSWEER2
/*Write a SELECT statement that returns these columns from the Students table:
EnrollmentDate
DateYear
the four-digit year that’s stored in the EnrollmentDate column
DateDay
the day of the month that’s stored in the EnrollmentDate column
EnrollmentDate4
add four years to the EnrollmentDate column and return only the year. Do NOT use the plus sign to add.*/

SELECT 
	EnrollmentDate,
	YEAR(EnrollmentDate) AS DateYear,
	DAY(EnrollmentDate) AS DateDay,
	DATEPART(YEAR, DATEADD(Year, 4, EnrollmentDate)) AS EnrollmentDate4

FROM Students;

--ANSWER3
/*Write a SELECT statement that returns these columns for each course:
DepartmentName
of the course
CourseNumber
InstructorName
LastName and FirstName of the instructor concatenated as “LastName, FirstName” such that those without a firstname or lastname are still included.
CourseReference
A column that includes the first three characters from the DepartmentName column in uppercase, 
concatenated with the CourseNumber column, then either the first character of the FirstName column 
or an empty string if the column’s value is null, and finally the LastName column. 
(Hint: you will need to cast the CourseNumber column to a character data type.)
As an example, this course would look like MSB5223TWilliams.*/

SELECT 
	d.DepartmentName,
	c.CourseNumber,
	CONCAT(i.LastName, ', ',i.FirstName) AS InstructorName,
	CONCAT(UPPER(LEFT(d.DepartmentName, 3)), 
		    CAST(c.CourseNumber AS varchar),
			COALESCE(LEFT(i.FirstName, 1), ' '),
			i.LastName)  AS CourseReference
FROM Courses c
	JOIN Departments d ON c.DepartmentID = d.DepartmentID
	JOIN Instructors i ON c.InstructorID= i.InstructorID;

--ANSWER4
/*Write a SELECT statement that returns these columns from the Students table:
StudentName
LastName and FirstName of the student concatenated as “LastName, FirstName” such that those without a firstname or lastname are still included
EnrollmentDate
GraduationDate
MonthsToGraduate
The number of months between the EnrollmentDate and GraduationDate columns
Return one row for each student who has graduated.*/

SELECT 
	CONCAT(s.LastName, ', ', s.FirstName) AS StudentName,
	s.EnrollmentDate,
	s.GraduationDate,
	DATEDIFF(MONTH,EnrollmentDate,GraduationDate) AS MonthsToGraduate
FROM Students s
WHERE GraduationDate IS NOT NULL;

--ANSWER5
/*Write a SELECT statement that answers this question:
What is the total number of courses taught by parttime instructors? Return these columns:
InstructorName
The instructor last name and first name from the Instructors table in this format: “Doe, John”.
When the instructor’s first name is NULL, use FNU as the first name (First Name Unknown). 
Use the ISNULL() function to accomplish this.
TotalCourses
The total number of courses taught for each instructor.
Use the ROLLUP operator to include a row that gives the grand total. 
The grand total row should have the InstructorName column (or description) as Grand Total. 
Use the CASE statement to accomplish this.*/

SELECT 
	CASE 
		WHEN GROUPING(CONCAT(i.LastName, ', ', ISNULL(i.FirstName, 'FNU'))) = 1 THEN 'GrandTotal'
		ELSE CONCAT(i.LastName, ', ', ISNULL(i.FirstName, 'FNU')) 
	END AS InstructorName,
	COUNT(c.CourseID) AS TotalCourses	
FROM Courses c
	JOIN Instructors i ON c.InstructorID = i.InstructorID
WHERE i.Status = 'F'
GROUP BY ROLLUP(CONCAT(i.LastName, ', ', ISNULL(i.FirstName, 'FNU')));

--ANSWER6
/*Write a CTE with a SELECT statement that returns one row for each student who has at least one course. 
This query should return these columns:
StudentID
TotalCourseUnits The sum of the course units for that student
Write a SELECT statement that uses this CTE to return these columns for each student:
StudentID
TotalCourseUnits
StudentStatus Whether the student is fulltime or parttime. 
To determine whether a student is fulltime, use the IIF function to test if the sum of course units is greater than 9.
TotalTuition The student’s total tuition. 
To calculate the tuition, use the IIF function to determine whether a student is fulltime or parttime. 
Then, multiply the sum of course units by the PerUnitCost column in the Tuition table 
and add that to either the FullTimeCost or PartTimeCost column in the Tuition table. 
To do that, use a cross join to join the CTE and the Tuition tables. 
This makes the columns from the Tuition table available to the SELECT statement.*/

WITH StudentCourseUnits AS 
(SELECT s.StudentID, SUM(c.CourseUnits) AS TotalCourseUnits
 FROM Students s
	JOIN StudentCourses sc ON s.StudentID = sc.StudentID
	JOIN Courses c ON sc.CourseID = c.CourseID
 GROUP BY s.StudentID)

SELECT 
	scu.StudentID,
	scu.TotalCourseUnits,
	IIF(scu.TotalCourseUnits>9, 'Full Time','Part Time') AS StudentStatus,
	IIF(scu.TotalCourseUnits>9,
		(TotalCourseUnits*t.PerUnitCost)+t.FullTimeCost,
		(TotalCourseUnits*t.PerUnitCost)+t.PartTimeCost ) AS TotalTuition
FROM  StudentCourseUnits scu CROSS JOIN Tuition t;

--ANSWER7
/*Write a SELECT query to show the number of sales for each InvoiceDate along with a running total 
and a 7-day lag.
To do this, you will use the Sales.SalesOrderHeader table and write a CTE that will return these columns:
OrderDate
DayOfWeek
Use the appropriate function to return the numeric day of the week and then use a CASE statement 
to display it as the name of the day, i.e. Sunday, Monday, etc.
TotalSales the total number of sales for that day.
Then, write a SELECT statement, using the CTE, that returns these columns:
OrderDate
DayWeek
TotalSales
RunningTotal  of the TotalSales
7DayLag       based on the OrderDate with a 7-day lag.
Only return orders for 2014.
The 7-day lag of the first 7 rows will be NULL. Think about it.*/

WITH DatewiseSales AS (
	SELECT 
	CAST(OrderDate AS date) AS OrderDate,
	CASE
		WHEN DATEPART(weekday, OrderDate) = 1 THEN 'Sunday'
		WHEN DATEPART(weekday, OrderDate) = 2 THEN 'Monday'
		WHEN DATEPART(weekday, OrderDate) = 3 THEN 'Tuesday'
		WHEN DATEPART(weekday, OrderDate) = 4 THEN 'Wednesday'
		WHEN DATEPART(weekday, OrderDate) = 5 THEN 'Thursday'
		WHEN DATEPART(weekday, OrderDate) = 6 THEN 'Friday'
		ELSE 'Saturday'
	END AS DayOfWeek,
	COUNT(SalesOrderID) AS TotalSales
  FROM Sales.SalesOrderHeader
  GROUP BY OrderDate )

SELECT 
	OrderDate, 
	DayOfWeek, 
	TotalSales,
	SUM(TotalSales) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal,
	LAG(TotalSales, 7) OVER (ORDER BY OrderDate) AS '7DayLag'
FROM DatewiseSales
WHERE YEAR(OrderDate) = 2014;

--ANSWER8
/*Write a SELECT query that will return these columns from Sales.vSalesPerson:
LastName
TerritoryName
CountryRegionName
Do not include rows where the TerritoryName is NULL.
Sort the results by the TerritoryName when the CountryRegionName is the United States and 
by the CountryRegionName when it is not. (Hint: Use a CASE statement in the ORDER BY clause.)*/

SELECT
	LastName,
	TerritoryName,
	CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY 
	CASE 
		WHEN CountryRegionName = 'United States' THEN TerritoryName
		ELSE CountryRegionName 
	END;
