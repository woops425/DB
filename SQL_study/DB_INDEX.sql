select *
from customer
where first_name = 'Minsoo';
-- 현재, CUSTOMER 테이블은 {id, last_name, first_name, address, birth_date}로 구성되어 있음
-- 만약, first_name에 index가 걸려있지 않은 상태로 위 커리문을 실행한다면?
-- * full scan(=table scan)으로 찾아야한다. 이 때, 시간 복잡도는 O(N)이 나옴

-- 하지만, 만약 first_name에 index가 걸려있다면, * full scan보다 더 빨리 찾을 수 있다.
-- 이 때, 시간 복잡도는 O(logN) <- B-tree based index

-- INDEX를 사용하는 이유!
-- 1. 조건을 만족하는 튜플(들)을 빠르게 조회하기 위해서
-- 2. 빠르게 정렬(order by)하거나 그룹핑(group by) 하기 위해서

-- PLAYER 테이블 {id, name, team_id, backnumber}
-- 1번 쿼리
select *
from player
where name = 'Sonny';

-- 2번 쿼리
select *
from player
where team_id = 105
and backnumber = 7;

-- 이런 테이블과 쿼리문 예시가 있을 때, 1번 쿼리를 위해 name 애트리뷰트에 인덱스를 걸어주고싶으면, name은 중복이 허용되야 하므로
CREATE INDEX player_name_idx
ON player(테이블 이름) (name)(애트리뷰트 이름);

-- 2번 쿼리를 위해 인덱스를 걸어주고싶으면,(team_id와 backnumber를 and 조건으로 조회하면 선수를 유니크하게 조회할 수 있음)
-- 그래서, 이 둘을 묶어서 하나의 인덱스로 만들어주려면,
CREATE UNIQUE INDEX team_id_backnumber_idx
ON player (team_id, backnumber);


-- 테이블을 생성함과 동시에 인덱스를 걸어주고 싶으면,
CREATE TABLE player (
id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
team_id INT,
backnumber INT,
INDEX player_name_idx (name),   -- 테이블 생성과 함께 인덱스를 설정 할 땐, 인덱스 이름(여기선 player_name_idx)을 생략해도, SQL에서 자동으로 이름을 생성해줌
UNIQUE INDEX team_id_backnumber_idx (team_id, backnumber)
);

create
