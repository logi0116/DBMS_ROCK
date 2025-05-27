--중복되지 않는 값 unique 제약 조건

--기본 문법
--테이블 생성시 제약 조건 추가
--create table 테이블명(
--CONSTRAINT : 제약조건명 제약조건종류 (열명),
--EMAIL VARCHAR2(50) constraint email_unique unique,

create table table_unique (
   id    number(5) primary key, -- 기본키 제약조건
   name  varchar2(20) not null, -- NOT NULL 제약조건
   email varchar2(50)
      constraint email_unique unique -- UNIQUE 제약조건
);

select *
  from table_unique;--제약 조건 확인

select *
  from user_constraints
 where table_name = 'TABLE_UNIQUE';


--시퀀스 생성 후 ,샘플 데이터 추가시, 자동 번호 생성 이용해보기.

create sequence table_unique_seq start with 1 increment by 1 maxvalue 999999999 nocycle;


--시퀀스 생성 확인

select *
  from user_sequences
 where sequence_name = 'TABLE_UNIQUE_SEQ';

--샘플 데이터 추가
insert into table_unique (
   id,
   name,
   email
) values ( table_unique_seq.nextval,
           '홍길동',
           'hong@naver.com' );


--추가 방법 1
email varchar(20) 


추가 방법2

