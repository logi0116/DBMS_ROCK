



-- DECODE, CASE -> 조건문 쉽게 생각하기

--DECODE(표현식, 값1, 반환값1, 값2, 반환값2, ..., 기본값)

SELECT ENAME, JOB,
DECODE(JOB, 
'MANAGER', '관리자',
'CLERK', '사무직',
'SALESMAN', '영업직',
'PRESIDENT', '대표이사',
'ANALYST', '분석팀',
'기타') AS "직무 이름"
FROM EMP;


-- 부서 번호에 따라 부서명 출력 (CASE 출력)

SELECT ENAME, DEPTNO,
CASE DEPTNO
WHEN 10 THEN '인사부'
WHEN 20 THEN '연구개발부'
WHEN 30 THEN '영업부'
ELSE '기타부서'
END 
AS "CASE별 부서명" FROM EMP;


--급여에 따라 급여 등급 부여
--E : EMP, S : SALGRADE

SELECT E.ENAME, E.SAL,
CASE
WHEN E.SAL BETWEEN S.LOSAL AND S.HISAL THEN S.GRADE
END
AS "급여 등급"
FROM EMP E, SALGRADE S;
--아름답지 않게 나옴
--NULL인 부분을 처리하기는 해야함

SELECT M.ENAME, M.SAL,
CASE
WHEN M.SAL BETWEEN G.LOSAL AND G.HISAL THEN G.GRADE
END
AS "급여 등급"
FROM EMP M, SALGRADE G;  --처리 부분 바꿔봄




--퀴즈 1 DECODE로 JOB에 따른 직책 명시
--(CLERK 사원, manager 관리자, analyst 분석가)
--별칭 : 직책 이름

SELECT ENAME, JOB,
DECODE(JOB, 
'MANAGER', '관리자',
'CLERK', '사원',
'ANALYST', '분석가',
'기타') AS "직책 이름"
FROM EMP;


--퀴즈 2 case로 근속 연수 분류
--hiredate 기준, 1982년 이전 : 장기근속, 이후 : 일반
--별칭 : 근속 연수

SELECT * FROM EMP;

SELECT ENAME, HIREDATE,
DECODE(HIREDATE,
(HIREDATE > '1982.01.01'), '장기근속'),
(HIREDATE < '1982.01.01'), '일반'),
'기타') AS "근속 연수"
FROM EMP;

SELECT ENAME, HIREDATE,
CASE HIREDATE --hire 요게 중복으로 들어갔음
WHEN HIREDATE > '1982.01.01' THEN '장기근속'  --날짜에 ' '를 안 붙임
WHEN HIREDATE < '1982.01.01' THEN '일반'
END 
AS "근속 연수" FROM EMP;   --작성해본 코드. 이미 WHEN에 HIREDATE 가 정의되니 굳이 필요 없나보다.

SELECT ENAME, HIREDATE,
CASE 
    WHEN HIREDATE > '1982-01-01' THEN '일반'
    WHEN HIREDATE <= '1982-01-01' THEN '장기근속'
END AS "근속 연수"
FROM EMP;


--정답 타입이 문자열이 아니라 date라서 변경을 해야함
SELECT ENAME, HIREDATE, --여기서 쉼표 빼먹었음
CASE 
WHEN HIREDATE < TO_DATE('1982-01-01','YYYY-MM-DD') THEN '장기근속'  --여기서 날짜 뒤에 마침표 넣었음.
ELSE '일반'
END
AS "근속 연수" FROM EMP;





--퀴즈 3 case 단순형으로 deptno에 따라 위치 표시
--(10 : NEW YORK, 20: DALLAS, 30: CHICAGO)
--별칭 : 근무 지역

SELECT ENAME, DEPTNO,
CASE DEPTNO
WHEN 10 THEN 'NEW YORK'
WHEN 20 THEN 'DALLAS'
WHEN 30 THEN 'CHICAGO'
ELSE '미지정'
END 
AS "근무 지역" FROM EMP;


SELECT ENAME, DEPTNO,
CASE DEPTNO
WHEN 10 THEN 'NEW YORK'
WHEN 20 THEN 'DALLAS'
ELSE 'CHICAGO'
END 
AS "근무 지역" FROM EMP;






---

