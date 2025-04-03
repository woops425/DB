-- 1. 중복 데이터 문제(Insertion anomalies)

-- IT회사의 데이터베이스 테이블을 다음과 같이 만들었다고 가정
-- EMPLOYEE_DEPARTMENT
-- empl_id(PK,직원 id), empl_name(직원 이름), birth_date, position(직급), salary, dept_id, dept_name, dept_leader_id
-- 중복된 데이터의 경우, 오타가 발생하면 1. 저장 공간이 낭비되고, 2. 실수로 인한 데이터 불일치 가능성이 존재한다.
-- 아직 부서를 배정받지 못한 직원이 있을 경우, 한 테이블에 부서 관련 정보를 모두 null로 입력해야 하므로, 비효율적인 문제가 발생함
-- * (할 수 있는 한 null값은 적게 쓰는 것이 좋음)

-- 임직원이 한 명도 없는 부서의 경우에는? 직원 관련 정보를 모두 null로 처리해야하는데, empl_id는 PK라 null값을 사용할 수도 없음
-- 이렇게 되면, 그 부서를 저장하기 위한 row를 따로 만들어줘야하는데, 이러면 매끄럽지도 못하고, null값을 많이 써야 하는 문제 발생
-- 이후 부서에 직원이 새로 들어오게 되면, 부서 저장을 위해 만들었던 row를 삭제해줘야하는 번거로움도 발생

-- 위 테이블은 임직원에 대한 정보와, 부서에 대한 정보, 즉, 별개의 관심사에 대한 것이 한 테이블에 공존하는 중.
-- 이를 각각의 관심사로 존재하게 만들면, EMPLOYEE 테이블(empl_id가 PK), DEPARTMENT 테이블(EMPLOYEE 테이블의 dept_id를 참조하는 dept_id가 FK)
-- 이렇게 구분하면, 아직 부서를 배정받지 못한 임직원이 있다 해도 EMPLOYEE 테이블의 dept_id만 null값으로 처리하면 됨

-- < Deletion anomalies > (테이블이 합쳐져 있을 때, 데이터 삭제 시의 문제점)
-- QA 부서의 유일한 임직원 YUJIN에 대한 튜플을 삭제하게 되면 ? -> QA 부서에 대한 정보 자체가 사라져버림

-- < Update anomalies >
-- DEV 라는 부서 명이 DEV1로 변경이 되었는데, 임직원 한 명에 대해서만 부서 정보가 수정된 상황 -> 부서 이름의 불일치 발생
-- 테이블이 따로 설계되어 있다면, 부서명 하나만 수정하면 데이터 불일치 발생의 가능성 자체가 사라져 버림


-- 2. Spurious Tuples - 가짜 튜플
-- 사진 촬영 회사의 데이터베이스 구축
-- 부서와 프로젝트 정보가 모두 담겨있는 테이블 DEPARTMENT_PROJECT(dept_id, proj_id, proj_name, proj_location)
-- DEPARTMENT_LOCATION(dept_name, proj_location)
-- 두 테이블 간 natural join 하면?
select *
from department_project
natural join department_location;
-- 이렇게 하면, dept_id는 서로 같은데, dept_name은 서로 다른 이상한 현상이 발생하게 됨 > join을 하면서 가짜 튜플이 생성됨
-- 그럼 어떻게 해야할까? 테이블 정보를 따로 만들어줘야함. 
-- > DEPARTMENT 테이블(dept_id, dept_name) / PROJECT 테이블(proj_id , proj_name, proj_lacation) / DEPARTMENT_PROJECT 테이블(dept_id, proj_id)

-- 3. null값이 많아짐으로 인한 문제들(1번 사례와 같이 보면 좋음)
-- null값이 있는 column으로 join 하는 경우, 상황에 따라 예상과 다른 결과 발생
-- null값이 있는 column에 aggregate function을 사용 했을 때 주의가 필요함 ex) count(*) <- 전체 튜플의 수를 카운트
-- 불필요한 storage 낭비


-- 바른 DB schema 설계 방법
-- 1. 의미적으로 관련있는 속성들끼리 테이블을 구성
-- 2. 중복 데이터를 최대한 허용하지 않도록 설계
-- 3. join 수행 시, 가짜 데이터가 생기지 않도록 설계(PK, FK 잘 활용하는 것이 중요)
-- 4. 되도록이면 null 값을 줄일 수 있는 방향으로 설계

-- ㅁ
