-- * DBCP : DataBase Connection Pool

-- DB 서버 설정(mySQL 기준)
-- max_connections : client(DB 서버에 요청을 보내는 모든 대상)와 맺을 수 있는 최대 connection 수 
-- wait_timeout : connection이 inactive 할 때 다시 요청이 오기까지 얼마의 시간을 기다린 뒤에 close 할 것인지를 결정. wait_timeout의 시간 내에 요청이 도착하면 0으로 초기화됨.


-- DBCP 설정(HikariCP 기준)
-- minimumIdle : pool에서 유지하는 최소한의 idle connection(유휴자원)의 수
-- idle connection 수가 minimumIdle보다 작고, 전체 connection 수도 maximumPoolSize보다 작다면, 신속하게 추가로 connection을 만든다.
-- 기본 값은 maximumPoolSize와 동일함(= pool size가 고정된다는 뜻) <- 트래픽이 밀려올 때 대응하기 용이함

-- maximumPoolSize : pool이 가질 수 있는 최대 connection 수. idle과 active(in-use) connection을 합쳐서 최대의 수
-- maxLifetime : pool에서 connection의 최대 수명. maxLifetime을 넘기면 idle일 경우 pool에서 바로 제거, active인 경우 pool로 반환된 후 제거.
-- pool로 반환이 안되면 maxLifetime 동작 안함. DB의 connection time limit보다 몇 초 짧게 설정해야함.
-- connectionTimeout : pool에서 connection을 받기 위한 대기 시간. 사용자가 얼마나 기다리는지를 고려하여 적절한 timeout 시간을 설정하는 것이 중요함 


-- 적절한 connection 수를 찾기 위한 과정
-- 모니터링 환경 구축(서버 리소스, 서버 스레드 수, DBCP 등등)
-- 백엔드 시스템 부하 테스트(ex. nGrinder) -> request per second(전체적인 처리량, RPS)와 avg response time(평균응답시간, ART) 확인 : API 성능 확인
-- 백엔드 서버, DB 서버의 CPU, MEM 등의 리소스 사용률 확인
-- thread per request(요청마다 thread를 할당처리하는 모델)모델이라면 active thread 수 확인(RPS나 ART의 꺾이는 지점에서의 병목현상 확인) 
-- 사용할 백엔드 서버 수를 고려하여 DBCP의 max pool size 결정 
