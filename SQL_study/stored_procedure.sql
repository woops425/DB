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