desc emp;
desc dept;
desc salgrade;

--  *, 모든 컬럼 조회
select * from emp;
select * from dept;
select ename, mgr, job from emp;

-- distinct 중복제거, 단일 컬럼
select distinct deptno from emp;

-- distinct 중복제거, 여러 컬럼, 1세트(deptno, job)
select distinct deptno, job from emp; --9명
select deptno, job from emp; --14명

-- ALIAS, 별칭을 지정해서 컬럼 이름을 원하는 걸로 지정
select ename as "사원 이름" from emp;


--상여금 있으면 출력 가능하나 없으면 계산이 안 됨

select ename as "사원 이름", sal*12+comm as 연봉, comm from emp; 
select ename as "사원 이름", sal*12+comm as 연봉, comm from emp; 

--NVL(COMM,0) 이용해서 상여금 부분 NULL 없애기
select ename as "사원 이름", sal*12 + nvl(comm,0) as 연봉,  nvl(comm,0) as "상여금 여부"from emp; 
select ename as "사원 이름", sal*12 + nvl(comm,0) as "총 급여" from emp; 




--퀴즈1
--별칭 부여해서 사원 이름 출력
select ename as "직원 이름" from emp;

--퀴즈2
--급여를 연봉으로 계산해 출력해보기
select sal*12 as "연봉" from emp;

--퀴즈3
--사원명과 직무를 각각 '사원이름', '직무'로 출력해보기
select ename as "직원 이름", job as 직무 from emp;

--퀴즈4
--사원명과 급여, 그리고 커미션(COMM)이 있을 경우
--총 수입을 계산하기
--출력 별칭은 '총 급여'로 지정해서 출력
--특정 옵션 함수

select ename as "사원명", sal as "기본급", 
sal * 12 + NVL(COMM,0) as "총 급여" from emp;

--order by 컬럼명 desc(asc 기본)
select ename as "사원명", sal as "기본급", 
sal * 12 + NVL(COMM,0) as "총 급여" from emp order by sal asc;


--복합 컬럼 이용
select * from emp 
ORDER BY DEPTNO ASC, SAL DESC;

--열의 인덱스로 정렬하기
-- 1)ename, 2)job, 3)sal
select ename, job, sal from emp 
order by 3 desc;



--시간은, 최신일 값으로 하면 큰 값
--과거 일수로 값으로 하면 작은 값

--실수한 방식 select hiredate from emp order by asc;

select * from emp order by hiredate desc;   --최신부터 (높은 수부터) 내림차순
select * from emp order by hiredate asc;   --과거부터 (낮은 수부터) 오름차순





--퀴즈 1  커미션이 높은 순으로 급여가 낮은 순으로 정렬을 해보기
--특정 컬럼 언급 없으면 모든 컬럼 출력
select * from emp ORDER BY COMM DESC, SAL ASC;

--퀴즈2, enmp 테이블에서 이름, 부서번호, 급여를 출력하되 급여가 높은 순으로 정렬해보기 한번더
select ename, deptno, sal from emp order by 3 desc;


--퀴즈 3, salgrade라는 테이블에서 급여 등급(grade)을 오름차순,
--최고급여 (hisal)은 내림차순으로 정렬하기.

select * from salgrade ORDER BY GRADE ASC, HISAL DESC;






