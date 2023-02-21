use quanlysinhvien;
select max(Credit) from subject;
select subject.SubName, max(Mark) 
from subject join mark on subject.SubId = mark.SubId
group by subject.SubName, subject.SubId;

select student.StudentName, student.StudentId,  AVG(Mark) 
from student join mark on student.StudentId =  mark.StudentId
group by student.StudentId, student.StudentName
-- order by AVGmark desc;
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM mark GROUP BY mark.StudentId);

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);