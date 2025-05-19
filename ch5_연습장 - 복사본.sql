--where 기본 문법 확인
--where 조건식(true)일 경우의 행만 출력

select * from emp;
select * from emp WHERE deptno = 30;

--직무가(job)가 'SALESMAN'인 사원 조회

select * from emp WHERE JOB = 'SALESMAN';




--퀴즈1 급여가 sal 2000이상인 사원만 조회하기
select * from emp WHERE SAL >= 2000;
select * from emp WHERE SAL >= 2000 ORDER BY SAL ASC;



--퀴2즈 입사일이 1981-02-20 이후인 사원만 조회하기
select * from emp WHERE HIREDATE >='1981-02-20';
select * from emp WHERE HIREDATE >='1981-02-20' ORDER BY HIREDATE ASC;



--퀴즈 3 부서 번호가 10이 아닌 사원만 조회하기. 아니다는 표현이 일단은 '<>'로 표기하기
--시도1 select * from emp DISTINCT WHERE DEPTNO

SELECT * FROM emp WHERE DEPTNO <> 10;
SELECT * FROM emp WHERE DEPTNO != 10;
 SELECT * FROM emp WHERE DEPTNO ^= 10;

--and 조건

SELECT * FROM emp WHERE DEPTNO = 10 and job = 'MANAGER';
SELECT * FROM emp WHERE DEPTNO = 30 and job = 'SALESMAN';



--or 조건
--하나라도 만족하면 출력됨.
--예를 들어 JOB가 CLERK 또는 MANAGER 인 사원 출력

SELECT * FROM emp WHERE job = 'CLERK' OR WHERE job = 'SALESMAN'; --시도 1 코드 WHERE를 굳이 2번 쓸 필요 없음.
SELECT * FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN'; --시도 1 코드 WHERE를 굳이 2번 쓸 필요 없음.
SELECT * FROM emp WHERE DEPTNO = 30 OR job = 'SALESMAN'; 


-- 괄호 사용 (우선순위 명확히 하기)
-- 부서 번호가 10 또는 20이고ㅡ이고가 and라는 걸 명시ㅡ 급여가 2000 초과인 경우  
SELECT * FROM emp 
WHERE (DEPTNO = 10 OR DEPTNO =20)
AND SAL >= 2000; 

SELECT * FROM emp 
WHERE (DEPTNO = 20 OR DEPTNO =30)
AND SAL <= 3000;  


SELECT * FROM emp 
WHERE (DEPTNO = 20 OR DEPTNO =30)
AND SAL <= 3000 order by sal;



--퀴즈 1 급여가 1500이상이고, 커미션이 NULL이 아닌 사원만 조회
--힌트 NULL이 아닌 표현 IS NOT NULL

--시도 1. SELECT * FROM emp where sal >= 1000 and COMM != 'NULL';
SELECT * FROM emp where sal >= 1500 AND COMM IS NOT NULL;
SELECT * FROM emp where sal >= 1500;

--







--퀴즈 2 직무가 'SALESMAN'이거나, 급여가 3000이상인 사원 출력
SELECT * FROM emp where SAL >= 3000 OR JOB = 'SALESMAN';
SELECT * FROM emp where SAL >= 3000 OR JOB = 'SALESMAN' ORDER BY SAL ASC;

--퀴즈 3 부서번호가 10, 20, 30 중 하나이고, 급여가 2000 이상 사원
--힌트)10,20,30 중 하나 표현 : IN (10, 20, 30)

SELECT * FROM EMP 
WHERE (DEPTNO = 10 
OR DEPTNO = 20
OR DEPTNO = 30) AND SAL >=2000;   --쿼리가 길어짐. OR 조건을 간단히 하기 위해 IN 조건식을 활용해야 좋음
--or 조건을 간단히 하기 위해서 컬럼명 IN (값1, 값2, 값3, ...)을 활용 가능
--컬럼명의 조건이 IN 안의 값을 하나라도 만족한다면 TURE


