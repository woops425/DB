create database KOREA_UNIV;
show databases;
show tables;
use korea_univ;
show tables;

create table student(SID INT(10) NOT NULL, NAME varchar(30)
not null);
show tables;
create table professor (PID INT(10) NOT NULL,
NAME varchar(30) NOT NULL);
create table lecture(LID INT(10) NOT NULL,
NAME varchar(50) NOT NULL,
SEMESTER varchar(10) NOT NULL, CREDIT INT(1) NOT NULL);
DESC lecture;
show databases;
show tables;
desc class;