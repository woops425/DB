-- write-lock(exclusive lock)
-- 이름은 write-lock이지만, read나 write(insert, modify, delete) 할 때 사용한다
-- 다른 transaction이 같은 데이터를 read / write 하는 것을 허용하지 않는 것이 write-lock

-- read-lock(shared lock)
-- write-lock과 달리, read 할 때만 사용한다
-- ** 다른 transaction이 같은 데이터를 read 하는 것은 허용한다
-- ex) (tx = transaction) tx1과 tx2가 있을 때, tx2가 write-lock을 먼저 걸면, tx1은 read / write-lock을 걸지 못하지만,
-- tx2가 read-lock을 걸었을 경우에는 tx1이 read-lock을 거는 것은 허용이 된다는 것

								-- lock 호환성
					-- read-lock			write-lock
-- read-lock				O					X
-- write-lock				X					X

-- 2PL protocol(two-phase locking)
-- transaction에서 모든 locking operation이 최초의 unlock operataion보다 먼저 수행되도록 하는 것

-- Expanding phase(growing phase)
-- > lock을 취득하기만 하고, 반환하지는 않는 phase
-- Shrinking phase(contracting phase)
-- > lock을 반환만 하고 취득하지는 않는 phase

-- 2PL protocol은 serializable을 보장함

-- < 2PL protocol의 종류 >
-- conservative 2PL : 모든 lock을 취득한 뒤 transaction을 시작
-- ex) read_lock(x) - write_lock(y) - write_lock(z)을 모두 취득 한 후 tx 시작
-- deadlock이 발생하지 않는다는 장점 / 실용적이지는 않은 방법

-- strict 2PL(S2PL)
-- strict schedule을 보장하는 2PL
-- recoverability를 보장
-- write-lock을 commit / rollback 될 때 반환
-- ex) commit - unlock(y) - unlock(z) <- 앞서 write_lock(y), write_lock(z)를 수행한 상황

-- strong strict 2PL(SS2PL or rigorous 2PL)
-- strict 2PL과의 차이점 : write-lock 뿐만 아니라, read-lock에 대해서도 commit / rollback 될 때 반환
-- ex) commit - unlock(x) - unlock(y) - unlock(z) <- 앞서 read_lock(x) , write_lock(y) , write_lock(z)를 수행한 상황 
-- S2PL보다 구현이 쉽다는 장점 / 하지만 lock을 쥐고 있는 시간이 길기 때문에, 다른 트랜잭션이 read나 write를 하고싶어도 기다리는 시간이 길어질 수 있다는 단점
