-- DB 정규화(nomalization)
-- 데이터 중복과 insertion, update, deletion anomaly를 최소화하기 위해 일련의 normal forms(NF)에 따라 relational DB를 구성하는 과정

-- Normal forms(NF) : 정규화 되기 위해 준수해야 하는 각각의 rule
-- Init table > 1NF > 2NF > 3NF > BCNF > 4NF > 5NF > 6NF
-- 처음부터 순차적으로 진행하며, NF를 만족하지 못하면 만족하도록 테이블 구조를 조정한다. 앞 단계를 만족해야 다음 단계로 진행할 수 있다.

-- 1NF ~ BCNF 까지는 FD와 key 만으로 정의되는 Normal forms
-- 3NF까지 도달하면, 정규화 됐다고 말하기도 함
-- 보통 실무에서는 3NF 혹은 BCNF까지 진행(많이 해도 4NF 정도까지만 진행)


-- ***임직원의 월급 계좌를 관리하는 EMPLOYEE_ACCOUNT 테이블***
-- *** bank_name(국민or우리) | account_num | account_id | class | ratio | empl_id | empl_name | card_id ***

-- 월급 계좌는 국민 or 우리 은행 중 하나
-- 한 임직원이 하나 이상의 월급 계좌를 등록하고, 월급 비율(ratio)를 조정할 수 있다
-- 계좌마다 등급(class)이 있다(국민 : STAR -> PRESTIGE -> LOYAL / 우리 : BRONZE -> SILVER -> GOLD)
-- 한 계좌는 하나 이상의 현금 카드와 연동 될 수 있다

-- FD 관계 정리
-- {account_id} -> {그 외 모두}
-- {bank_name, account_num} -> {그 외}
-- {empl_id} -> {empl_name}, {class} -> {bank_name}

-- 1NF : attribute의 value는 반드시 나눠질 수 없는 단일한 값이어야 한다
-- 1NF를 거치고 나니 중복 데이터가 발생함.
-- 1NF 이후의 (candidate) key : {account_id, card_id}, {bank_name, account_num, card_id}
-- non-prime attribute : class, ratio, empl_id, empl_name
-- 현재 모든 non-prime attribute들이 {account_id, card_id}에 partially dependent한 상황이라 중복이 발생하는 것
-- 또한, 모든 non-prime attribute들이 {bank_name, account_num, card_id}에 partially dependent해서
-- 실제로 bank_name, account_num 만으로 non-prime attribute를 구분할 수 있기 때문에 중복이 발생한 것

-- 2NF : 모든 non-prime attribute는 모든 key에 fully functionally dependent 해야 한다
-- 2NF를 만족시키기 위해, ACCOUNT_CARD 테이블(account_id | card_id)을 따로 만들어줌
