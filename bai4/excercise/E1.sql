use quanlysinhvien;
select max(Credit) from subject;
select subject.SubName, max(Mark) 
from subject join mark on subject.SubId = mark.SubId
group by subject.SubName, subject.SubId;
select student.StudentId,student.StudentName,avg(Mark)
from student 
inner join mark on student.StudentID= mark.StudentId
inner join subject on mark.SubId = subject.SubId
group by student.StudentId,student.StudentName, mark.Mark;

