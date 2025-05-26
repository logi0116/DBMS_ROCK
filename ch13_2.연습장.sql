-- =============================
-- 인덱스 실습 전 모든 인덱스 삭제 (정리용)
-- =============================
-- 인덱스 삭제(존재하지 않으면 에러가 날 수 있으니 필요시 예외처리)
begin
   execute immediate 'DROP INDEX EMP_INDEX_TEST_ENAME_IDX';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP INDEX EMP_INDEX_TEST_JOB_DEPTNO_IDX';
exception
   when others then
      null;
end;
/
begin
   execute immediate 'DROP INDEX EMP_INDEX_TEST_USERNAME_IDX';
exception
   when others then
      null;
end;
/

-- =============================
-- 인덱스 개념
-- =============================
-- 인덱스(Index)는 테이블의 특정 컬럼에 대해 검색 속도를 높여주는 데이터베이스 객체입니다.
-- 인덱스가 없으면 조건 검색 시 테이블 전체를 탐색(Full Scan)하지만,
-- 인덱스가 있으면 해당 컬럼을 빠르게 찾아갈 수 있습니다.
-- 인덱스는 SELECT의 WHERE, JOIN, ORDER BY, GROUP BY 등에 자주 사용되는 컬럼에 생성하면 효과적입니다.

-- =============================
-- 1. 테스트용 테이블 생성 (사원 정보 대용)
-- =============================
create table emp_index_test (
   empno    number(6) primary key, -- PK 인덱스 자동 생성
   ename    varchar2(50),
   job      varchar2(20),
   mgr      number(6),
   hiredate date,
   sal      number(8,2),
   comm     number(8,2),
   deptno   number(2)
);


-- =============================
-- 2. 대량 더미 데이터 삽입 (10만 건)
-- =============================
begin
   for i in 1..100000 loop
      insert into emp_index_test (
         empno,
         ename,
         job,
         sal,
         deptno
      ) values ( 10000 + i,
                 'USER' || i,
                 case mod(
                    i,
                    5
                 )
                    when 0 then
                       'CLERK'
                    when 1 then
                       'MANAGER'
                    when 2 then
                       'SALESMAN'
                    when 3 then
                       'ANALYST'
                    else
                       'PRESIDENT'
                 end,
                 1000 + mod(
                    i,
                    5000
                 ),
                 mod(
                    i,
                    4
                 ) * 10 + 10  -- 10, 20, 30, 40 중 하나
                  );
   end loop;
   commit;
end;
/

-- =============================
-- 3. 데이터 확인
-- =============================
select count(*) as total_rows
  from emp_index_test;

select *
  from emp_index_test
 where rownum <= 5;

-- =============================
-- 4. 인덱스 없는 상태에서 특정 사용자 검색 (풀 테이블 스캔)
-- =============================
select *
  from emp_index_test
 where ename = 'USER50000';

explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000';
select *
  from table ( dbms_xplan.display );
-- TABLE ACCESS FULL이 나오면 인덱스 미사용(느림)

-- =============================
-- 5. ENAME 컬럼에 인덱스 생성
-- =============================
create index emp_index_test_ename_idx on
   emp_index_test (
      ename
   );

-- =============================
-- 6. 인덱스 생성 후 동일 쿼리 실행 (INDEX RANGE SCAN)
-- =============================
select *
  from emp_index_test
 where ename = 'USER50000';

explain plan
   for
select *
  from emp_index_test
 where ename = 'USER50000';
select *
  from table ( dbms_xplan.display );
-- INDEX RANGE SCAN이 나오면 인덱스가 사용된 것(빠름)

-- =============================
-- 7. 복합 인덱스(JOB, DEPTNO) 생성 전 성능 확인
-- =============================
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;

explain plan
   for
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
select *
  from table ( dbms_xplan.display );
-- TABLE ACCESS FULL이면 인덱스 미사용

-- =============================
-- 8. 복합 인덱스 생성 (JOB, DEPTNO)
-- =============================
create index emp_index_test_job_deptno_idx on
   emp_index_test (
      job,
      deptno
   );

-- =============================
-- 9. 복합 인덱스 생성 후 성능 확인
-- =============================
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;

explain plan
   for
select *
  from emp_index_test
 where job = 'CLERK'
   and deptno = 10;
select *
  from table ( dbms_xplan.display );
-- INDEX RANGE SCAN이 나오면 복합 인덱스가 사용된 것

-- =============================
-- 10. 인덱스 목록 및 컬럼 정보 확인
-- =============================
select *
  from user_indexes
 where table_name = 'EMP_INDEX_TEST';

select *
  from user_ind_columns
 where table_name = 'EMP_INDEX_TEST';

-- =============================
-- 11. 정리: 인덱스 삭제 (테스트 후 정리)
-- =============================
-- DROP INDEX EMP_INDEX_TEST_ENAME_IDX;
-- DROP INDEX EMP_INDEX_TEST_JOB_DEPTNO_IDX;
-- DROP TABLE EMP_INDEX_TEST;

-- =============================
-- 인덱스 실습 요약
-- =============================
-- 1. 인덱스가 없으면 조건 검색 시 테이블 전체를 탐색(느림)
-- 2. 인덱스를 생성하면 해당 컬럼 검색이 매우 빨라짐
-- 3. 복합 인덱스는 여러 컬럼을 동시에 조건으로 검색할 때 효과적
-- 4. 실행계획(EXPLAIN PLAN)에서 INDEX RANGE SCAN이 나오면 인덱스가 잘 활용된 것
-- 5. 실습 후 인덱스와 테이블을 꼭 정리할 것