--객체(테이블)을 생성, 변경, 삭제하는 데이터 정의어

--create : 객체(테이블)를 생성하는 명령어
--alter : 객체(테이블)의 구조를 변경하는 명령어
--drop : 객체(테이블)를 삭제하는 명령어
--truncate : 테이블의 데이터를 삭제하는 명령어

--*주의 사항 : 테이블 이름 명명, 각각 언어의 예약어를 사용하면 안됨을 주의하기
--예를 들어 MEMBER는 안 쓰지만, USER는 사용되니 주의.
--문법에 이상이 없음에도 안 되는 건 다른 곳에서 예약어를 쓰고 있기 때문

create table member (
   member_id    number(5) primary key, --PK = NOT NULL + UNIQUE(중복 불가)
   member_name  varchar2(20) not null, --NOT NULL 값이 비어있으면 안됨. 반드시 있어야 함
   member_email varchar2(50) not null
);


select *
  from member;

--샘플 데이터 추가
insert into member (
   member_id,
   member_name,
   member_email
) values ( 1,
           '홍길동',
           'EE@GMAIL.COM' );
insert into member (
   member_id,
   member_name,
   member_email
) values ( 2,
           '이순신',
           'KO@GMAIL.COM' );
insert into member (
   member_id,
   member_name,
   member_email
) values ( 3,
           '강감찬',
           'fjad@gmail.com' );


        --    테이블 구조 변경하기
        --    ALTER TABLE 테이블명
        --기본 문법 
--    ADD member_phone varchar2(20) not null;

alter table member add member_phone varchar2(20); 

   --테이블 이름 변경하기
--ALTER TABLE 테이블명
--RENAME TO 새 테이블명;
alter table member rename to member_info;

select *
  from member_info;

savepoint sp1;

rollback to sp1;

  --테이블의 내용만 삭제하기 > 빈 테이블만 남음.
truncate table member_info;

-- 테이블 삭제하기
drop table member_info;



-- 퀴즈 1 테이블 : board, 컬럼 : board_id(number 5), title(varchar2(30)), 
-- content(varchar2(300)), writer(vachar2(3)), regdate(date)


create table board (
   board_id number(5) primary key, --PK = NOT NULL + UNIQUE(중복 불가)
   title    varchar2(30) not null, --NOT NULL 값이 비어있으면 안됨. 반드시 있어야 함
   content  varchar2(300) not null, -- Increased length to accommodate longer values
   writer   varchar2(10) not null, -- Increased length to accommodate longer values
   regdate  date default sysdate
);

select *
  from board;

--샘플 데이터 추가
insert into board (
   board_id,
   title,
   content,
   writer
) values ( 1,
           '제목1',
           '내용1',
           '홍길' );

insert into board (
   board_id,
   title,
   content,
   writer
) values ( 2,
           '제목2',
           '내용2',
           '이순' );

insert into board (
   board_id,
   title,
   content,
   writer
) values ( 3,
           '제목3',
           '내용3',
           '강감찬' );



-- 퀴즈 2, ALTER ~ MODIFY
-- BOARD 테이블에 특정 컬럼의 타입 변경 변경해보기.
-- (writer varchar2(40)으로 변경)
alter table board modify
   writer varchar2(40); -- This line is already correct and ensures the column length is updated.

--퀴즈3. board 테이블에에서 content 안의 내용을 삭제해 null로 만들기
alter table board modify
   content varchar2(300) null;


update board
   set
   content = null
 where board_id = 1;


select *
  from board;

  테이블 구조 조회하기
desc board;

내용 삭제하기 
