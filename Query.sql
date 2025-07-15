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

select * from Account
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data.csv'
fields terminated by ','
enclosed by '"'
lines terminated by '\n';

show variables like 'secure_file_priv';
--Weekly Task
USE LMS;
CREATE TABLE LMS_MEMBERS (MemberID VARCHAR(10),MemberName VARCHAR(100),City VARCHAR(20),
DateRegister DATE,DateExpire DATE,MemberStatus VARCHAR(15));

Insert into LMS_MEMBERS
Values('LM001', 'AMIT', 'CHENNAI', ('2012-02-20'), ('2013-11-02'),'Temporary');

Insert into LMS_MEMBERS
Values('LM002', 'ABDHUL', 'DELHI', ('2012-04-10'),('2013-04-09'),'Temporary');

Insert into LMS_MEMBERS
Values('LM003', 'GAYAN', 'CHENNAI', ('2013-05-12'),('2013-05-14'), 'Permanent');

Insert into LMS_MEMBERS
Values('LM004', 'RADHA', 'CHENNAI', ('2012-04-22'), ('2013-04-21'), 'Temporary');

Insert into LMS_MEMBERS
Values('LM005', 'GURU', 'BANGALORE', ('2012-03-30'), ('2013-03-29'),'Temporary');

Insert into LMS_MEMBERS
Values('LM006', 'MOHAN', 'CHENNAI', ('2012-04-12'), ('2013-04-12'),'Temporary');

select * from LMS_MEMBERS;

CREATE TABLE LMS_SUPPLIERS_DETAILS (SupplierID VARCHAR(10),SupplierName VARCHAR(30),
Address VARCHAR(100),Contact VARCHAR(12),Email VARCHAR(30));

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S01','SINGAPORE SHOPPEE', 'CHENNAI', 989412355,'sing@gmail.com');

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S02','JK Stores', 'MUMBAI', 994012345 ,'jks@yahoo.com');

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S03','ROSE BOOK STORE', 'TRIVANDRUM', 944441122,'rose@gmail.com');

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S04','KAVARI STORE', 'DELHI', 863000145,'kavi@redif.com');

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S05','EINSTEN BOOK GALLARY', 'US', 954200001,'eingal@aol.com');

Insert into  LMS_SUPPLIERS_DETAILS 
Values ('S06','AKBAR STORE', 'MUMBAI',785562310 ,'akbakst@aol.com');

select * from LMS_SUPPLIERS_DETAILS;

CREATE TABLE LMS_FINE_DETAILS(FineRange VARCHAR(5),FineAmount INT);

Insert into LMS_FINE_DETAILS Values('R1', 20);

insert into LMS_FINE_DETAILS Values('R2', 50);

Insert into LMS_FINE_DETAILS Values('R3', 75);

Insert into LMS_FINE_DETAILS Values('R4', 100);

Insert into LMS_FINE_DETAILS Values('R5', 150);

Insert into LMS_FINE_DETAILS Values('R6', 200);

select * from lms_fine_details;


CREATE table LMS_BOOK_DETAILS (BookCode VARCHAR(10) primary key,BookTitle VARCHAR(50),Category VARCHAR(20),Author VARCHAR(30),
Publication VARCHAR(30),PublishDate Date,BookEdition INT,Price INT,RackNum VARCHAR(10),DateArrival DATE,
SupplierID VARCHAR(10));



Insert into LMS_BOOK_DETAILS
Values('BL000001', 'Java How To Do Program', 'JAVA', 'Paul J. Deitel', 'Prentice Hall', ('1999-10-12'), 6, 600.00, 'A1',('2011-10-05'), 'S01');

Insert into LMS_BOOK_DETAILS
Values('BL000002', 'Java: The Complete Reference ', 'JAVA', 'Herbert Schildt',  'Tata Mcgraw Hill ', ('2011-10-10'), 5, 750.00, 'A1', ('2011-10-05'), 'S03');

Insert into LMS_BOOK_DETAILS 
Values('BL000003', 'Java How To Do Program', 'JAVA', 'Paul J. Deitel', 'Prentice Hall', ('1999-02-10'), 6, 600.00, 'A1', ('2012-05-12'), 'S01');

Insert into LMS_BOOK_DETAILS
Values('BL000004', 'Java: The Complete Reference ', 'JAVA', 'Herbert Schildt', 'Tata Mcgraw Hill ', ('2011-10-10'), 5, 750.00, 'A1', ('2012-05-12'), 'S01');

