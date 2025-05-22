

--퀴즈 1 2975보다 높은 급여 사원 이름 출력 
SELECT * FROM EMP WHERE SAL > 2975;

--특정 사원보다 높은 급여를 받는 사원도 2975 대신 가능


--퀴즈, WHERE 조건절에 서브쿼리 이용
JONES보다 급여가 높은 사원의 이름과 급여 출력

SELECT * FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME ='JONES');

--퀴즈, 메인 쿼리에 서브 쿼리 이용해서 부서명 출력
--힌트, SELECT 구문에 서브 쿼리 이용하기. 부서번호
--DEPT 테이블의 부서명 표시
SELECT *FROM EMP; --여기는 부서명이 없다. 그래서 가져오는 수밖에.

SELECT ENAME,
(SELECT DNAME FROM DEPT 
WHERE DEPT.DEPTNO = EMP.DEPTNO) AS "조인된 부서명"
FROM EMP;
