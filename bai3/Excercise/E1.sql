use quanlisinhvien;
select * from student where StudentName like 'h%';
SELECT ClassName, StartDate from class where month(StartDate) = '12';
select *  from subject where Credit > 5  ;
select student.StudentName, subject.SubName , mark 
from student,mark,subject 
order by mark desc, StudentName