show databases;
CREATE database db24_4;
show databases;

USE db24_4;
show tables;
CREATE table STUDENT (
SNO integer not null,
SNAME char(10),
YEAR integer,
DEPT char(12),
primary key(SNO)
);

show tables;
desc STUDENT;

select * from STUDENT;
select SNAME, SNO from STUDENT where DEPT = '컴퓨터';

INSERT into STUDENT values (100, '박상우1', 4, '컴퓨터');
INSERT into STUDENT values (200, '박상우2', 3, '전기');
INSERT into STUDENT values (300, '박상우3', 1, '컴퓨터');
INSERT into STUDENT values (400, '박상우4', 4, '컴퓨터');
INSERT into STUDENT values (500, '박상우5', 2, '산공');

create table COURSE(
CNO char(4) not null,
CNAME char(20),
CREDIT integer,
DEPT char(12),
PRNAME char(10),
primary key (CNO)
);
select * from COURSE;

desc COURSE;
show tables;

insert into COURSE values ('C123', '프로그래밍', 3, '컴퓨터', '김성기');
insert into COURSE values ('C312', '자료구조', 3, '컴퓨터', '황수찬');
insert into COURSE values ('C324', '파일처리', 3, '컴퓨터', '이규철');
insert into COURSE values ('C413', '데이타베이스', 3, '컴퓨터', '이석호');
insert into COURSE values ('E412', '반도체', 3, '전자', '홍봉희');

create table ENROL (
SNO integer not null,
CNO char (4) not null,
GRADE char(2),
MIDTERM integer,
FINAL integer,
primary key (SNO, CNO),
foreign key (SNO) references STUDENT(SNO),
foreign key (CNO) references COURSE(CNO)
);

desc ENROL;
show tables;

insert into ENROL values (100, 'C413', 'A', 90, 95);
insert into ENROL values (100, 'E412', 'A', 95, 95);
insert into ENROL values (200, 'C123', 'B', 85, 80);
insert into ENROL values (300, 'C312', 'A', 90, 95);
insert into ENROL values (300, 'C324', 'C', 75, 75);
insert into ENROL values (300, 'C413', 'A', 95, 90);
insert into ENROL values (400, 'C312', 'A', 90, 95);
insert into ENROL values (400, 'C324', 'A', 95, 90);
insert into ENROL values (400, 'C413', 'B', 80, 85);
insert into ENROL values (400, 'E412', 'C', 65, 75);
insert into ENROL values (500, 'C312', 'B', 85, 80);

select * from ENROL;
select SNO from ENROL where MIDTERM > 90;
select DEPT from STUDENT;
select * from STUDENT;
select DISTINCT DEPT FROM STUDENT;

select SNO, SNAME FROM STUDENT WHERE DEPT = '컴퓨터' AND (YEAR = 4);
select SNO, CNO FROM ENROL WHERE MIDTERM >= 90 ORDER BY SNO DESC, CNO ASC;
select SNO AS 학번, '중간시험 =' AS 시험, MIDTERM + 3 AS 점수 FROM ENROL WHERE CNO = 'C312';

select STUDENT.SNAME, STUDENT.DEPT, ENROL.GRADE
FROM STUDENT, ENROL 
WHERE STUDENT.SNO = ENROL.SNO AND ENROL.CNO = 'C413';

SELECT S1.SNO, S2.SNO
FROM STUDENT S1, STUDENT S2
WHERE S1.DEPT = S2.DEPT AND S1.SNO < S2.SNO; 

SELECT COUNT(*) AS 학생수
FROM STUDENT;

SELECT COUNT(DISTINCT CNO)
FROM ENROL
WHERE SNO = '300';

SELECT CNO, AVG(FINAL) AS 기말평균
FROM ENROL
GROUP BY CNO;

SELECT CNO, AVG(FINAL) AS '3학년 이상 기말평균'
FROM STUDENT, ENROL
WHERE STUDENT.YEAR > 2
GROUP BY CNO;

SELECT CNO, AVG(FINAL) AS 평균
FROM ENROL
GROUP BY CNO
HAVING COUNT(*) >= 3;

SELECT SNAME
FROM STUDENT
WHERE SNO IN(SELECT SNO FROM ENROL WHERE CNO = 'C413');

SELECT CNO, CNAME
FROM COURSE
WHERE CNO LIKE 'C%'; 

DELETE FROM COURSE
WHERE CNO = 'C412';

SELECT SNO, SNAME
FROM STUDENT
WHERE DEPT IS NULL;

SELECT SNAME
FROM STUDENT
WHERE EXISTS(SELECT * FROM ENROL WHERE SNO = STUDENT.SNO AND CNO = 'C413');

SELECT SNO
FROM STUDENT
WHERE YEAR = 1
UNION
SELECT SNO
FROM ENROL
WHERE CNO = 'C324';

-- 데이타베이스, 반도체 모두 듣는 학생의 학번
SELECT e1.SNO
FROM ENROL e1, ENROL e2, COURSE c1, COURSE c2
WHERE e1.CNO = c1.CNO
AND c1.CNAME = '데이타베이스'
AND e2.CNO = c2.CNO
AND c2.CNAME = '반도체'
AND e1.SNO = e2.SNO;

SELECT s.SNAME, e.final
FROM STUDENT s, ENROL e, COURSE c
WHERE s.SNO = e.SNO
AND c.CNO = e.CNO
AND e.cno = 'C413';