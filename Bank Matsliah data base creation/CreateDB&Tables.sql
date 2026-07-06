--1. Creating a new database 

CREATE DATABASE BANKMATSLIAH;

USE BANKMATSLIAH;

--2. Creating a new tables and Insert data to an empty tables

--Table #1
CREATE TABLE Bankers
(
	Banker_ID INT PRIMARY KEY IDENTITY(1, 1),
	First_Name NVARCHAR(20) NOT NULL,
	Last_Name NVARCHAR(20) NOT NULL,
	Title NVARCHAR(255) NULL,
	BirthDate DATE NOT NULL,
	HireDate DATE NOT NULL,
	Address NVARCHAR(255) NULL,
	City NVARCHAR(255) NULL,
	ReportsTo INT NULL FOREIGN KEY REFERENCES Bankers(Banker_ID)
);

INSERT INTO Bankers (First_Name, Last_Name, Title, BirthDate, HireDate, Address, City, ReportsTo)
VALUES
		('Michael', 'Shmueli', 'Branch manager','1962-05-17', '2019-10-18', 'Migdal David 14', 'Rosh ha Ain',NULL),
		('Boris', 'Berezovsky', 'Banker', '1968-12-08', '2022-05-01', 'Rashi 12', 'Ramat Gan', 1),
		('Anat', 'Shmueli', 'Banker','1979-04-12', '2019-12-10', 'Har ha Mor 3', 'Rosh ha Ain',1),
		('Sara', 'Tsuberi', 'Banker','1980-04-19', '2022-12-05', 'Smadar 3', 'Rosh ha Ain',1),
		('Naomi', 'Biton', 'Mortage consultant','1985-07-30', '2021-11-04', 'Ha shlosha 7', 'Tel Aviv',1);

SELECT*
FROM Bankers;


--Table #2
CREATE TABLE Clients
(
	Client_ID NCHAR(9) PRIMARY KEY,
	First_Name NVARCHAR(20) NOT NULL,
	Last_Name NVARCHAR(20) NOT NULL,
	Age NCHAR(3) NOT NULL,
	BirthDate DATE NOT NULL,
	Gender NCHAR(1) CHECK(Gender IN ('M', 'F')) NULL,
	Address NVARCHAR(255) NOT NULL,
	City NVARCHAR(255) NOT NULL,
	Contact_Number NVARCHAR(255) CHECK(Contact_Number LIKE '%-%') NOT NULL,
	Email NVARCHAR(255) CHECK(Email LIKE '%_@_%._%' OR Email IS NULL)
);

INSERT INTO Clients (Client_ID, First_Name, Last_Name, Age, BirthDate, Gender, Address, City, Contact_Number, Email)
VALUES
		('345456987', 'Haim', 'Rabinovich', '44', '1981-07-01', 'M', 'Hatikva 17', 'Tel Aviv', '050-1521526', 'haimrab@gmail.com'),
		('345456988', 'Sara', 'Rabinovich', '40', '1985-01-07', 'F', 'Hatikva 17', 'Tel Aviv', '050-157586', 'sarar@gmail.com'),
		('254625852', 'Teila', 'Buskila', '21', '2004-12-26', 'F', 'Byalik 22', 'Ramat Gan', '053-8527496', 'tbus@gmail.com'),
		('753951456', 'Elena', 'Ginzburg', '45', '1980-08-21', 'F', 'Herzl 50', 'Ramat Gan', '052-4579562', 'elginzburg@gmail.com'),
		('124563956', 'David', 'Cohen', '75', '1950-12-17', 'M', 'Weizman 12', 'Givataim', '054-1428596', NULL),
		('054852145', 'Izchak', 'Levin', '80', '1945-02-21', NULL, 'Rotshild 55', 'Petakh Tikva', '053-5289999', 'ilevin@gmail.com'),
		('022321458', 'Avraham', 'Malichi', '77', '1948-01-26', 'M', 'Alenbi 97', 'Tel Aviv', '052-6548502', NULL),
		('031435791', 'Lea', 'Ukashi', '52', '1973-08-15', 'F', 'Nely Zaks 5', 'Rosh ha Ain', '050-7458596', 'leauk@gmail.com'),
		('007523951', 'Miriam', 'Orin', '101', '1924-03-07', 'F', 'Byalik 22', 'Ramat Gan', '052-2541318', NULL),
		('005417359', 'Naomi', 'Bichman', '33', '1992-10-05', 'F', 'Disengof 49', 'Tel Aviv', '054-9943060', NULL);

SELECT*
FROM Clients;


--Table #3
CREATE TABLE Accounts
(
	Account_Number INT PRIMARY KEY IDENTITY(100000, 1),
	Client_ID NCHAR(9) NOT NULL FOREIGN KEY REFERENCES Clients(Client_ID),
	Account_Type NVARCHAR(20) CHECK(Account_Type IN ('Current', 'Savings')) NOT NULL,
	Account_Balance	MONEY NOT NULL,
	Date_Of_Account_Opening DATE NOT NULL,
	Last_Transaction_Date DATE NOT NULL,
	Branch_ID NCHAR(2) NOT NULL,
	Date_Of_Account_Closing DATE NULL,
	Banker_ID INT FOREIGN KEY REFERENCES Bankers(Banker_ID)
);

