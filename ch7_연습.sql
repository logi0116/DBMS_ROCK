ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

--날짜 데이터를 다루는 내장 함수
--현재 날짜
SELECT SYSDATE FROM DUAL;

--3개월 후 ADD_MONTHS(기준 날짜, 추가 개월)
SELECT ADD_MONTHS(SYSDATE,3) FROM DUAL;

--개월 차이 MONTHS_BETWEEN (A 날짜와 B 날짜)

--오늘날짜와 고용일
SELECT NEXT_DAY(SYSDATE, '금요일') FROM DUAL;

--다음 금요일 
--NEXT_DAY(해당 날짜의, 해당 요일)
SELECT NEXT_DAY(SYSDATE, 'Sunday') FROM DUAL; --왜인지 안 먹음. 영어로 하니 안 먹음
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL; --랭귀지가 한글로 되어 있어 서버 때문에 일요일 됨
SELECT NEXT_DAY(SYSDATE, '금요일') FROM DUAL;



--이번달 말(해당 날짜의 마지막 날)
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--날짜 반올림 / 버림
SELECT ROUND(SYSDATE, 'MONTH'), 
TRUNC(SYSDATE, 'MONTH')
FROM EMP;

--입사일로부터 10주년 구하기 
SELECT ENAME, ADD_MONTHS(HIREDATE, 120)
AS "10주년" 
FROM EMP;



--퀴즈 1. 입사일로부터 32년이 지나지 않은 사원만 출력해보기
SELECT ENAME, ADD_MONTHS(HIREDATE, 12*32)
AS "32년 미만사원" 
FROM EMP;  --실패. 입사일로부터 32년 이후의 사원
--결과 예시 이 코드가 실행되면 각 사원의 입사일에서 32년이 지난 날짜를 계산하여 출력돼요. 즉, 해당 사원이 입사한 날짜 + 32년 후의 날짜

SELECT ENAME, HIREDATE 
FROM EMP
WHERE HIREDATE <= ADD_MONTHS(SYSDATE, 12*32); --실패. 이 SQL 쿼리는 사원의 입사일(HIREDATE)이 현재 날짜(SYSDATE)에서 32년 후보다 이전인 사원을 조회하는 것이에요.

SELECT ENAME, HIREDATE 
FROM EMP
WHERE HIREDATE >= ADD_MONTHS(SYSDATE, -12*32); --실패 아예 조회 안 됨. 32를 1로 해도 안됨.


SELECT ENAME, HIREDATE 
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) <= 12;이것도 안 됨.



--개월 차이 MONTHS_BETWEEN (A 날짜와 B 날짜)


--퀴즈 2. 사원별로 입사일 기준 다음 월요일 출력해보기
SELECT ENAME, HIREDATE, NEXT_DAY(HIREDATE, '월요일') AS "다음 월요일" FROM EMP;


--퀴즈 3. 사원의 입사일을 기준으로 월 단위로 반올림해서 출력해보기

