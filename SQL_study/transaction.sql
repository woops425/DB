-- Transaction : 단일의 논리적인 작업 단위
-- 논리적 이유로 여러 SQL문들을 단일 작업으로 묶어서 나눠질 수 없게 만든 것이 transaction
-- transaction의 SQL문들 중에 일부만 성공해서 DB에 반영되는 일은 일어나지 않는다

select *
from account;

start transaction;

update account
set balance = balance - 200000
where id = 'J';

update account
set balance = balance + 200000
where id = 'H';

commit;
-- COMMIT : 지금까지 작업한 내용을 DB에 영구적으로 저장하게 하는 명령어
-- transaction을 종료함

select *
from account;

start transaction;

update account
set balance = balance - 300000
where id = 'J';

select *
from account;

rollback;
-- ROLLBACK : 지금까지의 작업들을 모두 취소하고, transaction 이전 상태로 되돌린다
-- transaction을 종료한다

select *
from account;

select @@autocommit;
-- AUTOCOMMIT : 각각의 SQL문을 자동으로 transaction 처리 해주는 개념
-- SQL문이 성공적으로 실행하면 자동으로 commit 한다
-- 실행중에 문제가 있었다면 알아서 rollback 한다
-- MySQL에서는 default로 autocommit이 enabled 되어 있다(디폴트값이 활성화 된 상태. 1로 나타남)
-- 다른 DBMS에서도 대부분 같은 기능을 제공한다

insert into account
values('W', 1000000);

set autocommit = 0;
delete from account
where balance <= 1000000;

select *
from account;
-- autocommit을 off 한 후에 delete 했기 때문에, rollback 한다면 다시 이전 상태로 돌아갈 수 있다
rollback;

select *
from account;

-- * START TRANSACTION 실행과 동시에 autocommit은 off가 된다
-- * COMMIT / ROLLBACK과 함께 transaction이 종료되면, 원래 autocommit 상태로 돌아간다

-- 일반적인 transaction 사용 패턴
-- 1. transaction을 시작한다
-- 2. 데이터를 읽거나 쓰는 등의 SQL문들을 포함해서 로직을 수행한다
-- 3. 일련의 과정들이 문제없이 동작했다면 transaction을 commit 한다
-- 4. 중간에 문제가 발생했다면 transaction을 rollback 한다


-- ACID : Atomicity(원자성) / Consistency(일관성) / Isolation(독립성) / Durability(영존성)

-- Atomicity(원자성) : ALL or NOTHING
-- transaction은 논리적으로 쪼개질 수 없는 작업 단위이기 때문에 내부의 SQL문들이 모두 성공해야 한다
-- 중간에 SQL문이 실패하면 지금까지의 작업을 모두 취소하여 아무 일도 없었던 것처럼 rollback 한다
-- 개발자는 언제 commit 하거나 rollback 할지를 챙겨야한다

-- Consistency(일관성)
-- transaction은 DB 상태를 consistent 상태에서 또 다른 consistent 상태로 바꿔줘야 한다
-- constraints, trigger 등을 통해 DB에 정의된 rules을 transaction이 위반했다면 rollback 해야한다
-- transaction이 DB에 정의된 rule을 위반했는지는 DBMS가 commit 전에 확인하고 알려준다
-- 그 외에 application 관점에서 transaction이 consistent하게 동작하는지는 개발자가 챙겨야한다

-- Isolation(독립성)
-- 여러 transaction들이 동시에 실행될 때도 혼자 실행되는 것처럼 동작하게 만든다
-- DBMS는 여러 종류의 isolation level을 제공한다. isolation level이 높을수록 DB 서버의 성능은 낮아지고, 레벨이 낮아질수록 동시성이 높아져 서버 성능은 높아지지만,
-- 동시적으로 발생하는 여러 트랜잭션들의 충돌로 오류가 발생할수도 있다
-- 개발자는 isolation level 중에 어떤 level로 transaction을 동작시킬지 설정할 수 있다
-- concurrency control의 주된 목표가 isolation이다

-- Durability(영존성)
-- commit된 transaction은 DB에 영구적으로 저장한다
-- 즉, DBS에 문제(power fail or DB crash)가 생겨도 commit된 transaction은 DB에 남아 있는다
-- '영구적으로 저장한다'라고 할 때는 일반적으로 '비휘발성 메모리(HDD, SSD, ...)에 저장함' 을 의미한다
-- 기본적으로 transaction의 durability는 DBMS가 보장한다
