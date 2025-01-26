show databases;
use hw4;
show tables;

create table student (
sno integer not null,
sname char(20),
year integer,
dept char(20),
primary key(sno)
);

show tables;
desc student;

create table course (
cno char(10) not null,
cname char(20),
credit integer,
dept char(20),
prname char(30),
primary key (CNO)
);

show tables;
desc course;

create table enrol (
sno integer not null,
cno char (4) not null,
grade char(2),
midterm integer,
finalterm integer,
primary key (sno, cno),
foreign key (sno) references student(sno),
foreign key (cno) references course(cno)
);

show tables;
desc enrol;

INSERT into student values (100, '박상우01', 4, '애니');
INSERT into student values (200, '박상우02', 3, '전기');
INSERT into student values (300, '박상우03', 1, '컴퓨터');
INSERT into student values (400, '박상우04', 4, '컴퓨터');
INSERT into student values (500, '박상우05', 2, '공간환경');
INSERT into student values (600, '박상우06', 1, '글로벌경영');
INSERT into student values (700, '박상우07', 3, '경영');
INSERT into student values (800, '박상우08', 2, '글로벌경영');
INSERT into student values (900, '박상우09', 3, '영어교육');
INSERT into student values (1000, '박상우10', 4, '화에공');

select * from student;

insert into COURSE values ('C123', '프로그래밍', 3, '컴퓨터', '교수박상우01');
insert into COURSE values ('C312', '미시경제학', 3, '경영', '교수박상우02');
insert into COURSE values ('C324', '혁신경영', 3, '글로벌경영', '교수박상우03');
insert into COURSE values ('C413', 'DB', 3, '컴퓨터', '교수박상우04');
insert into COURSE values ('E412', 'AI', 3, '컴퓨터', '교수박상우05');

select * from course;

insert into enrol values (100, 'C413', 'A', 90, 95);
insert into enrol values (100, 'C123', 'B', 80, 80);
insert into enrol values (100, 'E412', 'A', 95, 95);
insert into enrol values (200, 'C123', 'B', 85, 80);
insert into enrol values (300, 'C312', 'A', 90, 95);
insert into enrol values (300, 'C324', 'C', 75, 75);
insert into enrol values (300, 'C413', 'A', 95, 90);
insert into enrol values (300, 'E412', 'A', 95, 95);
insert into enrol values (400, 'C312', 'A', 90, 95);
insert into enrol values (400, 'C324', 'A', 95, 90);
insert into enrol values (400, 'C413', 'B', 80, 85);
insert into enrol values (400, 'E412', 'C', 65, 75);
insert into enrol values (500, 'C312', 'B', 85, 80);
insert into enrol values (500, 'C324', 'A', 95, 90);
insert into enrol values (600, 'C312', 'A', 95, 95);
insert into enrol values (600, 'C324', 'A', 95, 90);
insert into enrol values (600, 'C413', 'A', 95, 85);
insert into enrol values (1000, 'E412', 'B', 80, 80);

select * from enrol;

-- 3. 컴퓨터학과에서 개설한 3학점짜리 과목의 이름과 과목번호를 모두 검색하라.
select cno, cname
from course
where credit = 3 AND dept = '컴퓨터';

-- 4. A 학점을 받은 학생의 이름과 그 과목 이름을 구하라. 
select s.sname , c.cname
from enrol e, student s, course c
where grade = 'A' AND e.sno = s.sno AND e.cno = c.cno;
-- ORDER BY s.sname ASC, c.cname ASC;

-- 5. 강의를 하나도 듣지 않는 학생들의 학번을 출력하라.
select s.sno
from student s
where NOT EXISTS (
select * 
from enrol e
where e.sno = s.sno);

-- 모든 과목을 수강하는 학생의 학번을 구하라.(하나라도 안 듣는 과목이 없는)
SELECT s.sno
FROM student s
WHERE NOT EXISTS (
SELECT *
FROM course c
WHERE NOT EXISTS (
SELECT *
FROM enrol e
WHERE s.sno = e.sno
AND c.cno = e.cno));

-- 6. 기말고사 성적 평균이 80을 넘는 과목을 강의하는 교수들의 이름과 해당 교과목을 검색하라.
select c.prname, c.cname
from course c, enrol e
where c.cno = e.cno
group by c.prname, c.cname
Having AVG(e.finalterm) > 80;

-- 7. 각 학생별 성적평균을 구하라. (학번, 이름, 중간고사 평균, 기말고사 평균) 
						(예:  100 홍길동03   67.0 	78.3)
select s.sno as '학번', s.sname as '이름', AVG(e.midterm) as '중간고사 평균', AVG(e.finalterm) as '기말고사 평균'
from student s, enrol e
where s.sno = e.sno
group by s.sno;

-- 8. 각 학생별 이수학점(수강한 과목 학점수 합계)을 구하라. 
select e.sno AS '학번', SUM(c.credit) as '이수학점'
from  enrol e, course c
where e.cno = c.cno
group by e.sno;

SELECT s.sno AS '학번', s.sname AS '이름', SUM(c.credit) AS '이수학점'
FROM student s, enrol e, course c
WHERE s.sno = e.sno
AND c.cno = e.cno
GROUP BY s.sno;

-- 9. “DB” 과목과 “AI” 과목을 동시에 듣고 있는 학생들의 학번을 검색하라.
select e1.sno
from enrol e1, enrol e2
where e1.sno = e2.sno AND e1.cno = 'C413' AND e2.cno = 'E412';
-- 이렇게도 풀 수 있음! 
SELECT e1.sno
FROM enrol e1, enrol e2, course c1, course c2
WHERE (e1.cno = c1.cno
AND c1.cname = 'DB') 
AND (e2.cno = c2.cno 
AND c2.cname = 'AI') 
AND e1.sno = e2.sno;

SELECT * FROM course;

-- 10. 컴퓨터학과 교과목을 듣고 있는 다른 학과 학생수를 구하라. 
select COUNT(DISTINCT e.sno) as '학생 수'
from enrol e, course c
where e.cno = c.cno AND c.dept = '컴퓨터' AND sno NOT IN(
select s.sno
from student s
where dept = '컴퓨터');

-- VIEW 생성 : 컴퓨터학과 학생의 학번, 이름, 학년만 보이는 VIEW
CREATE VIEW vstudent(sno, sname, year)
AS SELECT s.sno, s.sname, s.year
FROM student s
WHERE s.dept = '컴퓨터';

desc vstudent;
select * from vstudent;

CREATE VIEW HONOR(sname, dept, final)
AS SELECT s.sname, s.dept, e.finalterm
FROM student s, enrol e
WHERE s.sno = e.sno
AND e.finalterm > 95;

desc HONOR;
select * from HONOR;

-- 모든 강의를 다 듣는 학생의 학번(안 듣는 과목이 없는)
SELECT s.sno
FROM student s
WHERE NOT EXISTS(
SELECT *
FROM course c
WHERE NOT EXISTS(
SELECT *
FROM enrol e
WHERE e.sno = s.sno
AND e.cno = c.cno));

