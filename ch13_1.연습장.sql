--데이터 사전목록 조회
select *
  from dict;
--scott 계정 객체 조회
select *
  from user_objects;

--scott 계정 테이블 조회
select *
  from all_tables
 where owner = 'SCOTT';

--system 계정 테이블 조회
select *
  from dba_users;

--user 접두어
select *
  from user_tables;

--all 접두어 사용 view조회
select *
  from all_views
 where owner = 'SCOTT';

--system 계정에서 dva_접두어 사용
select username,
       created
  from dba_users;

--system 계정에서 현재 자신이 소유한 객체 리스트 조회
select object_name,
       object_type
  from user_objects;

--scott 계정에서 모든 테이블의 컬럼 구조를 조회
select table_name,
       column_name,
       data_type,
       data_length
  from user_tab_columns;