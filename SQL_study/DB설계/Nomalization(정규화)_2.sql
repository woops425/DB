-- transitive FD(Functional Dependency)
-- 공식 : if X -> Y  & Y -> Z가 성립할 때, X -> Z로 표기하는 것을 transitive FD라고 함
-- 이때, Y나 Z는 어떠한 키의 부분집합도 아니어야 함.

-- 3NF : 모든 non-prime attribute는 어떤 key에도 transitively dependent 하면 안된다!
-- 즉, non-prime attribute와 non-prime attribute 사이에는 FD가 있으면 안된다.
-- 3NF까지 되면, '정규화(nomalized) 됐다' 라고 말할 수 있다.

-- BCNF : 모든 유효한 non-trivial FD인(Y가 X의 부분집합이 아닌 상태) X -> Y는 X가 super key여야 한다.


-- 2NF 참고사항
-- 2NF는 key가 composite key(2개 이상의 애트리뷰트로 이루어진 key)가 아니라면 2NF는 자동적으로 만족한다??
-- 2NF 정의 : 모든 non-prime attribute는 모든 key에 fully dependent 해야한다
-- >> 모든 non-prime attribute는 어떤 Key에도 partially dependent 하면 안된다!
-- 일반적으로는 자동적으로 만족하지만, 항상 그런 것은 아니다. 
-- 자동적으로 만족하지 못하는 예외적인 케이스 :
-- EMPLOYEE 테이블에 {empl_id, empl_name, birth_date, position, salary, company}가 있고, company 애트리뷰트엔 ez. 라는 값만 동일하게 들어가 있다고 하면,
-- {empl_id} -> {empl_name, birth_date, position, salary, company}
-- {} -> {company}
-- 여기서 공집합 {}은 {empl_id}의 부분집합이므로, 2NF를 위반한 상황임.
-- 이를 해결하기 위해선, {company}를 하나의 테이블로 따로 빼야 2NF를 성립하는 상황.
-- 이렇게까지 테이블을 쪼개고 싶지 않다 ! 하면, denormalization(반정규화)를 선택하는 방법도 있음. 너무 많이 테이블을 쪼개면 성능이 떨어질 수 있기 때문

-- denormalization
-- DB를 설계할 때 과도한 조인과 중복 데이터 최소화 사이에서 적정 수준을 잘 선택할 필요가 있다!