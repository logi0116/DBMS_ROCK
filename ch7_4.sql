--다양한 고급 그룹화 함수 기능 소개

--부서별, 직책별 급여 합계 (ROLLUP)
--원래는 HAVING을 써야했는데 ROLLUP을 이용해서 좀더 쉽게 정리 가능.
--해석
--SELECT 부서, 직책, SUM(급여)
--FROM EMP
--GROUP BY ROLLUP(부서, 직책);
--상위 항목(부서) -> 하위항목 (직책) 순서로 요약
--마지막 행은 전체 총합

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);


--CUBE : 모든 조합 분석
--기본 문법
--SELECT 부서, 직책, SUM(급여)
--FROM EMP
--GROUP BY CUBE(부서, 직책);
--ROLLUP 보다 더 많은 조합 생성
--(부서, 직책), (부서), (직책) 모든 집계 조합 가능.

SELECT DEPTNO, JOB, SUM(SAL) AS "총 급여"
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);


--GROUPING
--집계로 인한 NULL 여부 식별에 사용함 (집계를 통해 진짜 데이터인지 아닌지를 구분할 때 쓰는)
--다음 활용에서 1이라된 것은 집계를 할 때 사용하지 않을 때의 공란. 즉, NULL 데이터. 
--0이라 되어있는 것은 실제 데이터다.
--기본 문법
--SELECT 컬럼1, 컬럼2, 집계함수(컬럼3),
--GROUPING(컬럼1) AS 그룹1,
--GROUPING(컬럼2) AS 그룹2
--FROM 테이블 명
--GROUP BY ROLLUP(컬럼1, 컬럼2);

--DEPTNO = 1 이면 전체 집계로 생긴 NULL
--JOB = 1 이면 부서 합계로 생긴 NULL

SELECT DEPTNO, JOB, SUM(SAL) AS "총 급여",
GROUPING(DEPTNO) AS "GROUP_DEPTNO",
GROUPING(JOB) AS "GROUP_JOB"
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);



--쿼리 안에 쿼리가 들어가는 서브 쿼리
-- PIVOT
-- 기본 문법
-- 행 -> 열로 전환하기
-- 기본 문법
-- SELECT * 
-- FROM (
-- SELECT 기준 컬럼, 피벗컬럼, 값 컬럼 FROM 테이블명
-- )
-- PIVOT (
-- 집계함수 (값 컬럼)
-- FOR 피벗컬럼 IN (값1 AS 별칭1, 값2 AS 별칭2, ....)
-- );


--직책별 급여 합계를 부서별로, 가로 형태로 전환
SELECT *
FROM ( SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT (
SUM(SAL)
FOR JOB IN ('CLERK' AS "사무직", 'MANAGER' AS "관리자", 'ANALYST' AS "분석가")
);




--UNPIVOT 
--열 데이터를 다시 행으로 전환
--기본 문법
--SELECT *
--FROM (SELECT 기준 컬럼, 열1, 열2, ...FROM 테이블명)
-- UNPIVOT (
-- 값 컬럼 FOR 피벗 컬럼 IN (열1, 열2, ...)
--);

--위에서 PIVOT 된 결과를 다시 행으로 변환

SELECT DEPTNO, JOB, SUM(SAL)
FROM (
SELECT * 
    FROM (
    SELECT DEPTNO, JOB, SAL
    FROM EMP
    )
    PIVOT(
        SUM(SAL) FOR JOB IN 
      ('CLERK' AS "사무직", 'MANAGER' AS "관리자", 'ANALYST' AS "분석가")
      )
)
UNPIVOT (
    SAL FOR JOB IN ("사무직" AS 'CLERK', "관리자" AS 'MANAGER', "분석가" AS 'ANALYST')
    );
 
GROUP BY DEPTNO, JOB;


--수정해보기

-- 컬럼명 한글로 하면 가능하다고, 검토
SELECT DEPTNO, JOB, SUM(SAL) AS "총급여"
FROM ( 
SELECT * 
    FROM ( 
    SELECT DEPTNO, JOB, SAL
    FROM EMP
    )
    PIVOT(
    SUM(SAL) FOR JOB IN 
    ('CLERK' AS "사무직", 'MANAGER' AS "관리자",
    'ANALYST' AS "분석가")
    )
)
UNPIVOT (
    SAL FOR JOB IN (
    "사무직" AS 'CLERK', 
    "관리자" AS 'MANAGER',
    "분석가" AS 'ANALYST')
)
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;





GPT 예시
--1
SELECT *
FROM  (
--2
SELECT DEPTNO, 사무직, 관리자, 분석가
   FROM (
   --3
   SELECT * 
       FROM (
       --4
    SELECT DEPTNO, JOB, SAL FROM EMP
    )
    PIVOT (
    SUM(SAL) FOR JOB IN
    ('CLERK' AS "사무직", 'MANAGER' AS "관리자", 'ANALYST' AS "분석가")
    )
   )
  )
UNPIVOT (
    TOTAL_SAL FOR JOB_TITLE IN (사무직, 관리자, 분석가)
);  


    
    --PIVOT 
    
    
    
    
    
--UNPIVOT 간단한 예시
--열 기준의 급여 데이터를 연도 기준 행으로 전환하기.
--실제로 출력이 되는 컬럼은
--EMPNO, ENAME, 항목, 금액
SELECT EMPNO, ENAME, 항목, 금액   --요렇게 조회가 됨
   FROM (           --프롬1 시작
    SELECT EMPNO, ENAME, SAL, COMM FROM EMP  
)                   --프롬1 끝

-- UNPIVOT : 열 -> 행으로 변환하는 절(스태트먼트)

UNPIVOT (        --UNP 1 시작
 금액      --실제 값이 들어갈 컬럼명
 FOR 항목   --각각의 항목을 어떤 것으로 인식할지 구분하는 용도로 사용하는 컬럼, (예시 : 급여, 커미션, 영어든 뭐든. 대신 위와 일치 필요)
 IN (   --IN 연산자 시작
     SAL AS "급여",  --SAL 컬럼에 급여라는 별칭 부여
    COMM AS "수당",  --COMM 컬럼에 수당이라는 별칭 부여
    
 )   --IN 연산자 끝
); -- UNP 1 끝




--퀴즈 1
--emp테이블에서 SAL, COMM 을 UNPIVOT 한 후,
--항목별 (급여/커미션) 전체 합계를 구하기.
-- 별칭 : 항목, 총합계



--UNPIVOT 
--열 데이터를 다시 행으로 전환
--기본 문법
--SELECT *
--FROM (SELECT 기준 컬럼, 열1, 열2, ...FROM 테이블명)
-- UNPIVOT (
-- 값 컬럼 FOR 피벗 컬럼 IN (열1, 열2, ...)
--);

--위에서 PIVOT 된 결과를 다시 행으로 변환

SELECT *
FROM (SELECT SAL, COMM 
