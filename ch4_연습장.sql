select * from dept; 
select * from emp;
select * from salgrade; 

desc emp;
desc dept;
desc salgrade;

--행 기준으로 검색, where 조건 이용
--오라클 sql 디벨로퍼에서 주석은 (-) 2번이다


SELECT * FROM EMP WHERE JOB = 'MANAGER';

--열 기준으로 프로젝션, 보고 싶은 열만 선택해서 조회해보기 
select ename, job FROM emp;
select ename, job FROM emp WHERE JOB = 'MANAGER';


--기본 퀴즈 1
--SALES 부서 소속 직원만 조회
--기존 작성한 틀린 코드 SELECT * FROM EMP WHERE  = 'SALESMAN';
--SELECT * FROM dept where DEPTNO = '30';
--SELECT * FROM emp where DNAME = 'SALES'; 조금 더 이해해보기
SELECT * FROM emp where DEPTNO = '30';


--1️⃣ SELECT * FROM EMP WHERE DNAME = 'SALES'; 🔹 오류 발생 → EMP 테이블에는 DNAME(부서명) 컬럼이 없음 🔹 부서명은 DEPT 테이블에 존재하므로 직접 조회할 수 없음 🔹 JOIN을 사용해야 정확한 결과를 얻을 수 있음
--2️⃣ SELECT * FROM EMP WHERE DEPTNO = '30'; 🔹 정상 작동 → DEPTNO는 EMP 테이블에 존재하는 부서 번호 🔹 즉, EMP 테이블에서 부서번호 30인 직원들을 올바르게 조회 가능
--📌 올바른 방법: 부서명(DNAME)으로 조회하기
--부서명으로 직원 데이터를 조회하려면 EMP 테이블과 DEPT 테이블을 JOIN해야 해요.

SELECT * 
FROM EMP e 
JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE d.DNAME = 'SALES';




--기본 퀴즈 2
--프로젝션 - 사원명과 입사일만 조회
SELECT ENAME, HIREDATE from emp;

desc emp;
--기본 퀴즈3
--급여가 3000 이상인 직원만 조회
SELECT * FROM EMP WHERE SAL >= 3000;

--기본 퀴즈 4
--EMP 테이블에서 이름(ename), 급여(sal), 부서번호(deptno)만 조회해보기
--SELECT * FROM EMP WHERE ENAME, SAL, DEPTNO ; 기존의 틀린 코드
SELECT ENAME, SAL, DEPTNO FROM EMP;

SELECT ENAME, SAL FROM EMP WHERE SAL BETWEEN 2000 AND 3000;
--emp 테이블에서 급여가 2000이상이고 3000이하인 직원들의 이름과 급여를 조회하려면?

SELECT ENAME, SAL FROM EMP WHERE SAL <= 3000;
--emp 테이블에서 급여가 3000이하(같거나 적은)인 직원들의 이름과 급여를 조회하려면?

SELECT ENAME, SAL FROM EMP WHERE SAL >= 2000;
--emp 테이블에서 급여가 2000이상인 직원의 이름과 급여를 조회하려면?
-->는 오른쪽으로 가니까 이상
--< 는 왼쪽으로 가니까 이하
SELECT ENAME, SAL FROM EMP WHERE SAL = 2000 OR SAL = 3000;
--emp 테이블에서 급여가 2000이거나 3000인 사람을 조회하려면?

SELECT ENAME, SAL, DEPTNO FROM EMP;
--emp 테이블에서 이름과 급여와 부서를 조회하고 싶다.

--SELECT ENAME, JOB FROM EMP WHERE DEPTNO != 10;

SELECT ENAME, SAL FROM EMP WHERE SAL BETWEEN 1400 AND 2000;

SELECT ENAME, SAL FROM EMP WHERE SAL >= 1400;

SELECT ENAME, SAL FROM EMP WHERE SAL <= 2000;

SELECT ENAME, SAL FROM EMP WHERE SAL = 1400 OR SAL = 2000;


SELECT ENAME, SAL FROM EMP WHERE JOB = 'MANAGER';


--------------------------------------------------------------------------------------
--distinct 중복 제거

select distinct job from emp;  --중복 제거함
select job from emp;  --all, 중복 포함
select all job from emp; --위의 코드와 동일 


