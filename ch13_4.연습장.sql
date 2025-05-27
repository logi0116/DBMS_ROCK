-- 규칙에 따라 순번을 생성하는 시퀀스 (sequence) 생성

-- 기본 개념  

-- | 항목 | 설명 |
-- |------|------|
-- | 시퀀스 | 자동으로 순차적인 숫자를 생성하는 오라클 객체 |
-- | NEXTVAL | 다음 번호 생성 |
-- | CURRVAL | 최근 생성된 번호 |
-- | START WITH | 시작 숫자 설정 |
-- | INCREMENT BY | 증가 값 설정 |
-- | CYCLE | MAX 도달 시 초기화 여부 설정 |

-- 시퀀스 생성 
create sequence emp_seq start with 1 increment by 1 maxvalue 9999 nocycle;

-- 테스트 할 빈 테이블 복사 
create table emp_sequence_test
   as
      select *
        from emp
       where 1 = 0;
-- 테이블의 내용만 삭제
truncate table emp_sequence_test;

-- 빈 테이블 조회 
select *
  from emp_sequence_test;
select *
  from emp;
-- 시퀀스 조회 
select emp_seq.nextval
  from dual;
DESC EMP_SEQUENCE_TEST;
-- 시퀀스 이용해서, 데이터 추가 해보기. 
insert into emp_sequence_test values ( emp_seq.nextval, -- empno 기존에는 숫자 형태로 직접 지정 했고, 자동 생성.자 타입
                                       '홍길동',         -- ename 문자열 타입
                                       '강사',         -- job 문자열 타입
                                       7839,           -- mgr, 숫자 타입
                                       sysdate,    -- hiredate, DATE 타입
                                       1000,            -- sal 숫자 타입
                                       500,             -- comm 숫자 타입
                                       10               -- deptno 숫자 타입
                                        );
select *
  from emp_sequence_test;


--롤백하기

rollback; --트랜잭션 취소


-- 기존 시퀀스 삭제 후 다시 생성
drop sequence emp_seq;

drop sequence emp_sequence_test;





--시퀀스 마지막 값 조회
select emp_seq.currval
  from dual;


--시퀀스 수정
alter sequence emp_seq increment by 10; -- 증가값을 10으로 변경

-- START WITH는 이미 생성된 시퀀스에는 사용할 수 없습니다.
-- 시퀀스의 시작값을 변경하려면 시퀀스를 DROP 후 다시 CREATE 해야 합니다.




select *
  from emp_sequence_test;


-- -연습용 테이블 생성 후 작업하기
-- DEPT -> DEPT_SEQ_TEST 테이블 복사 후 작업하기

create table dept_seq_test;

create table dept_seq_test
   as
      select *
        from dept
       where 1 = 1;


drop sequence dept_seq_test;

  --퀴즈 1. 1부터 시작하는 DEPT_SEQ 시퀀스를 생성하시오
--증감 10씩, 맥스 : 999999999, NOCYCLE 옵션 사용 
create sequence dept_seq start with 1 increment by 1 maxvalue 999999999 nocycle;


--시퀀스 확인
SELECT DEPT_SEQ.NEXTVAL FROM DUAL;

select *
  from dept;
desc dept_seq_test;
-- 퀴즈 2. DEPT_SEQ_TEST, 샘플 데이터를 추가해서, 증감값 확인. (자동증가 확인이 목적)


-- 시퀀스 사용 방식: deptno를 자동 생성 (차이점: 자동 증가)
insert into dept_seq_test values ( dept_seq.nextval, -- deptno 자동 생성 (시퀀스 사용)
                                   '임의부',         -- dname
                                   '임의지역'        -- loc
                                    );



select *
  from dept_seq_test;






-- 퀴즈3. 마지막으로 생성된 심퀀스 번호 확인 및 증감 10 -> 100 변경도 해보고, 삭제도 해보기

alter table dept_seq_test modify
   deptno number(5);

alter sequence dept_seq increment by 10;

alter sequence dept_seq increment by 50;

select dept_seq.currval
  from dual;

-- 시퀀스 삭제
  drop sequence dept_seq;

  --시퀀스 확인

  select * from USER_SEQUENCES 

  
--시퀀스 
  