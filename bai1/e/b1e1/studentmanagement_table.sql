CREATE DATABASE studentmanagement;
create table studentmanagement_student
(
idStudent INT NOT NULL ,
name varchar(20) NOT NULL,
age INT NOT NULL,
country INT NOT NULL,
primary key (idStudent)
);
create table Class(
idClass INT primary key ,
name varchar(45)

);
create table Teacher(
idTeacher varchar(45) primary key ,
name varchar(45),
age date,
country varchar(10));