SELECT * FROM emp where deptno IN(10, 20, 30) AND sal >=2000;
SELECT * FROM emp where deptno IN(10, 20, 30) AND sal >=2000 ORDER BY SAL ASC;






--산술 연산자
SELECT ENAME, SAL * 12 + 1000 AS "기본 연봉 + 1000" FROM EMP; 

--비교 연산자
SELECT * FROM EMP WHERE SAL >3000;

--문자 비교 (1글자 vs 여러글자)
--L보다 뒤에 있는, 사전식 정렬
SELECT * FROM EMP WHERE ENAME > 'L';

--여러 글자, 순서대로 앞의 글자 비교하고 다음글자 비교함
SELECT * FROM EMP WHERE ENAME < 'MILLER';

--등가 비교 연산자
-- !=, <>, ^=
--JOB CLERK 이 아닌 사원만 출력해보기
SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';


--NOT 연산자
--JOB이 MANAGER가 아닌 사원만 출력해보기
SELECT * FROM EMP WHERE NOT JOB = 'CLERK';
SELECT * FROM EMP WHERE NOT JOB = 'MANAGER';


--IN 연산자 OR 간결히 사용하기
zjffjaaud IN(값1,값2,값3,....)
--컬럼의 값이 IN 연산자 안의 값을 만족하면 TRUE
--부서번호가 10, 30이 아닌 사원을 출력해보기
SELECT * FROM EMP WHERE DEPTNO NOT IN (10,20);


--BETWEEN A AND B
--급여가 1100이상 3000이하인 사원 출력해보기

시도 1. SELECT * FROM EMP WHERE SAL 1100 AND 3000;

SELECT * FROM EMP WHERE SAL BETWEEN 1100 AND 3000;

--급여가 1100이상 3000이하인 사원의 반대인 경우
--1100미만 3000초과인 경우
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1100 AND 3000;


--LIKE 연산자
--S로 시작하는 사원명
-- % : 모든 글자
-- (_)언더바 : 특정 글자 수
--사원명이 S로 시작하는 사원 출력 해보기 
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

SELECT * FROM EMP WHERE NOT ENAME LIKE 'S%'; --"이름이 'S'로 시작하는 사람이 아니다"
SELECT * FROM EMP WHERE ENAME NOT LIKE 'S%'; --"이름이 'S'로 시작하지 않는 사람이다"

--사원명이 두번째 글자가 L을 포함하는 사원 출력하기
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
SELECT * FROM EMP WHERE ENAME LIKE '__L%';

--사원명이 AM 글자를 포함하는 사원 출력하기
--띄워쓰기 상관 없음
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%';
SELECT * FROM EMP WHERE NOT ENAME LIKE '%AM%';


-- IS NULL 널 조건이니?
-- IS NOT NULL 널이 아닌 조건이니?
--커미션이 널인 사원만 출력하기
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM EMP WHERE NOT COMM IS NULL; --NOT은 = 앞에 있으면 안 됨

--AND + IS NULL 
--JOB 이 SALESMAN 이고 커미션이 널인 경우

SELECT * FROM EMP
WHERE JOB = 'SALESMAN'
AND COMM IS NULL;

--AND + IS NULL 
--JOB 이 SALESMAN 이고 커미션이 널이 아닌 경우

SELECT * FROM EMP
WHERE JOB = 'SALESMAN'
AND COMM IS NOT NULL;


--OR + IS NULL
--JOB이 MANAGER 이거나 MGR(직속상관)이 NULL인 사원


SELECT * FROM EMP
WHERE JOB = 'MANAGER'
OR 
MGR IS NULL;

SELECT * FROM EMP in(WHERE JOB = 'MANAGER', MGR IS NULL;)


--집협 연산자
-- UNION 중복 제거 (기본적으로는 중복 제거함)
-- JOB이 MANAGER 이거나, DEPTNO 10인 사원 출력하기
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE JOB = 'MANAGER'
UNION
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 10;


-- 2 UNION ALL 중복 포함
-- JOB이 MANAGER 이거나, DEPTNO 10인 사원 출력하기
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE JOB = 'MANAGER'
UNION ALL
SELECT ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO = 10;

