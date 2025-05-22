-- 위에서 만든, 가로로 변환한 예를 다시, 세로 방향으로 변환. 
UNPIVOT (
    SAL FOR JOB IN (
    "사무직" AS 'CLERK', 
@@ -98,7 +99,43 @@ ORDER BY DEPTNO, JOB;

-- UNPIVOT 간단한 예시 
-- 열 기준의 급여 데이터를 연도 기준 행으로 전환하기. 
-- 실제로 출력이 되는 컬럼은 
-- EMPNO, ENAME, 항목, 금액

SELECT EMPNO, ENAME, 항목, 금액 
FROM (
    SELECT EMPNO, ENAME, SAL, COMM FROM EMP
)
-- UNPIVOT : 열 -> 행으로 변환하는 절
UNPIVOT (
    -- 실제 값이 들어갈 컬러명
    금액 
    -- 어떤 항목인 구분하는 컬럼명, 
    -- (예시:급여, 커미션)
    FOR 항목 
    IN (
    -- SAL, COMM UNPIVOT의 대상이 되는 열
    -- SAL 컬럼을 급여이라는 별칭 변환
        SAL AS '급여',
    -- COMM 컬럼을 수당이라는 별칭 변환
        COMM AS '수당'
    )
);





--퀴즈 1
-- EMP 테이블에서 SAL, COMM 을 UNPIVOT 한 후, 
-- 항목별 (급여/커미션) 전체 합계를 구하기. 
-- 별칭 : 항목, 총합계


--퀴즈에 앞서서 기본 개념
SELECT ENAME, SAL, COMM FROM EMP; --기존 테이블, 가로로 배치
--ENAME SAL COMM 
--킹    5000  NULL  이런 식으로 가로로 배열

--UNPIVOT 을 적용하면 데이터가 세로로 배치. 
--간단히 말하면 가로 데이터를 세로 데이터로 바꾸는 것. *요 부분을 확실히 기억할 것

--ENAME  항목(새 임의 컬럼) 금액(새 임의 컬럼)
--킹    SAL(별칭:급여)       5000
--킹    COMM(별칭:수당)      NULL




--풀이

SELECT 항목, SUM(금액) AS "총합계"   --임의의 '항목'을 만들었고, 언피벗을 할 건데 이후가 핵심
    FROM (                         --중요한 대목, UNPIVOT이 되는 대상 컬럼
        SELECT ENAME, SAL, COMM FROM EMP   --SAL과 COMM이 대상이 되는 데이터. 원래 가로로 배치가 된 데이터
                                    --이 데이터들을 변환해서, 세로로 배치할 계획. 일단 대상에 초점은 맞춰졌음. 명령을 기다리는 중.
        )   

    UNPIVOT (
        금액 FOR 항목 IN(               --금액은 실제로 값[SAL, COMM같은)이 들어가는 구간, 그걸 항목 쪽으로 FOR 하겠다 어떤 걸? 
                                      --항목에 들어갈 금액에서 IN은 SAL이면 "급여"로 "COMM"이면 "수당"이라고 하겠다. 
        SAL AS '급여',                 
        COMM AS '수당'
        )         
    )
    GROUP BY 항목;
    
    
    
--풀이 2


SELECT ENAME, 항목, SUM(금액) AS "총합계"   --임의의 '항목'을 만들었고, 언피벗을 할 건데 이후가 핵심
    FROM (                         --중요한 대목, UNPIVOT이 되는 대상 컬럼
        SELECT ENAME, SAL, COMM FROM EMP   --SAL과 COMM이 대상이 되는 데이터. 원래 가로로 배치가 된 데이터
                                    --이 데이터들을 변환해서, 세로로 배치할 계획. 일단 대상에 초점은 맞춰졌음. 명령을 기다리는 중.
        )   

    UNPIVOT (
        금액 FOR 항목 IN(               --금액은 실제로 값[SAL, COMM같은)이 들어가는 구간, 그걸 항목 쪽으로 FOR 하겠다 어떤 걸? 
                                      --항목에 들어갈 금액에서 IN은 SAL이면 "급여"로 "COMM"이면 "수당"이라고 하겠다. 
        SAL AS '급여',                 
        COMM AS '수당'
        )         
    )
    GROUP BY ENAME, 항목;