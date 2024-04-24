create database QuanLiDiem1;
use QuanLiDiem1;

CREATE TABLE class (
                       id INT PRIMARY KEY,
                       className VARCHAR(100),
                       startDate DATE,
                       status BIT
);

CREATE TABLE student (
                         id INT PRIMARY KEY,
                         studentName VARCHAR(100),
                         address VARCHAR(255),
                         phone VARCHAR(11),
                         status BIT,
                         class_id INT,
                         FOREIGN KEY (class_id) REFERENCES class(id)
);

CREATE TABLE subject (
                         id INT PRIMARY KEY,
                         subjectName VARCHAR(100),
                         credit INT,
                         status BIT
);

CREATE TABLE mark (
                      id INT PRIMARY KEY,
                      subject_id INT,
                      student_id INT,
                      point DOUBLE,
                      examTime DATETIME,
                      FOREIGN KEY (subject_id) REFERENCES subject(id),
                      FOREIGN KEY (student_id) REFERENCES student(id)
);

-- Insert data into `class`
INSERT INTO class (id, className, startDate, status) VALUES
                                                         (1, 'Mathematics 101', '2024-01-10', 1),
                                                         (2, 'History 201', '2024-02-15', 1),
(3, 'History 201', '2024-02-15', 1);
-- ... add more rows as needed

-- Insert data into `student`
INSERT INTO student (id, studentName, address, phone, status, class_id) VALUES
    (1, 'John Doe', '123 Main St', '555-1234', 1, 1),
    (2, 'Jane Smith', '456 High St', '555-5678', 1, 2),
(3, 'Jane Smith', '456 High St', '555-5678', 1, 2);
-- ... add more rows as needed

-- Insert data into `subject`
INSERT INTO subject (id, subjectName, credit, status) VALUES
    (1, 'Calculus', 4, 1),
    (2, 'World History', 3, 1),
(3, 'World Physical', 3, 1);
-- ... add more rows as needed

-- Insert data into `mark`
INSERT INTO mark (id, subject_id, student_id, point, examTime) VALUES
    (1, 1, 1, 85.5, '2024-05-20 09:00:00'),
    (2, 2, 2, 92.0, '2024-05-22 13:30:00');
-- ... add more rows as needed
#1
select * from class where className like '%His%';

#2
select
    ST.*
    from student ST
join mark m on ST.id = m.student_id
join subject s on m.subject_id = s.id
where s.subjectName like '%Cal%';

#3
select st.*, avg(point)

    from student ST
join mark m on ST.id = m.student_id
    group by st.id
having avg(point) > 5;

#4

select st.* from student st where st.id not in (select mark.student_id from mark) ;
