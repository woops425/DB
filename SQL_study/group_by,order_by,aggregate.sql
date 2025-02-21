use company;
-- 부서, 사원, 프로젝트 관련 정보들을 저장할 수 있는 RDB 만들기
-- ORDER BY : 조회 결과를 특정 애트리뷰트 기준으로 정렬하여 가져오고 싶을 때 사용
-- default 정렬 방식은 오름차순임. 오름차순 정렬 방식의 표기는 ASC, 내림차순은 DESC

-- ORDER BY를 활용하여, 임직원들의 연봉 정보 확인?
select *
from employee e
order by e.salary desc;

select *
from employee e
order by dept_id,
salary desc;


-- aggregate function : 여러 튜플들의 정보를 요약해서 하나의 값으로 추출하는 함수. COUNT, SUM, MAX, MIN, AVG 함수 등이 있음
-- NULL 값들은 제외하고 요약 값을 추출함

-- 임직원의 수를 알고싶을 때?
select count(*) -- 괄호 안의 *의 의미 : 튜플의 수 
from employee; 

select count(position) -- 중복을 포함하여 카운트함 
from employee;

select count(dept_id) -- NULL값이 있을 경우, NULL값은 제외하고 튜플의 수를 카운트
from employee;

-- 프로젝트 2002에 참여한 임직원의 수와 최대 연봉, 최소 연봉과 평균 연봉을 알고싶을 때?
select count(*), max(salary), min(salary), avg(salary)
from works_on w join employee e on w.empl_id = e.id
where w.proj_id = 2002;


-- GROUP BY
-- 각 프로젝트에 참여한 임직원의 수와 최대 연봉, 최소 연봉과 평균 연봉을 알고싶을 때?
select w.proj_id, count(*) as 직원수, max(e.salary) 최대연봉, min(e.salary) as 최소연봉, avg(e.salary) as 평균연봉
from works_on w join employee e on w.empl_id = e.id
group by w.proj_id; -- group by로 묶은 내용에 대해 select에도 추가해줘야함 : 이를 기준으로 select를 한 것이기 때문
-- 관심있는 애트리뷰트 기준으로 그룹을 나눠서 그룹별로 aggregate function을 적용하고 싶을 때 사용
--  grouping attribute : 그룹을 나누는 기준이 되는 attribute
-- grouping attribute에 NULL값이 있을 때는 NULL값을 가지는 튜플끼리 묶인다


-- HAVING : group by를 사용했을 경우에 사용, group by로 묶은 그룹 중에서도 특별히 보고싶은 그룹이 있을 경우 사용
-- 프로젝트 참여 인원이 4명 이상인 프로젝트들에 대해서 각 프로젝트에 참여한 임직원 수와 최대 연봉, 최소 연봉과 평균 연봉을 알고싶을 떄?
select w.proj_id, count(*) as 임직원수, max(e.salary) as 최대연봉, min(e.salary) as 최소연봉, avg(e.salary) as 평균연봉
from works_on w join employee e on w.empl_id = e.id
group by w.proj_id
having count(*) >= 5;


-- 각 부서별 인원수를 인원 수가 많은 순서대로 정렬해서 알고싶을때?
select dept_id, count(*) as empl_count 
from employee
group by dept_id
order by empl_count desc; 

-- 각 부서별/성별 인원수를 인원 수가 많은 순서대로 정렬해서 알고싶을 떄
select dept_id, sex, count(*) as empl_count
from employee
group by dept_id, sex
order by empl_count desc;

-- 회사 전체의 평균 연봉보다 평균 연봉이 적은 부서들의 평균 연봉을 알고싶을 때
select dept_id as 부서, avg(salary)
from employee
group by dept_id
having avg(salary) < (
select avg(salary)
from employee
);


-- 각 프로젝트별로 프로젝트에 참여한 90년대생들의 수와 이들의 평균 연봉을 알고 싶을 때
select w.proj_id as 프로젝트명, count(*) as 90년대생, round(avg(e.salary), 0) as 평균연봉 -- 소수점 이하 반올림
from works_on w join employee e on w.empl_id = e.id
where e.birth_date between '1990-01-01' and '1999-12-31'
group by w.proj_id;

-- 프로젝트 참여 인원이 4명 이상인 프로젝트에 한정해서 각 프로젝트별로 프로젝트에 참여한 90년대생들의 수와 이들의 평균 연봉을 알고 싶을 때
select w.proj_id as 프로젝트명, count(*) as 90년대생, round(avg(e.salary), 0) as 평균연봉 -- 소수점 이하 반올림
from works_on w join employee e on w.empl_id = e.id
where e.birth_date between '1990-01-01' and '1999-12-31'
and w.proj_id in (
select proj_id
from works_on
group by proj_id having count(*) >= 4) -- group by 다음에 바로 having을 이용해 count(*) >= 4 이런 식으로 작성하면, 그것은 프로젝트 참여인원의 수에 대한 having이 아니라,
									   -- group by로 묶인 90년대생들의 수가 4 이상인 것에 대해 select 하는 것이므로 잘못된 방식임. 여기서는 sub query를 통해 작성해야 맞는 것!
group by w.proj_id
order by w.proj_Id;
