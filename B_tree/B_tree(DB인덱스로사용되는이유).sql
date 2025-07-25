-- 다룰 내용 : B tree의 시간 복잡도, secondary storage의 특징, B tree가 DB index로 쓰이는 이유

-- AVL tree, REd-black tree 같이 스스로 균형을 유지하는 tree 구조도 있는데, 왜 DB index로 B tree 계열이 사용되는가?
-- computer system에서 CPU는 프로그램 코드가 실제로 실행되는 곳, Main memory(RAM)은 실행 중인 프로그램의 코드들과 코드 실행에 필요한 혹은 그 결과로 나온 데이터들이 상주하는 곳(휘발적<->Secondary storage)
-- Secondary storage(SSD or HDD)는 프로그램과 데이터가 영구적으로 저장되는 곳, 실행중인 프로그램의 데이터 일부가 임시 저장되는 곳.

-- Secondary storage의 특징
-- 데이터를 처리하는 속도가 가장 느리다
-- 데이터를 저장하는 용량이 가장 크다
-- block 단위로 데이터를 읽고 쓴다 <- 여기서 block 단위라는 것은, file system이 데이터를 읽고 쓰는 논리적인 단위를 뜻함.  block의 크기는 2의 승수로 표현되며, 대표적 block size로는 4KB, 8KB, 16KB 등이 있음
-- block 단위로 데이터를 읽어올 때의 단점 : 불필요한 데이터까지 읽어올 가능성이 있다.

-- DB는 Secondary storage에 저장됨. 
-- DB에서 데이터를 조회할 때, secondary sotrage에 최대한 적게 접근하는 것이 당연히 성능 면에서 더 좋음 
-- Secondary storage는 block 단위로 읽고 쓰기 때문에, 연관된 데이터를 모아서 저장하면 더 효율적으로 읽고 쓸 수 있다.

-- B tree index는 self-balancing BST에 비해 secondary storage 접근을 적게 한다.
-- B tree 노드는 block 단위의 저장 공간을 알차게 사용할 수 있다.

-- self-balancing BST의 노드들도 block 안에 최대한 담는다면? 
-- > 그게 결국 B tree 동작 방식과 같기 때문에 굳이 AVL이나 red-black tree를 그런 방식으로 구현하려 할 필요가 없음

-- hash index를 사용하는 것은? (hash index는 삽입/삭제/조회 시 시간복잡도가 O(1)이기 때문)
-- 실제로 MySQL에서는 제공하는 기능이지만, 대신 equlity(=) 조회만 가능하고, 범위 기반 검색이나 정렬에는 사용될 수 없다는 단점이 있음.