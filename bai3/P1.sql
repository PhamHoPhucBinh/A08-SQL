use quanlisinhvien;
insert into `class`
values (1, 'A1', '2008-12-20',1);
insert into `class`
values (2, 'A2', '2008-12-22',1);
insert into `class`
values (3,'B3', current_date , 0);
insert into student (StudentName, Address,Phone,Status,ClassID)
values ('Binh', 'DN','09233333333', 1 ,1 );
insert into student(StudentName,Address,Phone,ClassID)
values ('Quang','QN','0913444444',2);
insert into subject
values (1,'toan',7,1),(2,'van',9,1);
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);