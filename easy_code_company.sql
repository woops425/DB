show databases;
CREATE DATABASE company;
select database();
USE company;

create table DEPARTMENT(
id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL UNIQUE,
leader_id INT
);

create table EMPLOYEE (
id INT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
birth_date DATE,
sex char(1) CHECK (sex in ('M','F')),
position VARCHAR(10),
salary INT DEFAULT 50000000,
dept_id INT,
FOREIGN KEY (dept_id) references DEPARTMENT(id)
--  CASCADE : 참조값의 삭제/변경을 그대로 반영 | SET NULL : 참조값이 삭제/변경 시 NULL로 변경 | RESTRICT : 참조값이 삭제/변경 되는 것을 금지
on delete SET NULL on update CASCADE,
CHECK (salary >= 50000000)
);

create table PROJECT (
id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL UNIQUE,
leader_id INT,
start_date DATE,
end_date DATE,
FOREIGN KEY(leader_id) references EMPLOYEE(id)
on delete SET NULL on update CASCADE,
CHECK(start_date < end_date)
);

create table WORKS_ON (
empl_id INT,
proj_id INT,
PRIMARY KEY(empl_id, proj_id),
FOREIGN KEY(empl_id) references EMPLOYEE(id)
on delete CASCADE on update CASCADE,
FOREIGN KEY(proj_id) references PROJECT(id)
on delete CASCADE on update CASCADE
);

alter table department ADD FOREIGN KEY(leader_id)
references employee(id)
on update cascade
on delete SET NULL;

insert into employee
values(1, 'MESSI', '1987-02-01', 'M', 'DEV_BACK', 100000000, null);

insert into employee
values(2, 'JANE', '1996-05-05', 'F', 'DSGN', 90000000, null);

show create table employee;

-- 애트리뷰트 이름을 나열할 경우, 값을 넣는 순서에 자유도가 생기고, 실제로 넣고 싶은 애트리뷰트에 대해서만 값을 넣어주는 것이 가능해짐
insert into employee(name, birth_date, sex, position, id)
values('JENNY', '2000-10-12','F', 'DEV_BACK',3);

select *
from employee;

insert into employee values
(4, 'BROWN', '1996-03-13', 'M', 'CEO', '120000000', null),
(5, 'DINGYO', '1990-11-05', 'M', 'CTO', '120000000', null),
(6, 'JULIA', '1986-12-11', 'F', 'CFO', '120000000', null),
(7, 'MINA', '1993-06-17', 'F', 'DSGN', '80000000', null),
(8, 'JOHN', '1999-10-22', 'M', 'DEV_FRONT', '65000000', null),
(9, 'HENRY', '1982-05-20', 'M', 'HR', '82000000', null),
(10, 'NICOLE', '1991-03-26', 'F', 'DEV_FRONT', '90000000', null),
(11, 'SUZANNE', '1993-03-23', 'F', 'PO', '75000000', null),
(12, 'CURRY', '1998-01-15', 'M', 'PLN', '85000000', null),
(13, 'JISUNG', '1989-07-07', 'M', 'PO', '90000000', null),
(14, 'SAM', '1992-08-04', 'M', 'DEV_INFRA', '70000000', null);

insert into department values
(1001, 'headquarter', 4),
(1002, 'HR', 6),
(1003, 'development', 1),
(1004, 'design', 3),
(1005, 'product', 13);

select *
from department;

insert into project values
(2001, '쿠폰 구매/선물 서비스 개발', 13, '2022-03-10', '2022-07-09'),
(2002, '확장성 있게 백엔드 리팩토링', 13, '2022-01-23', '2022-03-23'),
(2003, '홈페이지 UI 개선', 11, '2022-05-09', '2022-06-11');

select *
from project;

insert into works_on values
(5, 2001),
(13, 2001),
(1, 2001),
(8, 2001),
(3, 2001),
(9, 2001),
(11, 2001),
(5, 2002),
(4, 2002),
(6, 2002),
(14, 2002),
(10, 2002),
(4, 2003),
(13, 2003),
(7, 2003),
(2, 2003),
(12, 2003);

update employee 
set dept_id = 1003 
where id = 1;

select *
from employee
where id = 1;

update employee 
set dept_id = 1001
where id = 2;

update employee 
set dept_id = 1002 
where id = 3;

update employee 
set dept_id = 1003 
where id = 4;

update employee 
set dept_id = 1004 
where id = 5;

update employee 
set dept_id = 1005 
where id = 6;

