use company;

select *
from employee;

-- NULL : unknown(알려지지 않은 값), unavailable/withheld(공개되지 않은 값, 이용 불가능한 값), not applicable(아예 없는 값-해당사항 없음의 의미)
select id
from employee
where birth_date is not NULL;
-- NULL값을 갖는 애트리뷰트에 대해 조회하고 싶을 땐, = null 꼴이 아니라, is null 혹은 in not null 꼴로 입력해야 조회가 올바르게 작동함

-- three valued logic과 null
-- SQL 쿼리문에서 NULL과 비교 연산을 하게 되면 그 결과는 TRUE나 FALSE가 아니라 UNKNOWN이 나옴
-- UNKNOWN은 'TRUE일수도 있고, FALSE일수도 있다'라는 의미
-- three-valued-logic : 비교/논리(and,or,not) 연산의 결과로 TRUE, FALSE, UNKNOWN을 가진다
-- NULL = NULL <<처럼 NULL끼리의 비교 연산 조차도 UNKNOWN으로 처리를 함

-- where절의 condition!! **** where절의 condition의 결과가 TRUE인 tuple만 선택된다
-- **** 즉, 결과가 FALSE이거나 UNKNOWN이면 그 tuple은 선택되지 않는다!!  

