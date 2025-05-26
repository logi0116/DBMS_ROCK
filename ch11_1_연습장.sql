--하나의 단위로 데이터를 처리하는 트랙잭션

--기본문법
--데이터 변경
select *
  from emp_copy;


--데이터 복사
insert into emp_copy
   select *
     from emp;

--테이블 만들기
create table emp_copy2


--emp_copy 순서 1. 테이블 데이터 변경
update emp_copy
   set
   sal = sal + 10000
 where deptno = 10;
     
-- 순서2. 트랜잭션 저장
commit;

--순서3. 트랜잭션 취소
rollback;

--순서4. 특정 지점으로 설정
savepoint sp1;

--순서5. 특정 지점으로 롤백
rollback to sp1;


--테이블을 생성. 단순 빈테이블 생성
create table EMP_COPY2 AS SELECT * FROM EMP WHERE 1=0;

create table EMP_COPY2 AS SELECT * FROM EMP WHERE 1=1; 
-- EMP_COPY2 테이블을 EMP 테이블과 동일한 구조로 생성




-- EMP > EMP_COPY2 테이블 복사 후 퀴즈 진행

INSERT INTO EMP_COPY2 SELECT * FROM EMP;

--테이블 EMP_COPY2 삭제

DROP TABLE EMP_COPY2;


select * from EMP_COPY2;

select * from EMP;

-- 퀴즈1. 부서번호가 20인 사원들의 급여를 10% 인상 후
-- 조건에 따라 되돌릴 수 있도록 savepoint를 (SP2) 설정하시오
update EMP_COPY2
   set
   sal = sal * 1.1
 where deptno = 20;
 
 ROLLBACK;
 COMMIT;

--세이브 포인트 설정
savepoint SP1;





-- 퀴즈2, 사번이 7839인 사원의 급여를 5000으로 변경하고,

update EMP_COPY2
   set
   sal = 3000
 where EMPNO = 7839;


-- 이 작업만 rollback 하시오.

select * from EMP_COPY2;

ROLLBACK TO SP1;



롤백을 통해 SP1 지점으로 되돌리기



ROLLBACK TO SP1;



-- 퀴즈3. 여러 UPDATE 작업 수행 후 COMMIT 하지 않고 
-- 전체를 ROLLBACK 하시오.

ROLLBACK