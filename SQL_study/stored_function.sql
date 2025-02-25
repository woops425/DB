use company;
-- stored function : 사용자 정의 함수. DBMS에 저장되고 사용되는 함수
-- SQL의 select, insert, update, delete statement에서 사용할 수 있다

-- 임직원의 id를 10자리 정수로 랜덤하게 발급하고 싶을 때 / ID의 맨 앞자리는 1로 고정
delimiter $$ -- 함수의 끝을 나타내는 것이 세미콜론(;)이 아니라 $$로 바꿈을 뜻함

create function id_generator()
returns int -- RETURNS 이후에 반환 타입을 적어줌
no sql
begin -- BEGIN - END
	return (1000000000 + floor(rand() * 1000000000));
end
$$
delimiter ; 

insert into employee
values (id_generator(), 'JEHN', '1991-08-04', 'F', 'PO', 100000000, 1005);

select *
from employee
where name = 'JEHN';

-- 부서의 ID를 파라미터로 받으면 해당 부서의 평균 연봉을 알려주는 함수를 작성
delimiter $$

create function dept_avg_salary(d_id int)
returns int
reads sql data
begin
	declare avg_sal int;
	select avg(salary) into avg_sal
	from employee
	where dept_id = d_id;
	return avg_sal;
end
$$
delimiter ; -- 띄어쓰기를 해줘야함

-- declare 없이도 선언되지 않은 변수를 바로 사용하는 방법 -> @
delimiter $$

create function dept_avg_salary(d_id int)
returns int
reads sql data
begin
	select avg(salary) into @avg_sal
	from employee
	where dept_id = d_id;
	return @avg_sal;
end
$$
delimiter ; 


-- 부서 정보와 부서 평균 연봉을 함께 가져올 때
select *, dept_avg_salary(id)
from department;


-- 졸업 요건 중 하나인 토익 800 이상을 충족했는지를 알려주는 함수 작성
delimiter $$
create function toeic_pass_fail(toeic_score int)
returns char(4)
no sql
begin
	declare pass_fail char(4);
	if toeic_score is null then set pass_fail = 'fail';
    elseif toeic_score < 800 then set pass_fail = 'fail';
    else set pass_fail = 'pass';
    end if;
    return pass_fail;
end
$$
delimiter ;

select *, toeic_pass_fail(toeic)
from student;

show function status
where db = 'company';
-- 활성화 되어있지 않은 DB에 사용자정의 함수를 만들고 싶으면, create function db.function 꼴로 적으면 됨
show databases;
show create function id_generator; 

-- stored function은 언제 쓰는 게 좋을까?
-- Three-tier architecture
-- 1. presentation tier : 사용자에게 보여지는 부분을 담당하는 tier. html, javascript, CSS, native app, desktop app
-- 2. logic tier : 서비스와 관련된 기능과 정책 등 비즈니스 로직을 담당하는 tier. application tier, middle tier라고도 불림
-- 					JAVA + Spring, Python + Django, etc...
-- 3. data tier : 데이터를 저장하고 관리하고 제공하는 역할을 하는 tier
-- mySQL, Oracle, SQL server, PostgreSQL, MongoDB...
-- 비즈니스 로직을 stored function에 두는 것은 좋지 않을 것 같다!
-- 오늘 배운 함수 중, toeic_pass_fail 함수 같은 경우가 비즈니스 로직을 가지는 함수!