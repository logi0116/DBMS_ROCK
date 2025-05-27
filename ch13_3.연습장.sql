

기본 개념

-- View
-- SELECT 결과를 가상의 테이블로 저장한 객체

-- Inline View
-- FROM절 내부에 작성된 SELECT 서브쿼리

-- WITH View
-- WITH절로 이름을 붙여 사용하는 인라인 뷰

-- ROWNUM
-- 결과 행 번호(Oracle 전용), TOP-N 필터링에 사용

--기본 문법 예시
-- 뷰 생성

create view EMP_VIEW AS  -- 뷰이름 : EMP_VIEW
-- 뷰 정의 : emp 테이블에서 deptno가 10인 사원 정보 조회 > 뷰에 넣을 예정
SELECT empno, ename, deptno FROM emp where deptno = 10; 


--데이터 사전이용해 뷰 정보를 조회
select * from user_views where view_name = 'EMP_VIEW';

--뷰 내용 조회 
select * from EMP_VIEW;

--뷰 삭제
drop view EMP_VIEW;

--인라인 뷰 사용 예시
--현재 총 사원은 19명
select * from (select empno, ename, sal from emp);



select * from 
(select empno, ename, sal from emp)  --서브 쿼리
         where rownum <= 5; -- 상위 5개만 조회


--rownum을 같이 출력하는 예제
select rownum, empno, ename, sal
  from (select empno, ename, sal from emp)
 where rownum <= 5;

 select rownum, empno, ename, sal
  from (select empno, ename, sal from emp); --rownum을 같이 출력해서 모든 사원을 보이는 예제
 


--with 절을 사용한 뷰 예제
WITH EMP_SAL_TOP_3 AS (
    SELECT empno, ename, sal FROM emp ORDER BY sal DESC
) --상위 3개 행만 조회
SELECT * FROM EMP_SAL_TOP_3 WHERE ROWNUM <= 3;

--emp 테이블에서 부서번호가 20인 사원만 표시하는 뷰 생성
create view EMP_DEPT20_VIEW AS
SELECT empno, ename, deptno FROM emp WHERE deptno = 20;


--뷰에서 데이터 조회
select * from EMP_DEPT20_VIEW;

--생성된 뷰의 구조 정보 확인
desc EMP_DEPT20_VIEW;

--생성 뷰 삭제
drop view EMP_DEPT20_VIEW;

desc dept;
select * from dept;

-- 뷰이름 : EMP_VIEW
-- 뷰 정의 : emp 테이블에서 deptno가 10인 사원 정보 조회 > 뷰에 넣을 예정



-- 퀴즈1, 
--  SAL이 높은 상위 5명을 추출하는 뷰 emp_top5를 생성하시오.
CREATE VIEW EMP_TOP5 AS 
SELECT  * FROM (
    SELECT EMPNO, ENAME, SAL FROM EMP 
    WHERE SAL IS NOT NULL
    ORDER BY SAL DESC
) WHERE ROWNUM <= 5;
-- DROP VIEW EMP_TOP5;
-- 가상 뷰 작업 하기 전에, 실제 쿼리 동작 여부 확인, (단위테스트)
-- SELECT ROWNUM,EMPNO, ENAME, SAL   FROM (
--     SELECT EMPNO, ENAME, SAL FROM EMP 
--     WHERE SAL IS NOT NULL
--     ORDER BY SAL DESC
-- ) WHERE ROWNUM <= 5;

-- 제 데이터에는 널이 포함이 되어 있어서, 일단 서브 쿼리 결과 먼저 체크 후, 
--  SELECT EMPNO, ENAME, SAL FROM EMP 
--  WHERE SAL IS NOT NULL
--     ORDER BY SAL DESC;

-- 뷰에서 데이터 조회
SELECT * FROM EMP_TOP5;
 
-- 퀴즈2, 
-- 인라인 뷰를 사용해 부서별 평균 급여를 구한 뒤, 평균이 2000 이상인 부서만 추출하시오.
  SELECT * FROM (
    SELECT DEPTNO, AVG(SAL) AS AVG_SAL FROM EMP 
    GROUP BY DEPTNO
  ) WHERE AVG_SAL >= 2000;

  SELECT * FROM DEPT;
-- 퀴즈3, 
--  WITH절을 이용해 JOB별 최고 급여를 구한 후, 최고급여가 2500 이상인 직무만 출력하시오.
WITH JOB_SAL_MAX AS (
    SELECT JOB, MAX(SAL) AS MAX_SAL FROM EMP 
    GROUP BY JOB
)
SELECT * FROM JOB_SAL_MAX WHERE MAX_SAL >= 2500;








-- 퀴즈 3. with 절을 이용해 job별 최고급여를 구한 후, 최고급여가 3000이상인 직무만 추출하시오.