Insert into LMS_BOOK_DETAILS 
Values('BL000005', 'Java How To Do Program', 'JAVA', 'Paul J. Deitel',  'Prentice Hall', ('1999-12-10'), 6, 600.00, 'A1', ('2012-05-12'), 'S01');

Insert into LMS_BOOK_DETAILS
Values('BL000006', 'Java: The Complete Reference ', 'JAVA', 'Herbert Schildt', 'Tata Mcgraw Hill ', ('2011-10-10'), 5, 750.00, 'A1', ('2012-05-12'), 'S03');

Insert into LMS_BOOK_DETAILS 
Values('BL000007', 'Let Us C', 'C', 'Yashavant Kanetkar ', 'BPB Publications', ('2010-12-11'),  9, 500.00 , 'A3', ('2010-01-03'), 'S03');

Insert into LMS_BOOK_DETAILS 
Values('BL000008', 'Let Us C', 'C', 'Yashavant Kanetkar ','BPB Publications', ('2010-12-11'),.9, 500.00 , 'A3', ('2010-01-03'), 'S04');

select * from LMS_BOOK_DETAILS;


CREATE TABLE LMS_BOOK_ISSUE(BookIssueNo INT PRIMARY KEY,MemberID VARCHAR(10),BookCode VARCHAR(10),DateIssue DATE,DateReturn DATE,
DateReturned DATE,BookIssueStatus VARCHAR(30),FineRange VARCHAR(5));

Insert into LMS_BOOK_ISSUE 
Values (001, 'LM001', 'BL000001',('2012-05-01'),('2012-05-16'), ('2012-05-16'),'N', 'R1');


Insert into LMS_BOOK_ISSUE 
Values (002, 'LM002', 'BL000002', ('2012-02-12'),('2012-06-06'), ('2012-11-01'), 'N', 'R2');

Insert into LMS_BOOK_ISSUE
Values (003, 'LM003', 'BL000007', ('2012-04-19'),('2012-05-06'), ('2012-10-05'),'Y','R1');

Insert into LMS_BOOK_ISSUE 
Values (004, 'LM004', 'BL000005', ('2012-05-01'),('2012-05-16'), ('2012-05-16'), 'Y', 'R1');

Insert into LMS_BOOK_ISSUE 
Values (005, 'LM005', 'BL000008',('2012-07-11'),('2012-08-16'), ('2012-08-19') ,'N', 'R2');

SELECT * from LMS_BOOK_ISSUE;


select MemberID,MemberName,City,MemberStatus from lms_members WHERE MemberStatus = 'Permanent' ;


select  i.MemberID,m.MemberName from lms_book_issue i inner join lms_members m on
 i.MemberID = m.MemberID WHERE i.BookIssueStatus = 'N' ;
 
 select  i.MemberID,m.MemberName from lms_book_issue i inner join lms_members m on
 i.MemberID = m.MemberID WHERE i.BookCode = 'BL000002' ;

select b.BookCode,b.BookTitle,b.Author from lms_book_details b WHERE b.Author like 'P%' ;

select COUNT(b.BookCode) AS NO_OF_BOOKS from lms_book_details b 
WHERE b.Category = 'JAVA';

select Category AS BookCategory,COUNT(BookCode) As NO_OF_BOOKS  from lms_book_details GROUP BY Category;

select COUNT(b.BookCode) from lms_book_details b 
WHERE b.Publication = 'Prentice Hall';

select i.BookCode,b.BookTitle from lms_book_issue i inner join lms_book_details b 
ON i.BookCode = b.BookCode
WHERE i.DateIssue = '2012/04/01';	

SELECT MemberID,MemberName,DateRegister,DateExpire
FROM lms_members
WHERE DateExpire < '2013-04-01';


SELECT MemberID,MemberName,DateRegister,DateExpire,MemberStatus
FROM lms_members
WHERE DateRegister < '2013-03-01' AND MemberStatus = 'Temporary' ;

select MemberID,MemberName AS Name from lms_members WHERE City IN ('Chennai','Delhi');

select Concat(booktitle,'_is_written_by_',Author) AS BOOK_WRITTEN_BY from lms_book_details;


select AVG(Price) AS AVERAGEPRICE from lms_book_details WHERE Category = 'JAVA';

select SupplierID,SupplierName,Email from lms_suppliers_details WHERE Email is not NULL;

select SupplierID,SupplierName,Coalesce(Contact,Email,Address) AS CONTACTDETAILS 
from lms_suppliers_details;

