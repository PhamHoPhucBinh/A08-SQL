use quanlysinhvien;
select Address, count(StudentId) as 'amount of student'
from student
group by Address;
select student.StudentId,student.StudentName,AVG(Mark)
from student left join mark on student.StudentId = mark.StudentId
group by student.StudentId,student.StudentName;
select student.StudentId,student.StudentName,AVG(Mark)
from student left join mark on student.StudentId = mark.StudentId
group by student.StudentId,student.StudentName
HAVING AVG(Mark) > 5;
select student.StudentId,student.StudentName,AVG(Mark)
from student left join mark on student.StudentId = mark.StudentId
group by student.StudentId,student.StudentName
having AVG(Mark) >= ALL (select avg(Mark) from Mark group by Mark.StudentID);