update employee 
set dept_id = 1001 
where id = 7;

update employee 
set dept_id = 1002 
where id = 8;

update employee 
set dept_id = 1003 
where id = 9;

update employee 
set dept_id = 1004 
where id = 10;

update employee 
set dept_id = 1005 
where id = 11;

update employee 
set dept_id = 1001 
where id = 12;

update employee 
set dept_id = 1002 
where id = 13;

update employee 
set dept_id = 1003 
where id = 14;

select *
from employee;

select *
from works_on;

-- 프로젝트 ID 2003에 참여한 임직원의 연봉을 두 배로 인상! 
update employee, works_on
set salary = salary * 2
where id = empl_id and proj_id  = 2003;

-- 개발부서 ID 1003인 임직원의 연봉을 두 배로 인상! 
update employee
set salary = salary * 2
where dept_id = 1003;

-- 회사의 모든 구성원의 연봉을 두 배로 인상!(where 절이 없다는 것이 특징)
SET SQL_SAFE_UPDATES = 0;  -- 안전 모드 비활성화

UPDATE employee 
SET salary = salary * 2;

SET SQL_SAFE_UPDATES = 1;  -- 안전 모드 다시 활성화

-- JOHN이 퇴사했을 때, employee 테이블에서 JOHN의 정보를 삭제하기 위한 SQL문.
-- JOHN은 project 2001에 참여하고 있지만, 처음 테이블 설정 시 외래키로 설정하여 CASCADE로 설정했기 때문에 works_on 테이블까지 삭제할 필요 없이 자동 삭제 
DELETE FROM employee
WHERE id = 8;

-- JANE이 프로젝트에서 중도하차 -> works_on 테이블에서 JANE의 ID인 empl_id는 2인 것을 삭제 
DELETE FROM works_on
where empl_id = 2;

-- DINGYO는 2002 프로젝트에서 빠지고, 2001 프로젝트에만 집중하기로 함. ID는 5
DELETE FROM works_on
WHERE empl_id = 5
and proj_id = 2002;

-- 여러 프로젝트에 참여한 사람의 경우, 매번 이렇게 하나하나 프로젝트를 삭제할 필요 x -> 2001 프로젝트를 제외한 모든 프로젝트에서 제외시키는 코드
DELETE FROM works_on
WHERE empl_id = 5
and proj_id <> 2001; --      <>    ==    != 
-- and proj_id != 2001;

-- 모든 프로젝트를 삭제할 경우? -> where절이 없으므로, project에 있는 모든 튜플이 삭제됨. where절이 없는 경우는 모든 튜플이 바뀌거나, 삭제되는 경우.
DELETE FROM project;  

-- ID가 9인 임직원의 이름과 직급을 알고싶을 때, (id = 9라는 조건을 설정하는 것을 selection condition 이라고 함)
-- 여기서 내가 알고싶은 애트리뷰트는 name, position인데, 이때 얘네를 projection attributes 라고 함  
select name, position
from employee
where id = 9; 

-- project 2002를 리드하는 임직원의 ID, 이름을 알고싶다?
-- join condition + selection condition 
select e.id as leader_id, e.name as leader_name, position
from employee e, project p
where  e.id = p.leader_id
and p.id = 2002;

-- 디자이너들이 참여하고있는 프로젝트들의 ID와 이름을 알고싶을 때? DISTNCT : 중복 제거
select distinct p.id, p.name
from employee e, works_on w, project p
where e.id = w.empl_id
and w.proj_id = p.id
and e.position = 'DSGN';


-- 이름이 N으로 시작하거나, N으로 끝나는 임직원의 이름?
select name
from employee
where name like 'N%' or name like '%N';

-- 이름에 NG가 들어가는 임직원의 이름
select name
from employee
where name like '%NG%';

-- 이름이 J로 시작하는, 총 4글자의 이름을 가지는 임직원들의 이름
select name
from employee
where name like 'J___';

select *
from employee;

-- %로 시작하거나 _로 끝나는 프로젝트 이름을 찾을 때 : \% | \_.  **-> '\' < escape 문자
select name
from project
where name like '\%%' or name like '%\_';
 
-- *(asterisk) 사용
-- id가 9인 임직원의 모든 애트리뷰트를 알고싶을 때 
select *
from employee
where id = 9;

select *
from project p, employee e
where p.leader_id = e.id
and p.id = 2002;

-- 모든 임직원의 이름과 생일을 알고싶을 때
select name, birth_date
from employee;

