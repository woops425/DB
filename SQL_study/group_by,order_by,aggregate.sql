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