select SupplierID,SupplierName ,
CASE WHEN Contact is NULL THEN 'NO' 
ELSE 'YES' END AS PHONENUMAVAILABLE
 from lms_suppliers_details;

select m.MemberID,m.MemberName,b.BookCode,b.BookTitle
 from lms_members m inner join lms_book_issue i 
on m.MemberID = i.MemberID INNER JOIN lms_book_details b on
i.BookCode = b.BookCode Group BY m.MemberID,m.MemberName,b.BookCode,b.BookTitle;

select Count(BookCode) NO_OF_BOOKS_AVAILABLE from lms_book_details where BookCode NOT IN 
(select BookCode from lms_book_issue) ;

select m.MemberID,m.MemberName,f.FineRange,f.FineAmount from lms_book_issue i 
INNER JOIN lms_fine_Details f ON
i.FineRange = f.FineRange AND f.FineAmount < 100 INNER JOIN 
lms_members m on i.MemberID = m.MemberID;

select b.bookCode,b.booktitle ,
CASE WHEN i.BookIssueStatus = 'N' THEN 'No'
ELSE  'Yes' END AS AVAILABILITYSTATUS
from lms_book_details b
inner join lms_book_issue i on b.bookcode = i.bookcode
WHERE b.BookEdition = 6 AND b.Category = 'JAVA';

select BookCode,BookTitle,RackNum from lms_book_details where RackNum = 'A1'
 ORDER BY BookTitle;

 select m.MemberID,m.MemberName from lms_members m inner join lms_book_issue i ON
 m.MemberID = i.MemberID WHERE i.DateReturned > i.DateReturn;
 
 select m.MemberID,m.MemberName,m.DateRegister from lms_members m WHERE m.MemberID NOT IN
 (select MemberID from lms_book_issue);
 
 select m.MemberID,m.MemberName from lms_members m INNER JOIN lms_book_issue i ON
 m.MemberID = i.MemberID WHERE i.DateReturned < i.DateReturn AND YEAR(i.DateIssue) = 2012;
 
 
 select DateIssue,COUNT(BookCode) NOOFBOOKS from lms_book_issue group by DateIssue;

select BookTitle,SupplierID from lms_book_details WHERE Author = 'Herbert Schildt' 
AND BookEdition = 5 AND SupplierID = 'S01';

select RackNum,Count(BookCode) NOOFBOOKS from lms_book_details GROUP BY RackNum ORDER BY RackNum;

select i.BookIssueNo,m.MemberName,m.DateRegister,m.DateExpire,b.booktitle,
b.Category,b.Author,b.Price,i.DateIssue AS 'date of issue',i.DateReturn AS 'date of return',
i.DateReturned AS 'Actual Returned Date',i.BookIssueStatus AS 'IssueStatus',f.FineAmount
from lms_book_issue i inner join lms_members m on i.MemberID = m.MemberID
INNER JOIN lms_fine_details f on i.FineRange = f.FineRange
INNER JOIN lms_book_details b ON i.BookCode = b.BookCode;

select BookCode,BookTitle,PublishDate from lms_book_Details WHERE Month(PublishDate) = 12;

select b.BookCode,b.BookTitle,CASE WHEN i.BookIssueStatus = 'Y' THEN 'Yes' 
WHEN   i.BookIssueStatus = 'N' THEN 'No'
ELSE 'Yes' END AS AVAILABILITYSTATUS 
from lms_book_details b left join lms_book_issue i on b.BookCode = i.BookCode
WHERE b.Category = 'JAVA' AND b.BookEdition = 5;

select b.BookTitle,s.SupplierName from lms_Book_details b INNER JOIN lms_suppliers_details s 
where s.SupplierID =  (select SupplierID
from lms_Book_Details group by SupplierID ORDER BY Count(SupplierID) DESC LIMIT 1 OFFSET 0)
group by b.BookTitle,s.SupplierName; 

select m.MemberID,m.MemberName, 3 - 
(select Count(b1.BookCode) from lms_book_issue b1 where b1.MemberID = m.MemberID
 AND b1.BookIssueStatus = 'N') 
AS REMAININGBOOKS from lms_members m LEFT join lms_book_issue i ON
m.MemberID = i.MemberID
group by m.MemberID,m.MemberName;

select s.SupplierID,s.SupplierName from  lms_suppliers_details s 
where s.SupplierID =  (select SupplierID
from lms_Book_Details group by SupplierID ORDER BY Count(SupplierID)  LIMIT 1 OFFSET 0)
group by s.SupplierID,s.SupplierName; 

