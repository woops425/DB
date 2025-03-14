-- SQL에서의 Trigger란?
-- 데이터베이스에서 어떤 이벤트가 발생 했을 때, 자동적으로 실행되는 프로시저
-- 데이터에 변경이 생겼을 때(즉, DB에 insert, update, delete가 발생하였을 때) 이것이 계기가 되어 자동적으로 실행되는 프로시저를 의미

-- 사용자의 닉네임 변경 이력을 저장하는 트리거 작성
-- id와 nickname 정보가 들어있는 USERS 테이블 / id, nickname, until에 대한 정보가 들어있는 USERS_LOG(닉네임 이력)
delimiter $$
create trigger log_user_nickname_trigger
before update -- 업데이트 이전에 트리거가 작동하게끔 함
on users for each row -- users 테이블에서, 업데이트가 되는 각 row 별로 이 트리거를 실행하게끔
begin
	insert into users_log -- body 부분
    values(old.id, old.nickname, now());	-- users 테이블의 id와 nickname, 현재시간을 보여줌. 
    -- * 여기서 OLD란? 1. 업데이트 되기 전의 tuple을 가리킴. / 2. delete 된 tuple을 가리킴 
end
$$
delimiter ;

select *
from users;

select *
from users_log;

update users
set nickname = '쉬운코드'
where id = 1;

-- 사용자가 마트에서 상품을 구매할 때마다 지금까지 누적된 구매 비용을 구하는 트리거를 작성
-- id, user_id, price, buy_at에 대한 내용이 포함된 BUY 테이블 / user_id, price_sum이 포함된 USER_BUY_STATS 테이블
delimiter $$
create TRIGGER sum_buy_prices_trigger
after insert
ON buy FOR EACH ROW
begin
	DECLARE total int;
    DECLARE user_id int default NEW.user_id; -- NEW : 해당 테이블에 insert 된 tuple을 가리키거나 / update 된 후의 tuple을 가리킴
    select sum(price) into total
    from buy
    where user_id = user_id;
    
    update user_buy_stats
    set price_sum = total
    where user_id = user_id;
end
$$
delimiter ;

select *
from buy;

select *
from user_buy_stats;

insert into buy (user_id, price, buy_at)
values (1, 5000, now());

insert into buy (user_id, price, buy_at)
values (1, 15000, now());

-- trigger 사용 시 주의 사항
-- 소스코드로는 발견할 수 없는 로직이기 때문에, 어떤 동작이 일어나는지 파악하기 어렵고, 문제가 생겼을 때 대응하기 어렵다
-- 과도한 trigger 사용은 DB에 부담을 주고 응답을 느리게 만든다(update, delete 등에 계속 trigger가 발생하게 될 때)
-- 디버깅이 어렵고, 문서 정리가 특히나 중요하다
