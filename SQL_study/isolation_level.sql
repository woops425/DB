-- Dirty read : commit 되지 않은 변화를 읽음 -> 이상한 결과값을 초래할 수 있음
-- Non-repeatable read(Fuzzy read) : 같은 데이터의 값이 달라짐
-- Phantom read : 없던 데이터가 생김
-- ---------------------------------------------------
-- 이런 이상 현상들은 발생하지 않게 만들 수 있지만, 그러면 제약사항이 많아져서 동시 처리 가능한 트랜잭션 수가 줄어듦.
-- 결국 DB 전체 처리량(throughput)이 하락하게 됨.
-- -> 일부 이상 현상은 허용하는 몇가지 level을 만들어서 사용자가 필요에 따라서 적절하게 선택할 수 있도록 하자! : Isolation level

-- Isoation level	|		Dirty read		|		Non-reapeatable read		|		Phantom read

-- Read uncommitted |			O			|				O					|			O
-- Read committed	|			X			|				O					|			O
-- Repeatable read  |			X			|				X					|			O
-- Serializable		|			X			|				X					|			X

-- 'Serializable'의 경우, 위 세가지 현상 뿐만 아니라, 아예 이상한 현상 자체가 발생하지 않는 level을 의미함 
-- 애플리케이션 설계자는 isolation level을 통해 전체 처리량(throughput)과 데이터 일관성 사이에서 어느 정도 거래(trade)를 할 수 있다

-- Dirty write : commit 안 된 데이터를 write 한 경우
-- Lost update : 업데이트를 덮어 썼을 때 발생하는 현상
-- Read skew : inconsistent한 데이터 읽기
-- Write skew : inconsistent한 데이터 쓰기

-- Snapshot isolation : type of MVCC(multi version concurrency control)
-- transaction 시작 전에 commit 된 데이터만 보임
-- First-committer win

-- 주요 RDBMS는 SQL 표준에 기반해서 isolation level을 정의한다
-- RDBMS마다 제공하는 isolation level이 다르다
-- 같은 이름의 isolation level이라도 동작 방식이 다를 수 있다
-- --> 사용하는 RDBMS의 isolation level을 잘 파악해서 적절한 isolation level을 사용할 수있도록 해야한다