-- MiniProject

create DATABASE MiniProject;
USE MiniProject;


create table CUSTOMER_MASTER
(
CUSTOMER_ID Varchar(10),
CUSTOMER_NAME Varchar(30) NOT NULL,
CONTACT_NO BIGINT(20),
CONTACT_ADD Varchar(100),
DATE_OF_REGISTRATION Date NOT NULL,
AGE Varchar(15)NOT NULL,
Constraint MT_cts1 PRIMARY KEY(CUSTOMER_ID)
);

Create table MOVIES_MASTER
(
MOVIE_ID Varchar(10),
MOVIE_NAME Varchar(80) NOT NULL,
RELEASE_DATE Varchar(30) NOT NULL,
LANGUAGE Varchar(30),
RATING int(2),
DURATION_In_Minutes VARCHAR(10) NOT NULL,
MOVIE_TYPE Varchar(100),
MOVIE_CATEGORY VARCHAR(40) NOT NULL,
DIRECTOR VARCHAR(60) NOT NULL,
LEAD_Actor_name1 Varchar(50) NOT NULL,
LEAD_Actor_name2 VARCHAR(60) NOT NULL,
RENTAL_COST BIGINT(10),
Constraint MT_cts4 PRIMARY KEY(MOVIE_ID));


Create table CUSTOMER_ISSUE_DETAILS
(
ISSUE_ID Varchar(10) NOT NULL,
CUSTOMER_ID Varchar(10) NOT NULL,
MOVIE_ID VARCHAR(10),
ISSUE_DATE Date NOT NULL,
RETURN_DATE Date NOT NULL,
ACTUAL_DATE_RETURN Date NOT NULL,
Constraint MT_cts5 PRIMARY KEY(ISSUE_ID),
Constraint MT_Mem FOREIGN KEY(CUSTOMER_ID) References
CUSTOMER_MASTER(CUSTOMER_ID),
Constraint MT_Mem1 FOREIGN KEY(MOVIE_ID) References MOVIES_MASTER(MOVIE_ID)
);

Create table LIBRARY_CARD_MASTER
(
CARD_ID Varchar(10),
DESCRIPTION Varchar(30) NOT NULL,
AMOUNT BIGINT(50),
NUMBER_OF_YEARS bigint(10) NOT NULL,
Constraint MT_cts2 PRIMARY KEY(CARD_ID)
);

Create table CUSTOMER_CARD_DETAILS
(
CUSTOMER_ID Varchar(10),
CARD_ID VARCHAR(10),
ISSUE_DATE DATE NOT NULL,

Constraint MT_cts3 PRIMARY KEY(CUSTOMER_ID),
Constraint MT_CTS41 FOREIGN KEY(CUSTOMER_ID) References
CUSTOMER_MASTER(CUSTOMER_ID),
Constraint MT_CTS42 FOREIGN KEY(CARD_ID) References LIBRARY_CARD_MASTER(CARD_ID)
);

insert into customer_master values 
('C00001','	NITIN	','9830354218','	A/122, KALKAJI','	2012-10-15',	22),
('C00002','	AGNESH	','8923156781',	'9/1,ANDHERI EAST','	2012-11-01',	35),
('C00003','	T RAMACHANDRAN','	9831289761','	9/1,NANDABAKKAM','	2012-11-02',	25),
('C00004'	,'RAJIB MITRA'	,'9830356781','	H/56, BLOCK1,JADAVPUR','	2012-11-21',	45),
('C00005','	SHIV PRASAD',	NULL,'	2/2 PHASE II JAWAHAR NAGAR'	,'2012-12-25',	30),
('C00006',	'AJAY GHOSH'	,'8763478901'	,'N/2,GANDHI COLONY DUM DUM',	'2012-12-30'	,20),
('C00007',	'GEETHA REDDY'	,'8976167890','	AH 1/1 T NAGAR'	,'2012-12-31'	,30),
('C00008',	'RIA NATRAJAN'	,'9856723190'	,'A/B GANDHI COLONY'	,'2013-01-01'	,45),
('C00009',	'RAJAN PILLAI'	,NULL,'	A 1/66 KODAMBAKKAM	','2013-01-02',	40),
('C00010',	'RAGHAV SINGH',	'9675167890'	,'A/6 NEHRU JAWAHAR NAGAR',	'2013-03-02'	,50),
('C00011',	'RAJ SEKHANRAN','	8423178906'	,'A/1 MAYUR KUNJ'	,'2013-03-15'	,25);




