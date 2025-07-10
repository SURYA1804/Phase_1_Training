USE training;

CREATE table Employee(EmployeeID int auto_increment PRimary Key,EmployeeName VARCHAR(100) NOT NULL,Designation INT NOT NULL,
Salary Double NOT NULL);

drop table Employee;

desc Employee;

select e.EmployeeID,e.EmployeeName,D.Designation,e.Salary from 
EmployeeDetails e INNER JOIN MasterDesignation D ON e.Designation = D.DesignationID
WHERE e.EmployeeID <> 1;

INSERT INTO Employee(EmployeeName,Designation,Salary) VALUES ('SubramaniyaKarthi',99,600000);

SET sql_safe_updates  = 0;

delete from Employee where EmployeeID = 4;

CREATE Table MasterDesignation (DesignationID INT PRIMARY KEY,Designation VARCHAR(100));

INSERT INTO MasterDesignation VALUES (100,'Software Engineer'),(99,'Associate Software');

RENAME table Employee to EmployeeDetails;

select * from EmployeeDetails WHERE EmployeeName like '%surya%';

--Daily Task
CREATE table Customer(CustomerID varchar(20),FirstName VARCHAR(10),MiddleName VARCHAR(20),
CustomerContactNo VARCHAR(10),CustomerCity VARCHAR(10),CustomerDOB DATE);



Alter table Customer add column LastName VARCHAR(20);

ALTER TABLE Customer  MODIFY FirstName VARCHAR(30);

ALTER table Customer drop Column MiddleName

DESC Customer;

INSERT INTO Customer values ('17','Virat','45678960','Pollachi','2004-05-06',''),
							('19','Karthi','456789078','Coimbatore','2004-11-06','K');
 
 select * from Customer;
 
 CREATE table Account(AccountNumber varchar(20),customer_number VARCHAR(20),branch_id VARCHAR(10),
OpeningBalance double,account_type VARCHAR(10),account_status VARCHAR(10));

desc Account;
 
 
INSERT INTO Account values ('180','18','chennai','2004','savings','Active'),
							('181','19','Pollachi','20654','Current','Active');    
                            
select * from Account WHERE Branch = 'Chennai';

select Customer_number from Account WHERE OpeningBalance BETWEEN 5000 AND 500000;

select CustomerID,FirstName,CustomerDOB from Customer;

select Monthname('2004-11-24');

select dayname('2004-11-24'); 

select day();

select dayofyear('2004-11-24');

SELECT weekday('2025-07-14');

SELECT dayofweek('2025-07-09');

SELECT EmployeeID,EmployeeName,
CASE Designation
WHEN 99 THEN 'Associate'
WHEN 100 THEN 'Software Engineer'
end AS Designation
from employeedetails; 


SELECT EmployeeID,EmployeeName,
CASE 
WHEN Designation =  99 THEN 'Associate'
WHEN Designation = 100 THEN 'Software Engineer'
end AS Designation
from employeedetails ;


select Designation,Count(EmployeeId) AS Count from employeedetails Group by Designation;

--Constraints
create table department(
department_id int primary key,
department_name varchar(30) not null);

insert into department values(10,'Administration');
insert into department values(20,'Marketing');
insert into department values(50,'Shipping');
insert into department values(60,'IT');
insert into department values(80,'Sales');
insert into department values(90,'Executive');


create table employee(
employee_id int ,
first_name varchar(20) not null,
last_name varchar(25) not null,
email varchar(25) unique,
phone_number varchar(20),
hire_date date not null,
job_id varchar(10) not null,
salary double check(salary >0),
commission_pct double,
manager_id int,
department_id int,
constraint emp_pk primary key(employee_id));

insert into employee_info(employee_id,first_name,last_name,email,phone_number,hire_date,
job_id,salary,department_id) values(100,'Steven','King','Sking','515.123.4567',
'1987-06-17','AD_PRES',24000,90);

insert into employee_info(employee_id,first_name,last_name,email,phone_number,hire_date,
job_id,salary,manager_id,department_id) values(101,'Neena','Kochar','NKOCHHAR','515.123.4568',
'1989-09-21','AD_VP',17000,100,90);

insert into employee_info(employee_id,first_name,last_name,email,phone_number,hire_date,
job_id,salary,manager_id,department_id) values
(102,'Lex','De Haan','NKOCHHAR','515.123.4569','1993-01-13','AD_VP',17000,100,90);

insert into employee_info(employee_id,first_name,last_name,email,phone_number,hire_date,
job_id,salary,manager_id,department_id) values(103,'Alexander','AHUNOLD','A','590.423.4567',
'1990-01-03','IT_PROG',9000,102,30);

update employee_info set department_id=60 where employee_id=103;

alter table employee add constraint emp_dep_fkey foreign key(department_id) 
references department(department_id) on delete set null;

desc employee;

select employee_id ,department_id from employee_info;

