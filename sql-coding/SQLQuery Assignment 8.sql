USE CentralCollege

--ANSWER1

INSERT INTO Departments
VALUES ('History');

--ANSWER2

INSERT INTO Instructors
VALUES ('Benedict','Susan','P',0,GETDATE(),34000.00,9),
	   ('Adams',NULL,'F',1,GETDATE(),66000.00,9);

--ANSWER3

UPDATE Instructors
SET AnnualSalary = 350000
WHERE InstructorID = 17;

--ANSWER4

DELETE Instructors
WHERE InstructorID = 18;

--ANSWER5

DELETE Instructors
WHERE DepartmentID = 9

DELETE Departments
WHERE DepartmentID = 9;

--ANSWER6

UPDATE Instructors
SET AnnualSalary = AnnualSalary*1.05
FROM Instructors i
	 JOIN Departments d ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Education';

--ANSWER7

DELETE Instructors
WHERE InstructorID NOT IN 
	(SELECT InstructorID
	 FROM Courses);

--ANSWER8

INSERT INTO GradStudents
SELECT *
FROM Students
WHERE GraduationDate IS NOT NULL;

--ANSWER9
SELECT 
    AnnualSalary / 12 AS MonthlySalary,
    CAST(AnnualSalary / 12 AS DECIMAL(10,1)) AS MonthlySalary1Dec,
    CONVERT(INT, AnnualSalary / 12) AS MonthlySalaryINT1,
    CAST(AnnualSalary / 12 AS INT) AS MonthlySalaryINT2
FROM Instructors;

--ANSWER10
/*EnrollmentDate
As is from the Students table
EnrollmentDateOnly
Column that uses the CAST function to return the EnrollmentDate with its date only (year, month, and day) Do not make this more complicated than it needs to be
EnrollmentTimeOnly
Column that uses the CAST function to return the EnrollmentDate with its full time only (hour,minutes, seconds, and milliseconds) Again, not complicated.
EnrollmentYearMonth
Column that uses the CAST function to return the EnrollmentDate with just the year and month. Play with VARCHAR to accomplish this.
EnrollmentMM_DD_YYYY
Column that uses the CONVERT function to return the EnrollmentDate in the format MM/DD/YYYY. In other words, use 2-digit months and days and a 4-digit year, and separate each date component with slashes.
Enrollment12AM_PM
Column that uses the CONVERT function to return the EnrollmentDate with the date, and the hours and minutes on a 12-hour clock with an am/pm indicator
EnrollmentTime24
Column that uses the CONVERT function to return the EnrollmentDate with just the time in a 24-hour format, including milliseconds.
EnrollmentMonthDay
Column that uses the CONVERT function to return the EnrollmentDate with just the month and day such as Mar 05.*/

SELECT 
	EnrollmentDate,
	CAST(EnrollmentDate AS date) AS EnrollmentDateOnly,
	CAST(EnrollmentDate AS time) AS EnrollmentTimeOnly,	
	CAST(EnrollmentDate AS varchar(7)) AS EnrollmentYearMonth,
	CONVERT(varchar,EnrollmentDate,101) AS EnrollmentMM_DD_YYYY,
	CONVERT(varchar,EnrollmentDate,100) AS Enrollment12AM_PM,
	CONVERT(varchar,EnrollmentDate,108) AS EnrollmentTime24,
	CONVERT(varchar(6),EnrollmentDate,100) AS EnrollmentMonthDay
FROM Students;