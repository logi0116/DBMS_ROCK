--하나의 열에 출력 결과를 담는 다중행 함수
--집계함수, AGGREGATE, 갯수, 평균, 합계, 최대, 최소 등.


--전체 급여 합계

SELECT SUM(SAL) FROM EMP;
SELECT ENAME, SUM(SAL) FROM EMP; --이건 안 됨
SELECT MAX(SAL), MIN(SAL), SUM(SAL) FROM EMP; --이건 하나씩이라 됨


--급여가 있는 사원의 수
SELECT COUNT(SAL) FROM EMP;
--커미션이 있는 사원의 수
SELECT COUNT(COMM) FROM EMP;
--COUNT(SAL) : SAL 컬럼 값이 NULL이 아닌 경우만 카운트 함. 
--NULL이면 제외함


--부서번호가 30번인 사원의 수
--COUNT(*) : NULL 여부 관계 없이 해당조건을 
--만족하는 전체 행의 수를 반환한다는 의미.
--예를 들어 SAL이 NULL 이어도 포함하겠다라는 뜻.



SELECT COUNT(DEPTNO = 30) FROM EMP; --실수한 시도

--정답
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;


--퀴즈 1 부서번호가 10번인 사원들의 최대, 최소 급여를 출력하시오
--별칭 최대 급여, 최소 급여

SELECT MAX(SAL) AS "최대 급여", MIN(SAL) AS "최소 급여" FROM EMP WHERE DEPTNO = 10;
SELECT MAX(SAL) AS "최대 급여", MIN(SAL) AS "최소 급여" FROM EMP WHERE DEPTNO = 20;
SELECT MAX(SAL) AS "최대 급여", MIN(SAL) AS "최소 급여" FROM EMP WHERE DEPTNO = 30;

--퀴즈 2. 부서번호가 20번인 사원의 입사일 중 가장 오래된 날짜를 구하시오.
--별칭 가장 오래된 날짜

SELECT TO_CHAR(MAX(HIREDATE),'YYYY-MM-DD') AS "가장오래 된 날짜" FROM EMP WHERE DEPTNO = 20; --MAX 가 아니라 MIN을 써야했음
SELECT TO_CHAR(MIN(HIREDATE),'YYYY-MM-DD') AS "가장오래 일한 날짜" FROM EMP WHERE DEPTNO = 20; --이게 정답
SELECT TO_CHAR(MIN(HIREDATE),'YYYY-MM-DD') AS "가장오래 일한 날짜" FROM EMP WHERE DEPTNO = 30;
SELECT TO_CHAR(MIN(HIREDATE),'YYYY-MM-DD') AS "가장오래 일한 날짜" FROM EMP WHERE DEPTNO = 10;


--퀴즈 3. 중복된 급여를 제외한 평균 급여를 출력하시오
--별칭 근무 지역 
--힌트 DISTINCT


SELECT AVG(SAL) FROM EMP;
SELECT DISTINCT SAL FROM EMP;

SELECT DISTINCT AVG(SAL) FROM EMP; --요게 틀린 이유, 평균을 구한 뒤에 제외를 하니까. 이건 "중복 O 평균 급여)
SELECT AVG(DISTINCT SAL) FROM EMP; --요게 맞는 이유. SAL에서 DISTINCT 한 다음에 AVG를 하니까. 
--함수마다 식을 구사하는 방식이 다 달라서 이 부분은 계속 맞춰가야 할 듯


--정답
select AVG(DISTINCT SAL) AS "중복 X 평균 급여" FROM EMP;



SELECT AVG(SAL) FROM (SELECT DISTINCT SAL FROM EMP);

SELECT SAL FROM EMP;

--GPT 답
SELECT AVG(SAL) AS "근무지역" FROM (SELECT DISTINCT SAL FROM EMP);

--좀더 질문해서 찾아낸 답
SELECT AVG(DISTINCT SAL) AS "근무 지역"
FROM EMP;