delete from department where department_id=60;


desc Customer;
alter table customer Add constraint  Primary key (CustomerID);

desc Account;
alter table Account Add constraint  Primary key (AccountNumber);

desc Account;
ALTER table ACcount ADD Constraint foreign key(Customer_number) references customer(CustomerID);

select * from Account;
ALTER TABLE ACCOUNT ADD CreatedAt Date;
update ACCOUNT SET CreatedAt = '2025-06-14' WHERE AccountNumber = '181';

select Count(Customer_number) AS Cust_Count From Account WHERE Branch = 'Chennai';

select A.Customer_number,C.FirstName,A.AccountNumber from Account A INNER JOIN Customer C ON 
A.Customer_number = C.CustomerID
WHERE DAY(A.CreatedAt)>15;

select * from Customer WHERE CustomerID NOT IN (select Customer_number from Account);

Create table transaction_details(
    transaction_number VARCHAR(6),
    account_number VARCHAR(6),
    date_of_transaction DATE,
    medium_of_transaction VARCHAR(20),
    transaction_type VARCHAR(20),
    transaction_amount double);
    
    
DESC transaction_details;
ALTER table transaction_details ADD Constraint foreign key(account_number) references Account(AccountNumber);
select * from transaction_details;
INSERT INTO transaction_details VALUES ('5','181',current_date(),'ATM','Debit',1000);

select t.transaction_type,COUNT(t.transaction_number) AS Trans_Count from Customer C 
INNER JOIN Account A ON C.CustomerID = A.Customer_number INNER JOIN transaction_details t
ON A.AccountNumber = t.account_number WHERE C.CustomerID = 18 GROUP BY t.transaction_type 
ORDER BY t.transaction_type;

select e.EmployeeID,e.EmployeeName,D.Designation,e.Salary from 
EmployeeDetails e INNER JOIN MasterDesignation D ON e.Designation = D.DesignationID;

DELETE FROM Employee WHERE Designation = (select DesignationID from masterdesignation WHERE Designation = 'Associative');


select  * from employeedetails e1 ORDER BY Salary DESC LIMIT 1 offset 1;

DELIMITER //
ALTER PROCEDURE  sp_GetEmployee(IN EmpID INT)
BEGIN
	select * from employeedetails WHERE EmployeeID = EmpID;
    select 'second';
END
DELIMITER ;

CALL sp_GetEmployee(1);

DELIMITER //
CREATE FUNCTION GetEmpName(EmpID INT)
Returns VARCHAR(100) 
DETERMINISTIC
BEGIN
   DECLARE name VARCHAR(100);
   select   EmployeeName INTO name  from employeedetails Where EmployeeID = EmpID;
   return name;
END//
DELIMITER ;

select GetEmpName(1);

DELIMITER //
CREATE PROCEDURE sp_sampleOUT(IN Name VARCHAR(100),OUT Sentence VARCHAR(100))
BEGIN 

	SET Sentence = Concat('Hello Mr ', Name);
END//
DELIMITER ;


CALL sp_sampleOUT('Surya',@msg);
SELECT @msg;

DELIMITER //

CREATE TRIGGER ValidateDelete
BEFORE DELETE ON employeedetails
FOR EACH ROW
BEGIN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete employee with salary over 50000';
END//
DELIMITER ;

delete from employeedetails WHERE EMployeeID = 1;




SELECT DISTINCT salary
FROM employeedetails e1
WHERE 1 = (
  SELECT COUNT(DISTINCT salary)
  FROM employeedetails e2
  WHERE e2.salary > e1.salary
);

DELIMITER //
CREATE FUNCTION GETMAX(A INT,B INT)
RETURNS INT
DETERMINISTIC
BEGIN
	IF A > B THEN
		RETURN A;
    ELSE
        RETURN B;
    END IF;
END//
DELIMITER ;
SELECT GETMAX(5,10);


select * from Account;
select * from transaction_details;

select A.AccountNumber,SUM(T.transaction_amount)+A.OpeningBalance AS Deposit_Amount from Account A 
INNER JOIN transaction_details T ON A.AccountNumber = T.Account_number
WHERE T.transaction_type = 'Credit' GROUP BY T.Account_number ORDER BY A.AccountNumber;

Create table branch_master( 
    branch_id VARCHAR(6) primary key,
    branch_name VARCHAR(30),
    branch_city VARCHAR(30));

INSERT INTO  branch_master VALUES ('B3','Chennai Main Branch','Chennai'),
								('B2','Coimbatore Main Branch','Coimbatore');
select * from branch_master;

select * from Account;
UPDATE Account SET Branch_ID = 'B1' WHERE AccountNumber = '181';

ALTER  TABLE ACCOUNT ADD CONSTRAINT Foreign Key(Branch_ID) REFERENCES branch_master(branch_id) ;
DESC ACCOUNT;



select * from Account;







