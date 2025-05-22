--조인 사용 전 문제점 제시
--카티션 곱, 두 테이블 곱한 것이 나온다는 것

SELECT * FROM DEPT; 4개
SELECT * FROM EMP; 14개

SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D; --56개 4 * 14 만큼. 비정상적인 출력. 불가능한 것까지 포함해 모든 경우의 수를 그냥 제시할 뿐.
-- 가령 king이라는 사원은 DEPTNO10, DNAME 은 ACCOUNTING 인데
-- 그것 외에도 다른 부서도 또 KING에 해당한다며 출력이 됨, 중복이 된다는 것.


-- 문제점 해결해보기 1
-- 테이블 별칭 이용해서, 조인 해보기.
-- 테이블을 합쳐야해서 약칭을 많이 쓸 것.
SELECT E.ENAME, D.DNAME         --E라고 명명된 EMP의 ENAME, D라고 명명된 DEPT의 DNAME. 아래 FROM에서 정했음.
FROM EMP E, DEPT D              --AS처럼 일종의 이름을 정하는 것. 
WHERE E.DEPTNO = D.DEPTNO ;     --SELECT 에 조건을 붙였음. 셀렉트를 하는데 EMP의 DEPTNO 와 DEPT의 DEPTNO가 같을 때 출력하라고.
--왼쪽에 있는 ename은 emp의 것, 오른쪽에 있는 것은 dept의 것. 
--각기 다른 테이블의 요소를 붙였는데 
--조건은 where을 이용해서 EMP와 DEPT의 부서가 같은 경우라고 걸었다.


SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO ;



--EMP와 DEPT 테이블 등가 조인하여 부서번호 30번인 사원만 출력하기

SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 30;


--퀴즈 1. EMP 와 DEPT 테이블을 조인해서 관리자(MANAGER) 직무를 가진 사원의 이름과 
--부서명 출력해보기.
--별칭은 : 사원명, 부서명
SELECT * FROM DEPT;
SELECT * FROM EMP;


--시도 (일단 작동은 함)(제대로 맞췄음 굿굿)
SELECT E.ENAME AS "사원명", D.DNAME AS "부서명", E.JOB AS "직무명"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB = 'MANAGER';


--정답
SELECT E.ENAME AS "사원명", D.DNAME AS "부서명", E.JOB 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB = 'MANAGER';


--퀴즈 2. 각 사원의 이름과 그 사원의 직속 상관의 이름을 함께 출력해보기.
--별칭은 사원명, 직속 상관명
--힌트 : 같은 테이블 (자기 참조?)

--시도
SELECT * FROM DEPT;
SELECT * FROM EMP;

SELECT 
E.EMPNO AS "사원 번호", 
E.ENAME AS "사원명", 
E.MGR AS "EMP직속 상관번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M     --같은 테이블을 E, M 다르게 붙임
WHERE E.MGR = M.EMPNO;    --이렇게 하면 직속상관과 사원번호가 같은 사람이 없다? 


--정답
SELECT 
E.EMPNO AS "사원 번호", 
E.ENAME AS "사원명", 
E.MGR AS "EMP직속 상관번호",
M.ENAME AS "EMP2직속 상관명"
FROM EMP E, EMP M     --같은 테이블을 E, M 다르게 붙임
WHERE E.MGR = M.EMPNO;    --사원의 mgr와 사원의 no가 같으면인데 당연히 같은 행에서는 안 맞지만, 상사는 맞게 된다.
--가령 BLAKE의 사원번호는 7698이며 그의 상사는 7839(E.MGR)이다
--그의 상사인 킹의 사원번호는 M.EMPNO라서 BLAKE의 상사인 7839와 같다. 
--따라서 E.MGR = M.EMPNO 라고 출력하고 그 값들의 목록에서 E.MGR과, M.ENAME 을 대입하면?
--JOIN은 WHERE에 해당하는 것을 같은 경우에 연결하겠다는 것. 따라서 데이터는 
--E 테이블의 7698(E.EMPNO) BLACK(E.ENAME) 7839(E.MGR) KING(M.ENAME)  요렇게 4개의 데이터로 결합이 된다
--요기서 E.MGR은 7839 이고 M,NAME은 KING이 된다. 그래서 
--E.MGR 값에서 일치하는 것은 한 단계 위인 상관의 번호이며
--M.ENAME 값에서 일치하는 것은 한 단계 위인 직원의 이름이 된다.



--GPT 가 정리해준 것
SELECT 
    E.EMPNO AS "사원 번호", 
    E.ENAME AS "사원명", 
    E.MGR AS "EMP 직속 상관번호",
    M.ENAME AS "EMP2 직속 상관명"
FROM EMP E, EMP M     -- 같은 테이블을 E, M 두 개의 별칭으로 설정해 SELF JOIN 수행
WHERE E.MGR = M.EMPNO;    -- 사원의 MGR과 상사의 EMPNO가 같으면 연결됨

-- 예제 설명:
-- 가령 BLAKE의 사원번호는 7698이며 그의 상사는 7839(E.MGR)이다.
-- 그의 상사인 KING의 사원번호는 7839(M.EMPNO)이고, BLAKE의 상사와 동일하다. 

-- 따라서 `E.MGR = M.EMPNO` 조건을 적용하면, 결과 목록에서 다음과 같은 데이터가 결합됨:
-- E 테이블의 7698(E.EMPNO) BLAKE(E.ENAME) 7839(E.MGR) KING(M.ENAME)

-- 여기서 E.MGR 값은 직원이 속한 상관의 번호이며,
-- M.ENAME 값은 해당 직원의 상관 이름이 된다.






추가 연습


--EMP와 DEPT 테이블 등가 조인하여 부서번호 30번인 사원만 출력하기

SELECT E.ENAME, D.DNAME, D.DNAME, E.HIREDATE   --E와 D 순서가 바뀌어도 상관은 없다.
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 30;






----심화 문제점
--등가 조건은 NULL인 조건을 포함하지 않기 때문에 PRESIDENT인 KING은 출력되지 않았다.(상사가 없어서 MGR 값이 NULL이었음)
--이럴 때 사용하는 것이 바로 외부 JOIN이다.

