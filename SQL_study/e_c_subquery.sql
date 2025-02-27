show databases;
CREATE DATABASE company;
select database();
USE company;

select name, birth_date
from employee;


-- ID가 14인 임직원보다 생일이 빠른 임직원의 ID, 이름, 생일을 알고싶을 때?
 select birth_date
 from employee
 where id = 14;
 
 select id, name, birth_date
 from employee
 where birth_date < '1992-08-04';
 
-- 위의 2개의 쿼리를 한 번에 진행하고 싶으면?
select id, name, birth_date
from employee
where birth_date < (
select birth_date
from employee
where id = 14
);

-- subquery : select, insert, update, delete에 포함된 query / outer query(main query) : subquery를 포함하는 query
-- subquery는 () 안에 기술됨

select *
from employee;

--  ID가 1인 임직원과 같은 부서, 같은 성별인 임직원들의 ID와 이름과 직군을 알고 싶을 때?
select e.id, e.name, e.position
from employee e
where (e.dept_id, e.sex) = (
select e.dept_id, e.sex
from employee e
where id = 1
);


select *
from works_on;
-- ** id가 4인 임직원과 같은 프로젝트에 참여한 임직원들의 id를 알고싶을 때 - 복습할 것
select w.proj_id
from works_on w
where w.empl_id = 4;

select distinct empl_id
from works_on w
where w.empl_id != 4
and (w.proj_id = 2002
or w.proj_id = 2003);

select distinct empl_id
from works_on w
where w.empl_id != 4
and w.proj_id 
in (2002, 2003);

select distinct empl_id
from works_on w
where w.empl_id != 4
and w.proj_id
in (select proj_id
from works_on w
where w.empl_id = 4
);

-- v IN (v1, v2, v3, ... ) 중에 하나와 값이 같다면 true를 return
-- (v1, v2, v3, ...)는 명시적인 값들의 집합일 수도 있고, subquery의 결과(set-중복 허용x / or multiset-중복 허용 o) 일수도 있음
-- v NOT IN (v1, v2, v3, ...) : (v1, v2, v3, ...)의 모든 값과 값이 다르다면 true를 return

select *
from employee;

select *
from works_on;
-- id가 4인 임직원과 같은 프로젝트에 참여한 임직원들의 id와 이름을 알고싶을 때? -> employee 테이블을 추가로 참조해줄 필요 있음
select e.id, e.name
from works_on w, employee e
where w.empl_id = e.id
and w.empl_id != 4
and w.proj_id
in (
select distinct w.proj_id
from works_on w
where w.empl_id = 4);


select e.id, e.name
from employee e
where e.id
in (
select distinct w.empl_id
from works_on w
where w.empl_id != 4 
and w.proj_id in (
select w.proj_id
from works_on w
where w.empl_id = 4)
);

-- 가상의 테이블을 만들어서 활용할 경우 (subquery는 where절 뿐만 아니라, from절에도 존재할 수 있다는 걸 보여주는 예시)
select e.id, e.name
from employee e, (
select distinct w.empl_id
from works_on w
where w.empl_id != 4
and w.proj_id in (
select w.proj_id
from works_on w
where w.empl_id = 4)
) as dstnct_e
where e.id = dstnct_e.empl_id;


select *
from project;
-- id가 7 혹은 12인 임직원이 참여한 프로젝트의 id와 이름을 알고싶을 때
select p.id, p.name
from project p
where exists (
select *
from works_on w
where w.proj_id = p.id
and w.empl_id in(7,12)
);

-- EXISTS 대신 IN을 사용한 쿼리문 
select p.id, p.name
from project p
where p.id IN (
select w.proj_id
from works_on w
where w.empl_id IN (7,12)
);

-- correlated query : 서브쿼리가 바깥쪽 쿼리의 애트리뷰트를 참조할 때, correlated subquery라고 부름
-- EXISTS : 서브쿼리의 결과가 최소 하나의 row라도 있다면 TRUE를 반환
-- NOT EXISTS : 서브쿼리의 결과가 단 하나의 row도 없을 때 TRUE를 반환


select *
from employee;

select *
from department;
show databases;

-- NOT EXISTS 를 통해 2000년대생이 없는 부서의 id와 부서 이름을 알고 싶을 때?
select d.id, d.name
from department d
where not exists (
select *
from employee e
where e.dept_id = d.id
and e.birth_date >= '2000-01-01'
);

-- NOT EXISTS 대신 NOT IN을 활용한 쿼리문
select d.id, d.name
from department d
where d.id NOT IN (
select e.dept_id
from employee e
where e.birth_date >= '2000-01-01'
);

show tables;
select *
from department;
select *
from employee;
select *
from works_on;
select * from project;
-- 부서의 리더보다 높은 연봉을 받는 부서원을 가진 리더의 id와 이름, 연봉을 알고싶을 때
select e.id, e.name, e.salary, d.name as 부서
from department d, employee e
where d.id = e.dept_id
and e.salary < any (
select salary
from employee
where dept_id = e.dept_id -- 바깥 쿼리에 있는 부서원의 정보와 같은. 즉, 같은 부서에 있음
and id != d.leader_id -- 그 부서원이 리더는 아니어야함
);

-- v 비교연산자(ex.<,>,=,!=,...) ANY (subquery) : subquery가 반환한 결과들 중에 단 하나라도 v와의 비교연산이 TRUE라면 TRUE를 반환
-- SOME도 ANY와 같은 역할을 함  

-- 위의 커리에 추가로, 해당 부서 최고 연봉도 알고싶으면? ** select 절에도 select-from-where절 쿼리가 추가될 수 있다!
select e.id, e.name, e.salary, (
select max(salary)
from employee
where dept_id = e.dept_id
) as dept_max_salary
from department d, employee e
where d.leader_id = e.id
and e.salary < ANY (
select salary
from employee
where dept_id = e.dept_id
and id != d.leader_id
);

-- ID가 13인 임직원과 한 번도 같은 프로젝트에 참여하지 못한 임직원들의 ID, 이름, 직군을 알고싶을 때
select e.id, e.name, e.position
from employee e, works_on w
where e.id = w.empl_id
and w.proj_id != ALL (
select proj_id
from works_on
where empl_id = 13
);
-- v 비교연산자 ALL (subquery) : subquery가 반환한 결과들과 v와의 비교 연산이 모두 TRUE라면 TRUE를 반환함

