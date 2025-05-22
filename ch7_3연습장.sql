--그룹으로 나눈 대상에, 필터 (집계하기),
--평균, 갯수, 최대, 최소, 카운트
--기본 문법

--SELECT 그룹열, 집계함수
--FROM 테이블명
--[WHERE 조건]      -- 행 필터링
--GROUP BY 그룹열
--[HAVING 집계조건]  -- 그룹 필터링
--ORDER BY 정렬조건;


-- 평균 급여가 2000 이상인 부서 출력해보기

SELECT DEPTNO, AVG(SAL) FROM EMP
GROUP BY DEPTNO
HAVING AVG (SAL) >=  2000;

-- 사원수가 3명 이상인 직책(잡) 그룹만 출력
-- 대사 형식으로 풀어보기

SELECT JOB, COUNT(*) FROM EMP    --그룹열 JOB을 EMP에서 모두 집계하라
GROUP BY JOB  --그룹열 JOB으로 그룹 짓고 적용하라
HAVING COUNT(*) >= 3;  --3이상인 것을 집계해서


--WHERE 절과 HAVING 절 같이 사용해보기.



--조건을 기반으로 한 평균 급여 필터링 예시
--순서
--1. EMP 테이블에서 JOB = 'SALESMAN' 조건을 만족하는 행만 선택
--2. 선택된 SALESMAN 들 중 DEPTNO 기준으로 그룹화 (그래서 전부 다 30번)
--3. 각 그룹별로 AVG(SAL) 계산 
--4. 평균이 1500보다 큰 그룹만 출력. (평균이 1500이 안 넘었음)


SELECT DEPTNO, AVG(SAL) FROM EMP 
WHERE JOB = 'SALESMAN' 
GROUP BY DEPTNO
HAVING AVG(SAL) > 1500;
--그룹별은 DEPTNO로 하는데 잡의 조건은 세일즈맨이고 그 평균 급여를 구해보겠다
--그룹은 부서별로 나눠서 평균 급여가 1500이상인 걸 구하지만 WHERE를 써서 세일즈맨인 것을 구한다


--조건 기반 평균 급여 필터링 예시 2
SELECT DEPTNO, AVG(SAL) FROM EMP
WHERE JOB = 'SALESMAN'
GROUP BY DEPTNO
HAVING AVG(SAL) > 1000;




--퀴즈1 평균 급여가 2500 이상인 부서번호와 직책별 평균 급여를 출력
--별칭 : 평균 급여
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2500;


--퀴즈2. 부서별 사원 수가 4명 이상인 부서만 출력
--별칭 : 사원수
SELECT DEPTNO, COUNT(*) FROM EMP   
GROUP BY DEPTNO
HAVING COUNT(*) >= 4; 


--퀴즈3. WHERE 절을 사용해서 부서번호가 10, 20 필터링하고,
--그 중에서 평균 급여가 3000이상인 부서만 출력하기.
--별칭 : 평균 급여

SELECT DEPTNO, AVG(SAL) FROM EMP
WHERE DEPTNO NOT IN (10, 20)
GROUP BY DEPTNO
HAVING AVG(SAL) > 3000;

