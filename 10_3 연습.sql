--기본 문법
--조건에 맞는 데이터 삭제

DELETE FROM 테이블명 WHERE 조건; 
DELETE FROM 테이블명 WHERE deptno = 30;

-서브쿼리 활용한 삭제
D


--전체 행 삭제
DELETE FROM EMP_COPY;



--부사 번호가 30인 사원 삭제하게
    dlELETE FROM EMP_COPY WHERE DEPTNO = 30;


    