-- partitining : database table을 더 작은 table들로 나누는 것
-- vertical partitioning : column을 기준으로 table을 나누는 방식
-- horizontal partitioning : row를 기준으로 table을 나누는 방식

-- 테이블의 크기가 커질수록 인덱스의 크기도 함께 커짐
-- -> 테이블에 읽기 / 쓰기가 있을 때마다 인덱스에서 처리되는 시간도 조금씩 늘어남 : horizontal partitioning(hash_based)

-- 어떤 특정한 애트리뷰트로 테이블을 partition 할 때, 이 partition의 기준이 되는 애트리뷰트를 'partition key' 라고 함

-- hash-based horizontal partitioning은 한 번 partition이 나눠져서 사용되면 이후에 partition을 추가하기 까다로움


-- sharding : horizontal partitioning처럼 동작, 각 partititon이 독립된 DB 서버에 저장됨
-- horizontal partitioning은 모든  partition들을 같은 DB 서버에 저장함. 그래서 하드웨어 자원이 한정되어 있음.
-- sharding은 DB 서버의 부하를 분산시킬 수 있는 장점이 있음. 

-- sharding에서의 partition key를 'shard key' 라고 부르고, 각 partition을 shard라고 부름



-- replication : 데이터를 여러 서버 간에 복제하는 과정을 말함. 주로 주-서버가 되는 서버를 master / primary / leader 라고 부름
-- 보조 서버가 되는 서버는 slave / secondary / replica 등으로 불림
-- 장애 상황이 발생했을 때도 계속해서 서비스를 할 수 있게끔 하는 구성을 High availability(고가용성, HA)이라고 부름
