-- Bước 1: Tạo CSDL QuanLySinhVien
CREATE DATABASE QuanLySinhVien;
-- Bước 2: Chọn Database QuanLySinhVien để thao tác với cơ sở dữ liệu này:
USE QuanLySinhVien;
-- Bước 3: Tiếp theo sử dụng câu lệnh Create Table để tạo bảng Class với các trường ClassId, ClassName, StartDate, Status như sau:
CREATE TABLE Class
(
    ClassID   INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
-- Bước 4: Tạo bảng Student với các thuộc tính StudentId, StudentName, Address, Phone, Status, ClassId với rằng buộc như sau:
CREATE TABLE Student
(
    StudentId   INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
-- Bước 5: Tạo bảng Subject với các thuộc tính SubId, SubName, Credit, Status với các ràng buộc như sau :
CREATE TABLE Subject
(
    SubId   INT AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);
-- Bước 6: Tạo bảng Mark với các thuộc tính MarkId, SubId, StudentId, Mark, ExamTimes với các ràng buộc như sau :
CREATE TABLE Mark
(
    MarkId    INT AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

INSERT INTO Class (ClassName, StartDate, Status) VALUES
                                                     ('Mathematics 101', '2024-09-01 08:00:00', 1),
                                                     ('History 201', '2024-09-02 09:00:00', 1),
                                                     ('Science 301', '2024-09-03 10:00:00', 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId) VALUES
                                                                       ('John Doe', '1234 Elm St', '123-456-7890', 1, 1),
                                                                       ('Jane Smith', '2345 Oak St', '234-567-8901', 1, 2),
                                                                       ('Alice Johnson', '3456 Pine St', '345-678-9012', 1, 3);
INSERT INTO Subject (SubName, Credit, Status) VALUES
                                                  ('Calculus', 3, 1),
                                                  ('World History', 2, 1),
                                                  ('Physics', 4, 1);
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes) VALUES
                                                         (1, 1, 95, 1),
                                                         (2, 1, 88, 1),
                                                         (3, 1, 92, 1),
                                                         (1, 2, 78, 1),
                                                         (2, 2, 85, 1),
                                                         (3, 3, 90, 1);

#1
select *
from Subject s

order by Credit desc
limit 1;

#2
select *
from Mark M
order by Mark desc
limit 1;

#3
select *, avg(m.Mark) as avg
from Student s
join Mark M on s.StudentId = M.StudentId
group by s.StudentId
order by avg desc;



