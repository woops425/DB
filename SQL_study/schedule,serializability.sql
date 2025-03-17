-- Schedule : 여러 transaction들이 동시에 실행될 때 각 transaction에 속한 operation들의 실행 순서
-- 각 transaction 내의 operation들의 순서는 바뀌지 않는다

-- Serail schedule : transaction들이 겹치지 않고 한 번에 하나씩 실행되는 schedule
-- ex) sched.2 -> r2(H) - w2(H) - c2 - r1(K) - w1(K) - r1(H) - w1(H) - c1

-- Nonserial schedule : transaction들이 겹쳐서(interleaving) 실행되는 schedule
-- ex) sched.4 -> r1(K) - w1(K) - r1(H) - r2(H) - w2(H) - c2 - w1(H) - c1

-- Serial schedule의 성능
-- 한 번에 하나의 트랜잭션만 실행되기 때문에 좋은 성능을 낼 수 없고, 현실적으로 사용할 수 없는 방식이다

-- Nonserial schedule의 성능
-- 트랜잭션들이 겹쳐서 실행되기 때문에 동시성이 높아져서 같은 시간동안 더 많은 트랜잭션들을 처리할 수 있다(성능이 좋아지는 것)
-- 하지만, 트랜잭션들이 어떤 형태로 겹쳐서 실행되는지에 따라 이상한 결과가 나올 수 있다

-- Conflict(of two operations)
-- 세 가지 조건을 모두 만족하면 conflict 하다고 볼 수 있음
-- 1. 서로 다른 트랜잭션 소속
-- 2. 같은 데이터에 접근
-- 3. 최소 하나는 write operation

-- conflict operation은 순서가 바뀌면 결과도 바뀐다

-- Conflict equivalent(for two schedules)
-- 두 조건을 모두 만족하면 conflict equivalent
-- 두 schedule은 같은 transaction들을 가진다
-- 어떤(any) conflicting operations의 순서도 양쪽 schedule 모두 동일하다

-- ** Conflict serializable : serial schedule과 conflict equivalent일 때