--직무 + 부서 번호 조합의 고유 데이터 추출
--JOB 직무, 부서 번호 조합의 중복 되지 않는 행만 조회
--결론, DISTINCT 활용하면 동일한 직무와 동일한 부서 번호를 가진 직원이 
--여러명 있어도 한번만 결과에 나타남
select DISTINCT JOB, DEPTNO FROM EMP;   --DEPT job항목에서 중복 제거해서 9개 결과. 
--하나의 컬럼에 적용되는 게 아니라 두개 이상의 컬럼이 하나처럼 취급이 되어서 동작 
--예시 select DISTINCT 잡, 이름, 부서, 월급 FROM EMP;   --잡, 이름, 부서, 월급 4개 항목에 적용되는 DISTINCT
select job, DEPTNO FROM emp;   --모든 DEPT와 JOB을 중복 제거 없이 나와서 14개 결과


--퀴즈
--EMP 테이블에서 중복되지 않는 부서번호만 출력하기
select distinct deptno from emp;  
SELECT DISTINCT DEPTNO FROM EMP ORDER BY DEPTNO; -- emp테이블에서 부서번호를 출력하고, 정렬하기


--퀴즈2
--EMP 테이블에서 사원 직무와 부서번호
--조합이 고유한 결과 한번더 해보기
select DISTINCT JOB, DEPTNO FROM EMP;
select DISTINCT DEPTNO, JOB FROM EMP;



--퀴즈 3
--EMP 테이블에서 중복을 제거하지 않고 
--사원의 직무와 부서 번호를 모두 출력하기
--ALL 키워드 이용해보기

select JOB, DEPTNO FROM EMP;
select ALL JOB, DEPTNO FROM EMP;
select ALL JOB AS 직무명, DEPTNO AS "부서 명칭" FROM EMP;
--틀린 예시. 쌍따옴표 대신 홑따옴표 select ALL JOB AS 직무명, DEPTNO AS '부서 명칭' FROM EMP;

----------------------------------------------------------------------
--ALIAS 별칭 사용해보기

SELECT ENAME AS "사원명" FROM EMP;
SELECT ENAME AS "사원 명칭" FROM EMP;
SELECT ENAME "사원 이름" FROM EMP;   --as 생략도 가능하지만 가급적 쓰기


SELECT ENAME AS "사원명", SAL AS "월급" FROM EMP;
SELECT ENAME AS "사원명", SAL*12 AS "연봉" FROM EMP;  --월급에 12를 곱해서 연봉이 됨. 데이터가 문자가 아니라 숫자면 가능한듯.
SELECT ENAME AS "사원 명칭" FROM EMP;



SELECT SAL "연봉" FROM EMP;   --as 생략도 가능하지만 가급적 쓰기



--
--퀴즈1
--EMP 테이블에서 사원 이름 '각자 정하고 싶은 이름'
--별칭을 부여해서 출력해보기;
SELECT ENAME AS "캐릭터" FROM EMP;


--퀴즈2
--EMP 테이블에서 급여(SAL)를 연봉으로 계산해서 출력해보기 한번 더

SELECT SAL AS "월급" FROM EMP;
SELECT SAL*12 AS "연봉" FROM EMP;

SELECT COMM FROM EMP;

--퀴즈3
--사원명과 직무를 각각 '사원이름', '직무'로 출력해보기;

SELECT ENAME AS "사원이름", JOB AS "직무" FROM EMP;

--퀴즈4 (조금 어려울 수 있음)
--사원명과 급여, 그리고 커미션(COMM)이 있을 경우
--총 수입을 계산하기, 그리고 출력 별칭은 총 급여"로 지정하기.
--특정 옵션 함수인 NVL 활용하기
--NVL (COMM, 0) : 커미션(COMM)이 있으면, COMM 값으로 출력
--COMM이 없으면, 0 값으로 출력


--SELECT ENAME AS "사원명", JOB AS "직무", NVL (COMM, 0) FROM EMP; --
--COMM AS "커미션", SAL AS "총수입" FROM EMP;
--SELECT DISTINCT (NULL)AS "커미션" FROM EMP;
--SELECT SAL COMM(COMM,0) AS "총수입" FROM EMP;
--select DISTINCT COMM, SAL FROM EMP;
--SELECT NVL(COMM, 0) AS "수당" FROM EMP;
--SELECT ENAME AS "사원명", SAL+COMM AS "총 급여"; -- 틀림

SELECT ENAME AS "사원명", SAL+NVL(COMM, 0) AS "총 급여" FROM EMP;
SELECT ENAME AS "사원명", (SAL + NVL(COMM, 0))*12 AS "총 연봉" FROM EMP;

SELECT ENAME AS "사원명", NVL(SAL, 0) AS "급여" FROM EMP;


