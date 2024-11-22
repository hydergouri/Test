drop database studentDB

create database studentDB

use studentDB

use master


create table Student_Details
(Roll_no int Primary Key,
Name varchar(20),
Age int,
Course varchar(20)
);

select * from Student_Details

select roll_no, Name from Student_Details

insert into Student_Details
values(3,'A',25,'B.Tech'),(4,'D',26,'PhD'),(2,'C',26,'M.Tech')


insert into Student_Details(Roll_no,Course)
values(5,'B.Pharm')

delete from Student_Details
where Roll_no=5

Truncate table Student_Details

drop table Student_Details

select * from Student_Details


select distinct Age from Student_Details

select distinct Course from Student_Details

select * from Student_Details

Select Roll_no,Name from Student_Details

select count(id) as count_of_students from Student_Details

select count(distinct(Course)) Count_of_course from Student_Details

--23/10/24

select count(gender) from Student_Details
where gender='M'

--order by clause
select * from Student_Details
order by id desc

select * from Student_Details
order by Course asc

--TOP statement
select TOP 3 * from Student_Details

-- find details of student with highest age
select top 1 * from Student_Details
order by age desc

--AND OR NOT  Opeators
select * from Student_Details
where course='BTech' and gender='M'

select * from Student_Details

select * from Student_Details
where course='BTech' or gender='M'

select * from Student_Details
where not course='BTech'

-- Null Values 

insert into Student_Details(Name,Age)
values('XYZ',25)

select count(*) from Student_Details
where id is null

select count(*) from Student_Details
where Gender is null

select * from Student_Details
where Course is null

select count(*) from Student_Details
where id is not null

--UPDATE Statement

Update Student_Details
set id =7, Course='PhD', gender='M'
where age=25 and Name = 'XYZ'

Update Student_Details
set Name = 'poiu'
where Name = 'abcd'

delete from Student_Details
where id = 6

--MIN MAX

select Min(age) min_age from Student_Details

select * from Student_Details 
where Age = (select Min(age) from Student_Details)

select Max(age) as Max_age from Student_Details

--AVG SUM
select Avg(age) from Student_Details

select Sum(id) from Student_Details

--24/10/24

--LIKE Operator
-- used to search for specific pattern in a column
--Wildcard % - represent multiple characters
-- ( _ ) - represent single characters

select * from Student_Details 

SELECT * FROM Student_Details
WHERE Name LIKE 'a%';

SELECT * FROM Student_Details
WHERE Name LIKE '%i';

SELECT * FROM Student_Details
WHERE Name LIKE '_a%';

SELECT * FROM Student_Details
WHERE Name LIKE '__x%';

SELECT * FROM Student_Details
WHERE Name LIKE 'N_T%h';

SELECT * FROM Student_Details
WHERE Name LIKE '%a%';

SELECT * FROM Student_Details
WHERE Name LIKE 'a%' OR Name LIKE 's%';


SELECT * FROM Student_Details  --- Names starting with a or s or m
WHERE Name LIKE '[a s m w]%'; 

SELECT * FROM Student_Details  ---gives a range from a to z - Names starting with a to z
WHERE Name LIKE '[a-p]%'; 

--IN Operator
--The IN operator allows you to specify multiple values in a WHERE clause.

SELECT * FROM Student_Details
WHERE Course in ('Bca','PhD');

SELECT * FROM Student_Details
WHERE Course not in ('Bca','PhD');

select * from Student_Details 
where name in
(SELECT name FROM Student_Details
WHERE Name LIKE 'a%' OR Name LIKE 's%');

--The SQL BETWEEN Operator
--The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.

select * from student_details
where id between 2 and 5

select * from student_details
where id not between 2 and 4

-- Procedure---

use SQLTest

--A Stored Procedure in SQL is a precompiled set of SQL statements that can be executed 
--as a single unit. It allows you to encapsulate repetitive or complex tasks into a 
--single callable routine.

create proc spEmpDept_1_3
as
begin
	select * from employee
	where DeptID in (1,3)
	order by id desc
End

spEmpDept_1_3

exec spEmpDept_1_3;

sp_helptext spEmpDept_1_3 -- gives code of stored procedure

select * from employee

alter proc spEmpSalaryGreater60000
as 
begin 
select * from employee
where Salary > 60000
order by Salary asc
End;

exec spEmpSalaryGreater60000;


--modify Procedure

alter proc spEmpDept_1_3
as
begin
	select * from employee
	where DeptID in (1,3)
	order by id desc
End


--delete Procedure

drop proc spEmpSalaryGreater60000

-- procedure with parameters--

create proc spEmp_id(@id as int)
as
begin
	select * from employee
	where id = @id 
end

spEmp_id 7

--insert emp using proc

create PROCEDURE sp_AddEmployee
    --@EmpID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Salary DECIMAL(10, 2),
	@Dept_ID INT
AS
BEGIN
    INSERT INTO Employee (First_Name, Last_Name, Salary,DeptID)
    VALUES (@FirstName, @LastName, @Salary,@Dept_ID);
END;

sp_AddEmployee 'Jonny','Depp',37000,5

EXEC sp_AddEmployee 
    --@EmpID = 1, 
    @FirstName = 'Michael', 
    @LastName = 'Phleps', 
    @Salary = 10000,
	@Dept_ID = 1;

select * from employee
select * from Dept


-- Joins --

-- 1. INNER JOIN:
--An INNER JOIN returns only the rows where there is a match in both tables. 
--If no match is found, the rows are excluded from the result

select e.*,d.* from employee e
inner join dept d
on e.DeptID=d.DeptID

