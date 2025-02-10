CREATE TABLE Student (
    RN INT PRIMARY KEY,
    Name VARCHAR(20),
    Age TINYINT
);

CREATE TABLE Test (
    TestID INT PRIMARY KEY,
    Name VARCHAR(20)
);

CREATE TABLE StudentTest (
    RN INT,
    TestID INT,
    Date DATETIME,
    Mark FLOAT,
    FOREIGN KEY (RN) REFERENCES Student(RN),
    FOREIGN KEY (TestID) REFERENCES Test(TestID)
);
INSERT INTO Student (RN, Name, Age) VALUES
(1, 'Nguyen Hong Ha', 20),
(2, 'Truong Ngoc Anh', 30),
(3, 'Tuan Minh', 25),
(4, 'Dan Truong', 22);

INSERT INTO Test (TestID, Name) VALUES
(1, 'EPC'),
(2, 'DWMX'),
(3, 'SQL1'),
(4, 'SQL2');

INSERT INTO StudentTest (RN, TestID, Date, Mark) VALUES
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 3, '2006-07-18', 1);
ALTER TABLE Student
ADD CONSTRAINT CK_Student_Age CHECK (Age BETWEEN 15 AND 55);

ALTER TABLE StudentTest
alter COLUMN Mark SET DEFAULT 0;

ALTER TABLE StudentTest
ADD CONSTRAINT PK_StudentTest PRIMARY KEY (RN, TestID);

ALTER TABLE Test
ADD CONSTRAINT UQ_Test_Name UNIQUE (Name);

ALTER TABLE Test
DROP CONSTRAINT UQ_Test_Name;
-- 1
SELECT 
    s.Name, 
    t.Name AS TestName, 
    st.Mark, 
    st.Date
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
JOIN Test t ON st.TestID = t.TestID;
-- 2
SELECT s.Name
FROM Student s
WHERE s.RN NOT IN (SELECT DISTINCT RN FROM StudentTest);
-- 3
SELECT 
    s.Name, 
    t.Name AS TestName, 
    st.Mark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
JOIN Test t ON st.TestID = t.TestID
WHERE st.Mark < 5;
-- 4
SELECT 
    s.Name, 
    ROUND(AVG(st.Mark), 2) AS AverageMark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
GROUP BY s.Name
ORDER BY AverageMark DESC;
-- 5
WITH AvgMarks AS (
    SELECT 
        s.Name, 
        ROUND(AVG(st.Mark), 2) AS AverageMark
    FROM Student s
    JOIN StudentTest st ON s.RN = st.RN
    GROUP BY s.Name
)
SELECT Name, AverageMark
FROM AvgMarks
WHERE AverageMark = (SELECT MAX(AverageMark) FROM AvgMarks);
-- 6
SELECT 
    t.Name AS TestName, 
    MAX(st.Mark) AS MaxMark
FROM Test t
JOIN StudentTest st ON t.TestID = st.TestID
GROUP BY t.Name
ORDER BY t.Name;
-- 7
SELECT 
    s.Name AS StudentName, 
    t.Name AS TestName
FROM Student s
LEFT JOIN StudentTest st ON s.RN = st.RN
LEFT JOIN Test t ON st.TestID = t.TestID;
-- 8
UPDATE Student SET Age = Age + 1;
ALTER TABLE Student ADD Status VARCHAR(10);
-- 9
UPDATE Student 
SET Status = CASE 
    WHEN Age < 30 THEN 'Young'
    ELSE 'Old'
END;

SELECT * FROM Student;
-- 10
SELECT 
    s.Name, 
    t.Name AS TestName, 
    st.Mark, 
    st.Date
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
JOIN Test t ON st.TestID = t.TestID
ORDER BY st.Date; 
-- 11
SELECT 
    s.Name, 
    s.Age, 
    ROUND(AVG(st.Mark), 2) AS AverageMark
FROM Student s
JOIN StudentTest st ON s.RN = st.RN
WHERE s.Name LIKE 'T%'
GROUP BY s.Name, s.Age
HAVING AVG(st.Mark) > 4.5;
-- 12
WITH RankedStudents AS (
    SELECT 
        s.RN,
        s.Name, 
        s.Age, 
        ROUND(AVG(st.Mark), 2) AS AverageMark,
        DENSE_RANK() OVER (ORDER BY AVG(st.Mark) DESC) AS Ranking
    FROM Student s
    JOIN StudentTest st ON s.RN = st.RN
    GROUP BY s.RN, s.Name, s.Age
)
SELECT * FROM RankedStudents;
-- 13
ALTER TABLE Student
-- modify  Name NVARCHAR(MAX);  nvarchar(max) em khong dung duoc trong mysql
MODIFY  Name VARCHAR(65535);
-- 14
UPDATE Student 
SET Name = 'Old ' + Name 
WHERE Age > 20;

--  15
UPDATE Student 
SET Name = 'Young ' + Name 
WHERE Age <= 20;
-- 16
DELETE FROM Test 
WHERE TestID NOT IN (SELECT DISTINCT TestID FROM StudentTest);
-- 17
DELETE FROM StudentTest 
WHERE Mark < 5;
