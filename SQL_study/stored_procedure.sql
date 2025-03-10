-- stored precedure : 사용자가 정의한 프로시저. REBMS에 저장되고 사용되는 프로시저. 구체적인 하나의 태스크(task)를 수행함

-- 두 정수의 곱셈 결과를 가져오는 프로시저 작성
delimiter $$
create procedure product(IN a int, IN b int, OUT result int) -- input, output 파라미터 반드시 지정해주기
begin
	set result = a * b;
end
$$
delimiter ;

call product(5, 7, @result);
select @result;


-- 두 정수를 맞바꾸는 프로시저 작성
delimiter $$
create procedure swap(INOUT a int, INOUT b int) -- INOUT : a와 b는 값을 전달받음과 동시에 반환값도 저장이 가능함
begin
	set @temp = a;
    set a = b;
    set b = @temp;
end
$$
delimiter ;

set @a = 5, @b = 7;
call swap(@a, @b);

select @a, @b;


-- 각 부서별 평균연봉을 가져오는 프로시저 작성
delimiter $$
create procedure get_dept_avg_salary()
begin
	select dept_id, avg(salary)
    from employee
    group by dept_id;
end
$$
delimiter ;

call get_dept_avg_salary();


-- 사용자가 프로필 닉네임을 바꾸면, 이전 닉네임을 로그에 저장하고 새 닉네임으로 업데이트하는 프로시저 작성
select * 
from users;

select *
from nickname_logs; -- 여기까지 있다고 가정

delimiter $$
create procedure change_nickname(user_id int, new_nick varchar(30))
begin
	insert into nickname_logs(
		select id, nickname, now()
        from users
        where id = user_id
        );
	update users
    set nickname = new_nick
    where id = user_id;
end
$$
delimiter ;

call change_nickname(1, 'ZIDANE');

select *
from users;

select * 
from nickname_logs;

-- stored procedure : 이외에도 조건문을 통한 분기처리 / 반복문 수행 / 에러 핸들링 / 에러 발생 등의 다양한 로직 정의 가능

-- stored procedure의 장점
-- application에 transparent 할 수 있다
-- network traffic을 줄여서 응답 속도를 향상시킬 수 있다
-- 여러 서비스에서 재사용 가능하다

-- stored procedure의 단점
-- stored procedure를 쓰게 되면 유지 보수 관리 비용이 커진다
-- stored procedure은 언제나 transparent인 건 아니다
