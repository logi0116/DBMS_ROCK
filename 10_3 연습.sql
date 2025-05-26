--기본 문법
--조건에 맞는 데이터 삭제

DELETE FROM EMP WHERE JOB = 'CLERK'; -- Example: Deletes rows where the job is 'CLERK'


--서브쿼리 활용한 삭제

--테이블을 자체로 삭제
DROP TABLE EMP_TEMP2;

--전체 행 삭제
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;




rollback;
commit;

-- 퀴즈1, 
-- EMP_TEMP2 테이블에서 급여가 3000 이상인 사원을 삭제하시오. 
 DELETE FROM EMP_TEMP2 WHERE SAL >= 3000;   
SELECT * FROM EMP_TEMP2;






-- 퀴즈2, 
-- EMP_TEMP2 테이블에서 부서번호가 10 또는 20인 사원을 삭제하시오.
DELETE FROM EMP_TEMP2 WHERE DEPTNO IN (10, 20);
select * from EMP_TEMP2;




-- 퀴즈3, 
-- EMP_TEMP2 테이블의 모든 데이터를 삭제하시오.
DELETE FROM EMP_TEMP2;
SELECT * FROM EMP_TEMP2;

