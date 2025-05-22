--SELECT 절에 사용하는 서브쿼리

--기본문법
--사원 이름, 급여
--그리고 해당 사원이 속한 부서의 평균 급여를 같이 출력

select ename,
       sal,
       (
          select avg(sal)
            from emp
           where deptno = e.deptno
       ) as "평균급여"
  from emp e;

--각 사원 옆에 부서 평균 표시
select ename,
       deptno,
       sal,
       (
          select avg(sal)
            from emp
           where deptno = e.deptno
       ) as "평균 급여"
  from emp e;


--사원명 옆에 전체 사원 수 표시

select ename,
       (
          select count(*)
            from emp
       ) as "총 사원수"
  from emp;


--사원명 옆에 관리자의 이름 표시 (자체 서브쿼리)
select e.ename,
       (
          select m.ename
            from emp m
           where m.empno = e.mgr
       ) as "직속상관 이름"
  from emp e;


--위의 쿼리들은 반복 실행되는 문제가 있음.
--그래서 차선책으로서 성능을 고려한 쿼리 작업해보기. 
--계획은 이렇다. 부서별 평균 급여를 미리 구한 후, 
-- EMP 테이블과 조인해서 출력
-- 메인 쿼리 실행 때마다 서브쿼리가 매번 실행 안되서 좋음.


select e.ename,
       e.sal,
       d.dept_avg
  from emp e
  join (
   select deptno,
          avg(sal) as dept_avg
     from emp
    group by deptno
) d
on e.deptno = d.deptno;






-- 지금은 성능 고려하지 말고, 서브 쿼리 연습으로 접근하기
-- 퀴즈1, 
-- 각 사원의 급여, 부서 평균 급여, 전체 평균 급여를 함께 출력하시오.

--내 시도
select ename,
       sal,
       (
          select avg(sal)
            from emp
           where deptno = e.deptno
       ) as "부서 평균급여",
       (
          select avg(sal)
            from emp
       ) as "전체 평균 급여"
  from emp e;



--정답
select ename,
       sal,
       deptno,
       (
          select avg(sal)
            from emp
           where deptno = e.deptno
       ) as "부서평균",
       (
          select avg(sal)
            from emp
       ) as "전체 평균"
  from emp e;


 
-- 퀴즈2, 
-- 각 사원의 이름, 직책, 부서 위치를 함께 출력하시오.  
--내시도
select e.ename,
  e.job,
  d.loc
  from emp e
  join dept d
    on d.deptno = e.deptno;


select e.ename,
       e.job,
       (
          select d.loc
            from dept d
           where d.deptno = e.deptno
       ) as location
  from emp e;
   
  
  
  
-- 퀴즈3, 
-- 각 사원의 이름, 급여, 같은 부서의 최대 급여를 함께 출력하시오.  

select ename,
       sal,
       deptno,
       (
          select max(sal)
            from emp
           where deptno = e.deptno
       ) as "최대급여"
  from emp e;