insert into movies_master values 
('M00001','	DIE HARD','	1998	','ENGLISH	',4	,120	,'UNIVERSAL','	ACTION',
'JOHN MCTIERNAN'	,'BRUCE WILLIS'	,'BONNIE BEDELIA'	,100),
('M00002','	THE DARK KNIGHT','	2008','	ENGLISH',	5	,90	,'PARENTAL GUIDENCE','	ACTION','	
CHRISTOPHER NOLAN'	,
'CHRISTIAN BALE','HEALTH LEDGER',	100),
('M00003','	THE MATRIX',	1999,'	ENGLISH',	4,	120,'	UNIVERSAL','	ACTION','	ANDY LARRY','	KEANU REEVES	',
'CARRIE-ANEE MOSS',	100),

('M00004','	INCEPTION',	2010	,'ENGLISH	',5	,120,'	PARENTAL GUIDENCE	','ACTION',	
'CHRISTOPHER NOLAN',	'LEONARDO DICAPRIO','	JOSEPH GORDAN'	,100),

('M00005','OFFICE SPACE',	1999	,'ENGLISH',	4,	95	,'UNIVERSAL	','COMEDY	',
'MIKE JUDGE','	RON LIVINGSTON','	JENNIFER ANISTON	',100),

('M00006	','YOUNG FRANKENSTEIN','	1974','	ENGLISH',	4	,130,'	UNIVERSAL','	COMEDY',	
'MEL BROOKS','	GENE WILDER','	TERI GARR',	100),

('M00007','	SHAUN OF THE DEAD',	2004	,'ENGLISH',	4	,95,'	UNIVERSAL',	'COMEDY',	
'EDGAR WRIGHT','	SIMON PEGG	','KATE ASHFIELD'	,100),

