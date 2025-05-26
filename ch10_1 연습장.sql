--테이블에 데이터 추가하기
--기본 문법, 테이블명의 열을 지정하면 열의 순서에는 상관없음.
--INSERT INTO 테이블명 (열1, 열2,.....) VALUES (값1, 값2, ....);

--열 이름 생략, 이 경우 테이블에 정의된 열의 순서대로 작성하기. 
--INSERT INTO 테이블명 VALUES (값1, 값2, ...);

--NULL 삽입, 날짜 입력
--INSERT INTO 테이블명 VALUES (101, NULL, '2025/05/22', SYSDATE)

-- 서브쿼리 삽입
-- INSERT INTO 테이블명 (열1,열2)
-- SELECT 열1, 열2 FROM 다른 테이블 WHERE 조건;

-- 부서 정보를 dept 테이블에 삽입하는 쿼리입니다.
-- deptno: 부서 번호 (예: 70)
-- dname: 부서 이름 (예: '개발부2')
-- loc  : 부서 위치 (예: '서울2')

insert into dept ( deptno, dname, loc) values ( 70,'개발부2','서울2' );




select *
  from dept;

insert into dept (deptno,dname, loc) values ( 80,'개발부3','서울3' );

commit;

-- SYSDATE 삽입

insert into emp ( empno, ename, hiredate ) values ( 1001, '홍길동', SYSDATE );
select *  from dept;



-- 퀴즈 1
-- dept 테이블에 (99, 'AI팀', 'JEJU') 데이터를 추가하시오.
insert into dept ( deptno, dname, loc) values ( 99,'AI팀','JEJU' ); 
SELECT * FROM dept;




-- 퀴즈 2
-- EMP 테이블에 사번 1234, 이름 'LEE', 입사일을 SYSDATE로 추가하시오
insert into emp (empno, ename, hiredate ) values ( 1234, 'LEE', SYSDATE );
select *  from emp;   


-- 퀴즈 3
--  DEPT 에 NULL을 포함한 값 삽입
--테이블에 pk 값 의무적으로 입력하기
--pk : not null 제약조건이 걸려있음. 그런 열

select * from dept;
insert into dept ( deptno, dname, loc) values (88,null,null); 
select * from dept;


--데이터 사전에서 테이블의 제약조건 확인해보기 dept 테이블
select * from user_constraints where table_name = 'DEPT';
--제약 조건 확인하기

--테이블 복사하는 방법
-- 새로운 테이블을 생성하는 기본 문법
-- EMP 테이블에서 부서번호가 30인 사원 데이터를 
--EMP_TEMP_30 테이블에 복사하기


-- EMP_TEMP_30 테이블을 생성. 단순 빈테이블 생성
create table EMP_TEMP_30 AS SELECT * FROM EMP WHERE 1=0;

--실제 데이터 삽입
create table EMP_TEMP_40 AS SELECT * FROM EMP WHERE 1=1;



insert into EMP_TEMP_30
select * from EMP where deptno = 30;
--emp_temp_30테이블 단순 확인
select * from EMP_TEMP_30;
select * from EMP_TEMP_40;






퀴즈: 학생들의 과목별 점수가 저장된 테이블이 있습니다.

STUDENT	KOR	ENG	MATH
홍길동	90	80	70
이순신	85	95	90
위와 같은 테이블(score)에 대해,
각 학생의 점수를 아래와 같이 "세로(행)"로 변환하는 UNPIVOT 쿼리를 작성하세요.

STUDENT	SUBJECT	SCORE
홍길동	KOR	90
홍길동	ENG	80
홍길동	MATH	70
이순신	KOR	85
이순신	ENG	95
이순신	MATH	90


--UNPIVOT 쿼리

select * from score
UNPIVOT (
    점수 FOR 과목 IN (KOR, ENG, MATH)
);


-- score 테이블 생성
CREATE TABLE score (
    student VARCHAR2(20),
    KOR NUMBER,
    ENG NUMBER,
    MATH NUMBER
);

-- 데이터 입력
INSERT INTO score VALUES ('홍길동', 90, 80, 70);
INSERT INTO score VALUES ('이순신', 85, 95, 90);

select * from score
UNPIVOT (
    점수 FOR 과목 IN (KOR, ENG, MATH)
);