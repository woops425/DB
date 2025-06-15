-- FD(Functional Dependency) 내용 정리

-- 테이블의 스키마를 보고 의미적으로 파악해야함 ! 테이블의 state, 즉 테이블의 현재 상태만 보고 FD 여부를 파악해서는 안됨
-- ex) 현재 {empl_name}이 결정자, {birth_date}가 종속자가 되는 함수 종속의 형태가 테이블에서 보인다고 하여,
-- 이 테이블에서의 FD {empl_name} -> {birth_date}가 존재한다고 생각하면 안됨
-- 당장은 테이블에서의 empl_name으로 하나의 birth_date가 결정되지만, 추후 동명이인이 발생한다면? 
-- 같은 empl_name으로 여러 개의 birth_date 값이 존재하게 되어버림 <= FD 성립 x

-- FD가 성립할 수 있는 애트리뷰트 예시
-- {stu_id} -> {stu_name, birth_date, address}
-- {class_id} -> {class_name, year, semester, credit}
-- {stu_id, class_id} -> {grade}
-- {bank_name, bank_account} -> {balance, open_date}
-- {user_id, location_id, visit_date} -> {comment, picture_url}

-- {} -> Y : 공집합 {}와 Y간의 FD => Y값은 언제나 하나의 값만 가진다는 의미
-- ex) PROJECT 테이블에 company라는 애트리뷰트가 있고, 애튜리뷰트의 값으로 모두 ez. 이라는 값만 존재한다면,
-- 이는 {} -> {company} 라고 표현할 수 있음


-- FD 종류
-- 1. Trivial functional dependency
-- X -> Y라는 FD가 유효할 때, Y가 X의 부분집합이면, X -> Y는 trivial FD가 성립한다.
-- ex) {a,b,c} -> {c} is trivial FD , {a,b,c} -> {b,c} , {a,b,c} -> {a,b,c} 모두 trivial FD

-- 2. Non-trivial functional dependency
-- X -> Y라는 FD가 유효할 때, Y가 X의 부분집합이 아니면, X -> Y는 non-trivial FD가 성립한다.
-- ex) {a,b,c} -> {b,c,d} is non-trivial FD
-- ex2) {a,b,c} -> {d,e} is non trivial FD 이면서 completely non-trivial FD

-- 3. Partial functional dependency(부분함수종속)
-- X -> Y라는 FD가 유효할 때, X의 어떤 진부분집합이라도 Y를 결정지을 수 있다면, 그 때 X -> Y는 partial FD가 성립한다.
-- 여기서 집합 X의 proper subset(진부분집합)이란, X의 부분집합이지만 X와 동일하지는 않은 집합을 의미.
-- 예를 들어, X = {a,b,c}일 때, {a,c}, {a}, {} 모두 X의 proper subset이지만, {a,b,c}는 X의 proper subset이 아님
-- {empl_id, empl_name} -> {birth_date}라는 FD가 성립할 때, {empl_id}만으로도 {birth_date}가 결정되기 때문에, 
-- 이 때의 {empl_id} -> {birth_date}라는 FD는 partial FD(부분함수종속)이 성립하는 것이다.

-- 4. Full functional dependency(완전함수종속)
-- X -> Y가 유효할 때, X의 모든 진부분집합이 Y를 결정짓지 못할 때, 이 때 X -> Y를 full FD라고 한다.
-- {stu_id, class_id} -> {grade}가 성립할 떄, {stu_id}, {class_id}, {}만으로는 {grade}를 결정짓지 못함
-- 이 떄, 이 {stu_id, class_id} 만으로 유일하게 {grade}를 결정지을 수 있기 때문에, 이 FD를 full FD(완전함수종속)이라고 함.