('M00008','	CASABLANCA',	1942,'	ENGLISH',	3,	120	,'UNIVERSAL','	ROMANCE','	MICHAEL 
CURTIZ','	HUMPREY BOGART','	INGRID BERGMAN',	1000),

('M00009	','THE NOTEBOOK',	2004	,'ENGLISH',	3	,120	,'PARENTAL GUIDENCE','	ROMANCE	',
'NICK CASSAVETES','	RYAN GOSLING','	RACHEL MCADAMS',	100),

('M00010	','GONE WITH THE WIND	',1939	,'ENGLISH',	3	,120,'	PARENTAL GUIDENCE	','ROMANCE',	
'VICTOR FLEMMING',	'CLARK GABLE','	VIVIEN LEIGH	',100),

('M00011	','TITANIC',	1997	,'ENGLISH	',3	,120	,'PARENTAL GUIDENCE','	ROMANCE'	
,'JAMES CAMERON','	LEONARDO DICAPRIO	','KATE WINSLET',	100);

insert into customer_issue_details values
('I00001','C00001','M00001','2012-10-15','2012-10-17','2012-10-17');
insert into customer_issue_details values('I00002',	'C00002','M00002','2012-11-02'	,'2012-11-04','2012-11-05');
insert into customer_issue_details values
('I00003','C00002','M00002','2012-12-02','2012-12-04','2012-12-03');
insert into customer_issue_details values('I00004','C00003','M00003','2012-11-02','2012-11-04','2012-11-10');
insert into customer_issue_details values('I00005','C00003','M00004','2012-11-10',
'2012-11-12','2012-11-12');
insert into customer_issue_details values('I00006','C00003','M00005',
'2012-11-12','2012-11-14','2012-11-14');
insert into customer_issue_details values('I00007','C00004','M00006	','2012-11-21',
'2012-11-23','2012-11-24');
insert into customer_issue_details values('I00008','C00010','M00008','2013-03-02',
'2013-03-04','2013-03-05');
insert into customer_issue_details values('I00009','C00011','M00010	','2013-03-16','2013-03-18','2013-03-18');
insert into customer_issue_details values('I00010','C00004'	,'M00007',
'2012-11-25','2012-11-27','2012-11-27');

insert into customer_issue_details values('I00011','C00004'	,'M00007','2012-11-28',
'2012-11-30','2012-11-30');
insert into customer_issue_details values('I00012','C00001','M00001','2013-11-28','2013-11-30',
'2013-11-30');
insert into customer_issue_details values('I00013','C00003','M00001','2012-12-03','2012-12-05',
'2012-12-05');
insert into customer_issue_details values('I00014','C00003','M00010	','2013-01-02','2013-01-04'
,'2013-01-05');

insert into customer_issue_details values('I00015','C00003','M00011	','2013-02-03','2013-02-05',
'2013-02-06');
insert into customer_issue_details values('I00016','C00003','M00011	','2013-03-05','2013-03-07'
,'2013-03-07');
insert into customer_issue_details values('I00017','C00003','M00008','2013-04-15','2013-04-17'
,'2013-04-17');
insert into customer_issue_details values('I00018','C00002','M00010	','2015-01-15','2015-01-17'
,'2015-01-17');
insert into customer_issue_details values('I00019','C00004','M00001','2012-11-15	','2012-11-17','2012-11-17');



insert into  library_card_master values
('CRD001',	'SILVER CARD'	,1000,	1),
('CRD002',	'GOLD CARD	',2000	,2),
('CRD003',	'PLATINUM CARD'	,3000,	3),
('CRD004',	'DIAMOND CARD',	4000	,5);


Insert into CUSTOMER_CARD_DETAILS Values('C00001','CRD001','2012-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('C00002','CRD002','2012-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('C00003','CRD002','2013-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('C00004','CRD003','2013-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('C00005','CRD003','2012-05-13');



select m.Movie_Name ,COUNT(i.Movie_ID) AS ISSUE_COUNT from movies_master m 
LEFT JOIN Customer_issue_details i ON 
m.Movie_ID = i.Movie_ID 
GROUP BY i.Movie_ID,m.Movie_Name
ORDER BY ISSUE_COUNT DESC,m.Movie_Name;


select Customer_ID,Customer_Name,IFNULL(concat('+91-',substring(Contact_No,1,3),'-',
substring(Contact_No,4,3),'-',substring(Contact_No,7,4)),'N\A') AS CONTACT_ISD 
from customer_master WHERE Age > 25 AND YEAR(Date_of_Registration) = 2012
ORDER BY Age,Customer_Name;


select Movie_category,Count(Movie_ID) AS NO_OF_MOVIES from movies_master
Group BY Movie_category ORDER BY NO_OF_MOVIES DESC,Movie_category;

UPDATE movies_master
SET movie_Category = TRIM(REGEXP_REPLACE(movie_Category, '\\s+', ' '));


select COUNT(c.card_ID) AS CUSTOMER_COUNT from customer_card_details c  
INNER JOIN library_card_master  cm ON
c.Card_ID = cm.Card_ID WHERE cm.Description LIKE '%GOLD CARD%';



select c.Customer_ID,c.Customer_name,YEAR(c.Date_of_Registration) AS REGISTERED_YEAR , 
cd.card_id,cd.issue_date
from customer_master c inner join customer_card_details cd  
ON c.Customer_ID = cd.Customer_ID
ORDER BY c.Customer_name desc;
 
select i.ISSUE_ID,i.Customer_ID,c.Customer_Name from customer_issue_details i
INNER JOIN customer_master c on i.Customer_ID = c.Customer_ID 
WHERE i.Return_Date<i.Actual_date_return AND c.Customer_name LIKE 'R%' ORDER BY c.Customer_Name;

select c.Customer_ID,c.Customer_Name,cd.Card_ID,cm.Description,concat('$',ROUND(cm.Amount/85.8,0)) 
AS AMOUNT_DOLLAR from customer_master c INNER JOIN customer_card_details cd 
ON c.Customer_ID = cd.Customer_ID INNER JOIN library_card_master cm on 
cd.Card_id = cm.Card_id INNER JOIN customer_issue_Details ci on cd.Customer_ID = ci.Customer_ID
AND ci.Issue_Date = cd.Issue_Date;

select c.Customer_name,COUNT(Movie_ID) AS MOVIE_COUNT from customer_master c 
LEFT join customer_issue_details ci on ci.Customer_ID = c.Customer_ID
group by C.Customer_ID,C.customer_name ORDER BY c.Customer_ID;

select cd.Issue_ID,cd.Issue_Date,c.customer_name,c.contact_no from 
customer_issue_Details cd inner JOIN customer_master c  ON  cd.Customer_ID = c.Customer_ID
where YEAR(cd.Issue_date) = 2013 ORDER BY cd.Issue_Date DESC;



select UPPER(Director) AS DIRECTOR_NAME,COUNT(MOVIE_ID) AS 'number of movies' from movies_master 
group by DIRECTOR HAVING COUNT(MOVIE_ID)>1
ORDER BY DIRECTOR_NAME;


update movies_master SET Director= 'CHRISTOPHER NOLAN' WHERE Movie_id = 'M00002';
