--변환 함수, 날짜 <-> 문자열, 숫자 <-> 문자열
--타임 포맷 YYYY-MM-DD HH24:MI:SS
--현재 날짜를, YYYY-MM-DD 형식으로 출력. (원래는 초까지 나와야해서 변경하는 과정을 거쳤었음)
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;

--현재 날짜를 시분초로도 출력 가능
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:Mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:Mi:ss') FROM DUAL;

--급여를 천 단위로 쉼표 포함해서 출력,(왜인지 9를 써야 함)
SELECT ENAME,TO_CHAR(SAL, '999,999') FROM EMP;

--급여 끝자리 단위를 달러 표기해보기
SELECT '급여 : ' || TO_CHAR(3000,'999,999') 
|| '$' FROM DUAL;

--emp 테이블에서 해보기

SELECT ENAME, '급여 : ' || TO_CHAR(SAL,'999,999') 
|| '$' FROM emp;
SELECT ENAME, TO_CHAR(SAL,'999,999') 
|| '$' FROM emp;



ENAME,TO_CHAR(SAL, '999,999') FROM EMP;


--D day 예제, 문자열 타입 -> 데이트 날짜 타입 변환
SELECT 
TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE
AS "6/1기념일 D-day" FROM DUAL;

SELECT 
ROUND(TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE,0)
AS "6/1기념일 D-day" FROM DUAL;

SELECT 
TRUNC(TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE,0)
AS "6/1기념일 D-day" FROM DUAL;

SELECT 
CEIL (TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE)
AS "6/1기념일 D-day" FROM DUAL; --이건 왜 안 될까? --sysdate이후 ,0이 문제였음. 두번째 인수를 받을 수 없는 함수라서.


--D DAY까지 남은 시간 표기하기 위해 
SELECT 
TRUNC((TO_DATE('2025-06-01', 'YYYY-MM-DD') - SYSDATE)*24)
AS "6/1기념일 D-day" FROM DUAL;





--퀴즈 1 1981년 6월 1일 이후 입사한 사원 출력해보기
--주어진 조건의 날짜가 문자열 타입인데,
--문자열에서 > 날짜 타입으로 변환했음


desc emp;

SELECT * FROM EMP WHERE HIREDATE > '1981-06-01';
SELECT * FROM EMP WHERE HIREDATE > DATE '1981-06-01';

--정답, DATE 타입으로 되어있기 때문에 DATE 문자열을 지정된 형식으로 바뀐 뒤에 했음. 시간은 클수록 최신.

SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981-06-01', 'YYYY-MM-DD');

--퀴즈 2 월과 요일을 각각 'MM월', '요일' 형식으로 출력해보기
--해당 날짜를 문자열 타입으로 변환하는 것임

SELECT SYSDATE; --FROM DUAL 뺌
SELECT SYSDATE > TO_DATE(SYSDATE,'YYYY-MM-DD') FROM DUAL; --시도 1. 문제를 잘못 이해함.

SELECT TO_CHAR(SYSDATE, 'MM"월"') AS "월",
TO_CHAR(SYSDATE, 'DD"요일"') AS "요일"
FROM DUAL;

--정답
SELECT TO_CHAR(SYSDATE, 'MM"월"') AS "월",
TO_CHAR(SYSDATE, 'DAY') AS "요일"
FROM DUAL;







--퀴즈 3 숫자 문자열을 '1,200'을 숫자로 변환해서 300을 더한 값 출력해보기
--해당 문자열(1,200)을, 9,999 형태 바꿔주고 + 300을 더해줘
SELECT TO_NUBER('1,200', '9,999') + 300 as "결괏값" FROM DUAL;
SELECT TO_NUMBER('1,200', '9,999') + 300 as "결괏값" FROM DUAL;



-- NVL, NVL2 함수 기본 예시 

-- 급여가 NULL 이면 0으로 대체 
SELECT ENAME, JOB, COMM, NVL(COMM,0) AS "수당"
FROM EMP;

-- 커미션이 있으면 'O', 없으면 'X'
SELECT ENAME, NVL2(COMM,'O','X') AS "NVL2함수"
FROM EMP;

SELECT * FROM DEPT;
SELECT * FROM EMP;

--퀴즈1 
-- EMP 테이블에서 커미션이 있는 직원 'O', 나머지 'X'로 표시하고  NVL2  표기 
-- 별칭 수당 여부

SELECT ENAME, JOB, COMM, NVL2(COMM,'O', 'X') AS "별칭 수당 여부" FROM EMP;
SELECT ENAME, JOB, COMM, NVL(COMM,0) AS "전체 급여" FROM EMP;

-- 전체 급여 계산해보기, NVL 이용해서,  NULL 인 경우, 0으로 해서 계산 해보기 
-- 별칭 전체 급여


SELECT ENAME, JOB, COMM, NVL(COMM,0) AS "전체 급여" FROM EMP;

--합쳐서
select ENAME, NVL2(COMM,'O','X') AS "수당 여부",
SAL * 12 + NVL(COMM,0) AS "전체 급여"
FROM EMP;

