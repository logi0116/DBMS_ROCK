--테이블에 데이터 추가하기
--기본 문법, 테이블명의 열을 지정하면 열의 순서에는 상관없음.
--INSERT INTO 테이블명 (열1, 열2,.....) VALUES (값1, 값2, ....);

--열 이름 생략, 이 경우 테이블에 정의된 열의 순서대로 작성하기. 
--INSERT INTO 테이블명 VALUES (값1, 값2, ...);

--NULL 삽입, 날짜 입력
--INSERT INTO 테이블명 VALUES (101, NULL, '2025/05/22', SYSDATE)

-- 서브쿼리 삽입
-- INSERT INTO 테이블명 (열1,열2)
-- SELECT 열1, 열2 FROM 다른 테이블 WHERE 조건;

-- 부서 정보를 dept 테이블에 삽입하는 쿼리입니다.
-- deptno: 부서 번호 (예: 70)
-- dname: 부서 이름 (예: '개발부2')
-- loc  : 부서 위치 (예: '서울2')

insert into dept (
    deptno,
    dname,
    loc
) values (70,'개발부2','서울2');    




select * 
from dept;
commit;


1)독스 안 뜸
2)이건 왜 접속이 쉬운지? 원래는 system 으로 이름하고 맞췄어야 했던
3)터미널과 워크 스페이스 무슨 차이인지. 
 



