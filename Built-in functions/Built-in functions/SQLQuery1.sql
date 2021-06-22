--To find the ASCII Code of the capital letter ‘A’
Select ASCII('A')

Select ASCII('A') as Uppercase, ASCII('a') as Lowercase

select char(65)

--Printing uppercase alphabets using CHAR() function:
DECLARE @Number int
SET @Number = 65
WHILE(@Number <= 90)
BEGIN
  PRINT CHAR(@Number)
  SET @Number = @Number + 1
END

--Printing lowercase alphabets using CHAR() function:
DECLARE @Number1 int
SET @Number1 = 97
WHILE(@Number1 <= 122)
BEGIN
  PRINT CHAR(@Number1)
  SET @Number1 = @Number1 + 1
END

--Removing the 3 white spaces on the left-hand side of the '   Hello'
Select LTRIM('   Hello')

--Removing the 3 white spaces on the Right-hand side of the 'Hello   '
Select RTRIM('Hello   ')

--remove white spaces on either side of the given character
Select LTRIM(RTRIM('   Hello   '))

--convert the string into lower case
Select LOWER('A')

--convert the string into UPPER case
Select UPPER('a')

--reverse of a character expression
Select REVERSE('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

--to find the number of characters
Select LEN('Functions')

--left part of a character string with the specified number of characters
Select LEFT('ABCDE', 3)

--right part of a character string with the specified number of characters
Select RIGHT('ABCDE', 3)

--starting position of the specified expression in a character string
Select CHARINDEX('@','hina@aaa.com')

--substring (part of the string), from the given expression
Select SUBSTRING('info@dotnet.net',6, 10)

--CHARINDEX() and LEN() string functions 
Select SUBSTRING('info@dotnet.net',(CHARINDEX('@', 'info@dotnet.net') + 1),(LEN('info@dotnet.net') - CHARINDEX('@','info@dotnet.net')))

--Replicate Function
select REPLICATE('Rohit ',3)

--Space Function
select Space(5)
select FirstName + Space(5)+ LastName as FullName from Student

--Replace Function
select LastName, Replace(LastName,'M','Mani') as ConvertedName from Student where StdID = 103

--Date Time FUnctions
Select GETDATE()
SELECT CURRENT_TIMESTAMP
SELECT SYSDATETIME()
SELECT SYSDATETIMEOFFSET()
SELECT GETUTCDATE()
SELECT DATEPART(MONTH,'2021-06-22 14:08:14.323')
SELECT DATENAME(MONTH,'2021-06-22 14:08:14.323')
SELECT DATEADD(DAY,20,'2021-06-22 14:08:14.323')			--Add
SELECT DATEADD(DAY,-20,'2021-06-22 14:08:14.323')			--sub
select DATEDIFF(YEAR,'1997-12-25','2021-06-22')
select DATEDIFF(DAY,'1997-12-25','2021-06-22')
select DATEDIFF(YEAR,'1997-12-25','1998-01-25')				--wrong
--so use datediff in the following manner
DECLARE @DOB DATE
DECLARE @AGE INT,@MONTHS INT
SET @DOB = '12/25/1997'
SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())-
		CASE
			WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
				(MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
			THEN 1
			ELSE 0
		END
SET @MONTHS = DATEDIFF(MONTH, @DOB, GETDATE()) - 
			CASE
				WHEN DAY(@DOB)> DAY(GETDATE())
				THEN 1 ELSE 0
			END
SELECT @AGE
select @MONTHS

--Mathematical Functions

--ABS
select ABS(-10)

--CEILING
SELECT CEILING(14.3)	--RETURN 15

--FLOOR
SELECT FLOOR(14.3)		--RETURN 14

--POWER
SELECT POWER(2,3)

--SQUARE
SELECT SQUARE(9)

--RAND
SELECT RAND()	--random number
select floor(rand()*100)
select Rand(1)	--returns the same value

--OVER clause in SQL Server

SELECT  Name, Salary, Department, COUNT(*) AS NoOfEmployees, SUM(Salary) AS TotalSalary,AVG(Salary) AS AvgSalary, MIN(Salary) AS MinSalary, 
 MAX(Salary) AS MaxSalary FROM Employee1 GROUP BY Department		--error Column 'Employee1.Name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

 --solution 1
SELECT Name, Salary, Employee1.Department,  Departments.DepartmentTotals, Departments.TotalSalary,
 Departments.AvgSalary,  Departments.MinSalary, Departments.MaxSalary  FROM Employee1
 INNER JOIN ( SELECT Department, COUNT(*) AS DepartmentTotals, SUM(Salary) AS TotalSalary,
 AVG(Salary) AS AvgSalary, MIN(Salary) AS MinSalary, MAX(Salary) AS MaxSalary FROM Employee1 GROUP BY
 Department) AS Departments ON Departments.Department = Employee1.Department

 --solution 2
 SELECT Name,  Salary,  Department,
	COUNT(Department) OVER(PARTITION BY Department) AS DepartmentTotals,
	SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary,
	AVG(Salary) OVER(PARTITION BY Department) AS AvgSalary,
	MIN(Salary) OVER(PARTITION BY Department) AS MinSalary,
	MAX(Salary) OVER(PARTITION BY Department) AS MaxSalary
	FROM Employee1

--Row_Number Function in SQL Server

--ROW_NUMBER Function without PARTITION BY
SELECT Name, Department, Salary, ROW_NUMBER() OVER (ORDER BY 	Department) AS RowNumber FROM Employee1

--Row_Number Function with PARTITION BY Clause
SELECT Name, Department, Salary, ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Name) AS RowNumber
FROM Employee1

--Rank and Dense_Rank Function in SQL Server

--RANK Function without PARTITION BY
SELECT Name, Department, Salary, RANK() OVER (ORDER BY Salary DESC) AS [Rank]FROM Employee1

--RANK Function with PARTITION BY
SELECT Name, Department, Salary, RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS [Rank]
FROM Employee1

--DENSE_RANK Function without PARTITION BY 
SELECT Name, Department, Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS [Rank]FROM Employee1

--DENSE_RANK Function with PARTITION BY
SELECT Name, Department, Salary, DENSE_RANK() OVER (PARTITION BY DepartmentORDER BY Salary DESC) AS
[Dense_Rank] FROM Employee1