INSERT INTO Accounts (Client_ID, Account_Type, Account_Balance, Date_Of_Account_Opening, Last_Transaction_Date, 
			Branch_ID, Date_Of_Account_Closing,Banker_ID)
VALUES 
		('345456987', 'Current', 1313.38, '05-26-2006', '08-23-2025', '01', NULL, 1),
		('345456987', 'Savings', 5988.46, '03-02-2006', '09-06-2025', '01', NULL, 1),
		('345456988', 'Current', 8277.88, '07-19-2015', '05-16-2025', '02', NULL, 3),
		('254625852', 'Savings', 7487.21, '01-30-2008', '05-06-2025', '03', NULL, 4), 
		('753951456', 'Savings', 6993.55, '05-25-2021', '01-06-2025', '03', NULL, 2),
		('753951456', 'Current', 9295.64, '12-21-2015', '10-26-2025', '03', '10-31-2025', 2),
		('124563956', 'Current', 4005.72, '07-07-2022', '06-06-2025', '02', NULL, 2),
		('054852145', 'Current', 1458.45, '12-14-2022', '11-20-2025', '02', NULL, 4),
		('022321458', 'Current', 1109.30, '04-29-2012', '03-27-2025', '01', NULL, 4),
		('031435791', 'Savings', 728.80, '12-20-2021', '09-24-2025', '02', '10-24-2025', 1),
		('007523951', 'Savings', 2082.67, '08-12-2015', '05-28-2025', '02', NULL, 3),
		('005417359', 'Savings', 464.86, '09-13-2005', '10-31-2025', '01', NULL,3);

SELECT*
FROM Accounts;


--Table #4
CREATE TABLE Deposits
(
	Deposit_ID INT PRIMARY KEY IDENTITY(1, 1),
	Account_Number INT FOREIGN KEY REFERENCES Accounts(Account_Number),
	Amount_Of_Deposit MONEY CHECK(Amount_Of_Deposit>0) NOT NULL,
	Interest_Dep_Rate DECIMAL(2,1) CHECK (Interest_Dep_Rate BETWEEN 4 AND 6) NOT NULL,
	Date_Of_Deposit_Opening DATE NOT NULL,
	Required_Date DATE NULL,
	Resolution_Date DATE NOT NULL
);

INSERT INTO Deposits (Account_Number, Amount_Of_Deposit, Interest_Dep_Rate, Date_Of_Deposit_Opening, Required_Date, Resolution_Date)
VALUES
		(100001, 400000, 4.0, '07-26-2012', NULL, '07-26-2017'),
		(100003, 1500000, 6.0, '07-26-2016', NULL, '07-26-2021'),
		(100005, 800000, 4.0, '07-20-2022', '07-20-2026', '07-20-2027'),
		(100010, 1000000, 6.0, '07-26-2015', NULL, '07-26-2020'),
		(100010, 1000000, 5.0, '10-01-2012', NULL, '10-01-2013'),
		(100011, 1000000, 4.0, '10-01-2012', NULL, '10-01-2013')
		
SELECT*
FROM Deposits;


--Table #5
CREATE TABLE Loans
(
	Loan_ID INT PRIMARY KEY IDENTITY(1, 1),
	Account_Number INT FOREIGN KEY REFERENCES Accounts(Account_Number),
	Loan_Amount MONEY CHECK(Loan_Amount>0) NOT NULL,
	Loan_Type NVARCHAR(20) CHECK(Loan_Type IN ('Mortgage', 'Auto', 'Personal')) NOT NULL,
	Interest_Loan_Rate DECIMAL(2,1) CHECK (Interest_Loan_Rate BETWEEN 6 AND 9) NOT NULL,
	Loan_Term INT NOT NULL,
	Approval_Rejection DATE NOT NULL,
	Loan_Status NVARCHAR(20) CHECK(Loan_Status IN ('Rejected', 'Approved', 'Closed')) NOT NULL,
	Resolution_Date DATE NULL
);

INSERT INTO Loans (Account_Number, Loan_Amount, Loan_Type, Interest_Loan_Rate, Loan_Term, Approval_Rejection, Loan_Status,Resolution_Date)
VALUES 
		(100000, 15000, 'Auto', 8.0, 60, '01-04-2024', 'Approved', NULL),
		(100000, 2500000, 'Mortgage', 6.0, 360, '01-04-2008', 'Approved', NULL),
		(100002, 100000, 'Personal', 9.0, 120, '02-08-2025', 'Approved', NULL),
		(100002, 150000, 'Personal', 8.5, 60, '10-10-2025', 'Rejected', NULL),
		(100005, 50000, 'Personal', 8.5, 60, '10-10-2020', 'Closed', '10-10-2025'),
		(100008, 1500000, 'Mortgage', 6.5, 360, '02-21-2014', 'Rejected', NULL)

SELECT*
FROM Loans;


--4. ERD

ALTER AUTHORIZATION ON DATABASE::bankmatsliah TO [sa] ;