-- 2. LEFT JOIN (or LEFT OUTER JOIN):
--A LEFT JOIN returns all rows from the left table (Employees) and the matching rows from the right table
--(Departments). If there is no match, the result is NULL for columns from the right table.

select e.*,d.* from employee e
left join dept d
on e.DeptID=d.DeptID
order by id

--3. RIGHT JOIN (or RIGHT OUTER JOIN):
--A RIGHT JOIN returns all rows from the right table (Departments) and the matching rows from the left 
--table (Employees). If there is no match, the result is NULL for columns from the left table.

insert into Dept
values(5,'S')

select e.*,d.* from employee e
right join dept d
on e.DeptID=d.DeptID
order by id

--4. FULL JOIN (or FULL OUTER JOIN):
--A FULL JOIN returns rows when there is a match in either table. If there is no match, the result is NULL 
--from the table that does not have a matching row.

select e.*,d.* from employee e
full join dept d
on e.DeptID=d.DeptID
order by id

-- 5. CROSS JOIN:
--A CROSS JOIN returns the Cartesian product of both tables, meaning it combines every row from the first 
--table with every row from the second table. No ON clause is required.

select e.*,d.* from employee e
cross join dept d
on e.DeptID=d.DeptID
order by id


--- Views ---

--A View in SQL is a virtual table that is based on the result set of a SQL query. 
--It does not store data itself but displays data from one or more underlying tables. 
--Views are used to simplify complex queries, enhance security by restricting access 
--to specific data, and present data in a specific format.

select * from employee

create view vw_EmpDeptID3
as
select e.id,e.First_Name,e.Last_Name,e.Salary,d.DeptID,d.DeptName from employee e
inner join Dept d on e.DeptID=d.DeptID
where e.DeptID=3

select * from vw_EmpDeptID3

drop view vw_EmpDeptID3

--- TRIGGER----


create trigger stSECONDTrigger
on Database
for Create_Table
as
begin
	print 'New Table Created'
end


create table testtriggger (id int)


ALTER trigger stSECONDTrigger
on Database
for Create_Table,Alter_Table,Drop_Table
as
begin
	print 'New Trigger created for Create_Table,Alter_Table,Drop_Table'
end

alter table testtriggger
add age int

drop table testtriggger

ALTER trigger stSECONDTrigger
on Database
for Create_Table,Alter_Table,Drop_Table
as
begin
	Rollback
	print 'New Trigger created for Create_Table,Alter_Table,Drop_Table'
end

enable trigger stFristTrigger on database

create table testtriggger11 (id int)

create trigger stRename
on Database
for Rename
as
begin
	print 'You renamed something'
end

sp_rename 'Test_Trig' , 'Test_Trigger'

sp_rename 'Test_Trig.id' , 'Age', 'column'

--server scoped trigger---

create trigger stRename
on all server
for Rename
as
begin
	rollback
	print 'You cant Rename'
end

------------ DML TRIGGERS -----------------

SELECT * FROM test_trigger

------INSERT TRIGGER----------
create trigger tr_test_trig_insert29
on test_trigger
for insert
as
begin 
	select * from test_trigger
end

insert into test_trigger
values(5)

------DELETE TRIGGER----------

create trigger tr_test_trigger_delete
on test_trigger
for delete
as
begin 
	select * from test_trigger
end

delete from test_trigger
where age = 5

drop trigger tr_emp_insert

------update TRIGGER----------

create trigger tr_test_trigger_update
on test_trigger
after update
as
begin 
	select * from test_trigger
end

update test_trigger
set age = 38
where age = 35

----------------------------------------------------
create table tblEmpAudit
( id int,
Audit_Data varchar(50))

enable trigger stFristTrigger on database


----------------------------------------------------

alter trigger tr_employee_insert
on employee
after insert
as
begin	
	declare @Id int
	select @Id = Id from inserted

	insert into tblEmpAudit
	values('New Employee with id = ' + cast(@Id as varchar(10)) + ' is added at ' + cast(getDate() as varchar(10)))
end

enable trigger tr_employee_insert on database

insert into employee(First_Name,Last_Name,Salary,DeptID)
values('Ax','Bx',45000,1)

select * from tblEmpAudit
select * from employee

------- Instead Of Trigger ---------------------
select * from employee

delete from employee
where ID= 34

UPDATE employee
SET DeptID = 
	CASE 
		WHEN Dept = 'IT' THEN 1
		WHEN Dept = 'HR' THEN 2
		WHEN Dept = 'FIN' THEN 3
END
WHERE DeptID IS NULL;

alter table employee
add DeptID int

create table Dept(
DeptID int,
DeptName varchar(10))

insert into Dept
values(1,'IT'),(2,'HR'),(3,'FIN')

select * from Dept

alter Table employee
drop column Dept

----create view , so that instead of trigger can work on view-------

alter view vw_Emp_Dept
as
Select First_Name,Last_Name,Salary,DeptName
from employee
join Dept
on employee.DeptID=Dept.DeptID


alter trigger tr_employee_insteadOf
on vw_Emp_Dept
instead of Insert
As
Begin
	DECLARE @DeptID int

	SELECT @DeptID = DeptID 
	from Dept
	join inserted
	on inserted.DeptName = Dept.DeptName

	insert into employee(First_Name,Last_Name,Salary,DeptID)
	select First_Name,Last_Name,Salary,@DeptID
	from inserted
End

select * from vw_Emp_Dept

insert into vw_Emp_Dept
values('Haider','Gourii',90000,'IT')

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

EXEC sp_help employee;




