use quanlysinhvien;
select max(Credit) from subject;
select subject.SubName, max(Mark) 
from subject join mark on subject.SubId = mark.SubId
group by subject.SubName, subject.SubId;

-- select student.StudentId,student.StudentName,avg(Mark)
-- from student 
-- inner join mark on student.StudentID= mark.StudentId
-- inner join subject on mark.SubId = subject.SubId
-- group by student.StudentId,student.StudentName, mark.Mark;

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

