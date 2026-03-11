--Bài tập 1

CREATE DATABASE UNIVERSITY 

USE UNIVERSITY

CREATE TABLE Student (
Student_ID INT PRIMARY KEY NOT NULL,
StudentName NVARCHAR(50) NOT NULL, 
StudentBirth DATE NULL,
IsMale BIT NULL)

CREATE TABLE Professor (
Employee_ID INT PRIMARY KEY NOT NULL, 
ProfessorName NVARCHAR(50) NOT NULL)

CREATE TABLE Course (
Course_ID INT PRIMARY KEY NOT NULL, 
CourseName NVARCHAR(50) NOT NULL,
Professor_ID INT NOT NULL

FOREIGN KEY (Professor_ID) REFERENCES Professor(Employee_ID)
)

CREATE TABLE Assigned (
Student_ID INT NOT NULL,
Course_ID INT NOT NULL, 
Note NVARCHAR(MAX) NULL,

PRIMARY KEY (Student_ID, Course_ID),

FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
)

INSERT INTO Student VALUES
(1, 'A', '2000-10-01', NULL),
(2, 'B', '2000-12-01', NULL),
(3, 'C', '2000-10-10', 0),
(4, 'D', '2000-08-20', 1),
(5, 'E', '2000-05-15', NULL),
(6, 'F', '2000-05-12', NULL) 

INSERT INTO Professor VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D')

INSERT INTO Course VALUES 
(1, 'Thuật toán', 1),
(2, 'Toán', 2),
(3, 'Vật lý', 4)

INSERT INTO Assigned VALUES
(1, 1, NULL), 
(1, 2, 'Test'),
(2, 1, NULL),
(2, 3, NULL)

--Bài tập 2

CREATE DATABASE COMPANY

USE COMPANY

CREATE TABLE CUSTOMERS (
ID INT PRIMARY KEY NOT NULL, 
"Name" NVARCHAR(50) NOT NULL,
Age SMALLINT NULL,
"Address" NVARCHAR(MAX) NULL,
Salary DECIMAL(18,0) NULL
)

--Bài tập 3

INSERT INTO CUSTOMERS VALUES
(1, 'Ha Anh', 32, 'Da Nang', 2000),
(2, 'Van Ha', 25, 'Ha Noi', 1500),
(3, 'Vu Bang', 23, 'Vinh', 2000),
(4, 'Thu Minh', 25, 'Ha Noi', 6500)