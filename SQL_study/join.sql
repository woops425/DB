-- implicit join / explicit join
-- id가 1인 임직원이 속한 부서의 이름?
select d.name
from employee e, department d
where e.dept_id = d.id
and e.id = 1;
-- implicit join : from절에는 테이블들만 나열하고, where절에 join condition을 명시하는 방식
-- 구식 join 방식. where절에 selection condition과 join condition이 같이 있기 때문에 가독성이 떨어짐

-- exlpicit join : from절에 join 키워드와 함께 joined table들을 명시하는 방식
-- from절에서 on 뒤에 join condition이 명시됨. 가독성이 좋고, 복잡한 join 쿼리 작성 중에도 실수할 가능성이 적다  
select d.name
from employee e join department d on e.dept_id = d.id
where e.id = 1;


-- inner join / outer join
select *
from employee e join department d on e.dept_id = d.id; 

-- inner join : 두 테이블에서 join condition을 만족하는 튜플들로 result table을 만드는 조인 방식
-- from table1 [INNER] JOIN table2 ON join_condition
-- join condition에 사용 가능한 연산자 : =, <, >, != 등 여러 비교 연산자 사용 가능
-- ** join condition에서 null 값을 갖는 튜플은 result table에 포함되지 못함

-- outer join : 두 테이블에서 join condition을 만족하지 않는 튜플들도 result table에 포함하는 조인 방식
-- from table1 LEFT [OUTER] JOIN table2 ON join_condition      
-- from table1 RIGHT [OUTER] JOIN table2 ON join_condition      
-- from table1 FULL [OUTER] JOIN table2 ON join_condition      
-- join condition에 사용 가능한 연산자 : =, <, >, != 등 여러 비교 연산자 사용 가능
select *
from employee e left join department d on e.dept_id = d.id; 
select *
from employee e right join department d on e.dept_id = d.id; 
-- mysql에서는 직접적으로 full outer join을 지원하지 않음 
-- select *
-- from employee e FULL OUTER JOIN department d ON e.dept_id = d.id; 

-- equi join : join condition에서 '='를 사용하는 조인 방식

-- USING : 두 테이블이 equi join 할 때, 조인하는 애트리뷰트의 이름이 같다면, USING으로 간단하게 작성할 수 있음
-- 이 때, 같은 이름의 애트리뷰트는 result table에서 한 번만 표시됨
-- from table1 [INNER] JOIN table2 USING (attributes)  
-- from table1 LEFT [OUTER] JOIN table2 USING (attributes)  
select *
from employee e join department d using (dept_id);  


alter table department
change column dept_id id INT;
alter table department
change column dept_name name VARCHAR(20);
select *
from department;
-- natural join : 두 테이블에서 같은 이름을 가지는 모든 애트리뷰트 쌍에 대해서 equi join을 수행
-- join condition을 따로 명시하지 않는 것이 특징
-- from table1 NATURAL [INNER] JOIN table2   
-- from table1 NATURAL LEFT [OUTER] JOIN table2
select *
from employee e natural join department d;


-- cross join : 두 테이블의 tuple pair로 만들 수 있는 모든 조합(cartesian product)을 result table로 반환함
-- join condition이 없음
-- implicit cross join : from table1, table2 
-- explicit cross join : from table1 CROSS JOIN table2 
select *
from employee cross join department; 
select *
from employee, department;

-- id가 1003인 부서에 속하는 임직원 중, 리더를 제외한 부서원의 id, 이름, 연봉을 알고싶을 때?
select e.id, e.name, e.salary
from employee e
join department d
on e.dept_id = d.id
where e.dept_id = 1003
and e.id != d.leader_id;

select * from department;
select * from employee;
select * from works_on;
-- id가 2001인 프로젝트에 참여한 임직원들의 이름과 직군, 소속 부서 이름을 알고싶을 때?
select e.name as 이름, e.position as 직군, d.name as 소속부서
from employee e
join works_on w
on e.id = w.empl_id
left join department d -- **e.dept_id가 null일 경우에도 employee 정보가 남아 있을 수 있기 때문에 left join을 해야함**
on e.dept_id = d.id
where w.proj_id = 2001;
