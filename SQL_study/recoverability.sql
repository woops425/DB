-- unrecoverable schdule
-- : schedule 내에서 commit된 transaction이 rollback된 transaction이 write 했었던 데이터를 읽은 경우
-- rollback을 해도 이전 상태로 회복 불가능할 수 있기 때문에 이런 schedule은 DBMS가 허용하면 안된다 

-- recoverable schdule
-- schedule 내에서 그 어떤 transaction도 자신이 읽은 데이터를 write 한 transaction이 먼저 commit / rollback 전까지는 commit 하지 않는 경우
-- rollback 할 때, 이전 상태로 온전히 돌아갈 수 있기 때문에 DBMS는 이런 schedule만 허용해야 한다

-- cascading rollback
-- 하나의 transaction이 rollback 하면, 이 transaction에 의존성이 있는 다른 transaction도 rollback 해야한다
-- 여러 transactiondml rollback이 연쇄적으로 일어나면 처리하는 비용이 많이 든다
-- -> how to solve? --> 데이터를 write한 transaction이 commit / rollback 한 뒤에 데이터를 읽는 schedule만 허용하자!

-- cascadeless schedule(avoid cascading rollback)
-- schedule 내에서 어떤(any) transaction도 / commit 되지 않은 transaction들이 / write한 데이터는 / 읽지 않는 경우

-- strict schedule(가장 엄격하다는 특징)
-- schedule 내에서 어떤(any) transaction도 / commit 되지 않은 transaction들이 / write한 데이터는/ 쓰지도, 읽지 않는 경우
-- rollback 할 때, recovery가 쉬움. transaction 이전 상태로 돌려 놓기만 하면 되기 때문 