-- relational database에서는 schema를 정의하고, 그 schema에 맞추어 데이터를 저장함.
-- 그래서 새로운 column 등을 추가하여 확장하고 싶을 때, 유연한 확장이 부족함
-- 복잡한 join은 read의 성능을 하락시키기도 함 
-- 그래서 이때 relational database는 scale up(더 성능 좋은 컴퓨터로 바꿈)을 통한 database 성능을 향상시킴.
-- 데이터 서버를 추가하는 방식인 scale-out 같은 방식도 있지만(ex.multi-master, sharding), 일반적으로 RDB는 scale-out에 유연한 DB는 아님 

-- RDB는 ACID를 보장하려다 보니, DB 서버의 performance에 어느 정도 악 영향을 미침.
-- 이런 RDB가 커버하지 못하는 단점들을 보완하여 나온 게 NoSQL

-- NoSQL의 일반적 특징
-- 1. flexible schema (ex. "student"라는 테이블을 만들고 싶을 때, db.createCollection("student") 이렇게만 적어주면 됨.
-- RDB에서는 create table student( id INT PRIMARY KEY, name VARCHAR(20), ... )
-- 값을 입력할 땐, db.student.insertOne({ name:"sangwoo"}) 이런 식으로 넣으면 됨 
-- mongoDB같은 경우 JSON 형태로 값을 입력함. 아래는 예시
-- db.student.insertOne({ name : "hope",
-- address : {
-- country : "korea",
-- state : "Seoul", 
-- city : "gangnam-gu",
-- street : "blurblur"
-- }, 
-- certificate : ["AWS solution architect"]
-- })

-- db.student.find({name : "sangwoo"})

-- 전체 데이터를 가져오고 싶은 경우
-- db.student.find({})
-- application 레벨에서 스키마 관리가 필요하다는 특징이 있음. 

-- 2. NoSQL에서는 중복을 허용함(join을 회피하기 위함)
-- application 레벨에서 중복된 데이터들이 모두 최신 데이터를 유지할 수 있도록 관리해야 함 

-- 3. scale-out
-- 서버 여러 대로 하나의 클러스터를 구성하여 사용 <- 중복을 허용하여 각각의 데이터를 저장하다보니, 여러 컬렉션을 조인할 필요 없이 한 컬렉션에 가서 데이터를 read 하면 됨

-- 4. ACID의 일부를 포기하고 high-throughput, low-latency 추구 
-- 하지만, 금융 시스템처럼 consistency가 중요한 환경에서는 사용하기가 조심스러움 

-- Redis : in-memory key-value database, cache or, ...
-- 메모리를 사용하는 키 밸류 형태로 데이터베이스로 사용하기도 하고, 캐시로도 사용하는 NoSQL.

-- ex. redis> SET name sangwoo <<- key / value로 묶어서 name이 key, sangwoo가 value
-- "OK"
-- redis> GET name
-- "sangwoo"

-- Radis는 High Availability(고가용성) - replication, automatic failover 가능

-- NoSQL 정보를 모아 볼 수 있는 유명 사이트
-- https://hostingdata.co.uk/nosql-database/
