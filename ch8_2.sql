--기존 JOIN의 심화 문제점 (ch8에서 사용했던)
--등가 조건은 NULL인 조건을 포함하지 않기 때문에 PRESIDENT인 KING은 출력되지 않았다.(상사가 없어서 MGR 값이 NULL이었음)
--이럴 때 사용하는 것이 바로 외부 JOIN이다.


--비등가 조인
SELECT E.ENAME, E.SAL, G.GRADE
FROM EMP E, SALGRADE G
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;


SELECT E.ENAME, E.SAL, G.GRADE, G.LOSAL, G.HISAL  
FROM EMP E, SALGRADE G   
WHERE E.SAL BETWEEN G.LOSAL AND G.HISAL;   --SAL의 최저SAL과 최고SAL 사이로 범위 설정, 
--완전히 일치하지 않더라도 설정된 범위 안에 들어가기만 하면 됨



--외부 조인
--오른쪽 외부 조인, 왼쪽을 기준으로 해서 왼쪽에 값이 없어도 표기하겠다
--말인즉슨 값이 NULL이어도 표기하겠다. 라는 말.
--요 문법은 오라클 전용이기 때문에 가볍게 보기.

SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);    --오른쪽 기준

--왼쪽에 있는 건 ENAME 오른쪽은 DNAME인데




--먼저 자체조인
SELECT 
    E.EMPNO AS "사원 번호", 
    E.ENAME AS "사원명", 
    E.MGR AS "EMP 직속 상관번호",
    M.ENAME AS "EMP2 직속 상관명"
FROM EMP E, EMP M     
WHERE E.MGR = M.EMPNO;

--외부조인 활용 자체조인을 외부 조인 버전으로 변경해서 누락 없이 왼쪽 컬럼을 기준으로 표시하기
--왼쪽 외부 조인 
SELECT 
    E.EMPNO AS "사원 번호", 
    E.ENAME AS "사원명", 
    E.MGR AS "EMP 직속 상관번호",
    M.ENAME AS "EMP2 직속 상관명"
FROM EMP E, EMP M     
WHERE E.MGR = M.EMPNO(+);


--오른쪽 외부 조인 
--오른쪽 컬럼을 기준으로 표시하기
SELECT 
    E.EMPNO AS "사원 번호", 
    E.ENAME AS "사원명", 
    E.MGR AS "EMP 직속 상관번호",
    M.ENAME AS "EMP2 직속 상관명"
FROM EMP E, EMP M     
WHERE E.MGR(+) = M.EMPNO;


--어느쪽을 기준으로 하느냐에 따라서 달라지겠지만, 왼쪽을 기준으로 하는 게 일반적인 느낌인 듯.
--KING을 기준으로 하려면 그 이름이 왼쪽에 있었으니 오른쪽에 (+) 배치함





--퀴즈 1 .EMP와 DEPT 테이블에서 부서가 없는 사원도 포함해서
--사원명과 부서명을 출력하시오 (왼쪽 외부 조인)

SELECT * FROM DEPT;
SELECT * FROM EMP;

--외부 조인에서 오른쪽 왼쪽 조인을 헷갈려했음. 왼쪽 조인은 왼쪽 테이블을 기준으로 정렬하라는 뜻
--오른쪽 조인은 오른쪽 테이블을 기준으로 정렬하라는 뜻.
SELECT 
    E.EMPNO AS "사원번호",
    E.ENAME AS "사원명", 
    D.DNAME AS "부서명"
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

--정답
SELECT 
    E.ENAME AS "사원명", 
    D.DNAME AS "부서명"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);   --왼쪽 외부조인이라는 게 오른쪽에 두라는 거였음



--퀴즈 2. 오른쪽 외부조인을 사용해서 부서가 있지만,
--사원이 없는 부서를 포함해서 출력하시오.


SELECT 
    E.ENAME AS "사원명", 
    D.DNAME AS "부서명"
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

--퀴즈 3
--WHERE 절에 추가 조건 ('JOB = 'CLERK'')을 넣고 부서별 사원 출력


--시도 1 AND를 넣었어야 했다.
SELECT 
     E.ENAME AS "사원명",
     D.DNAME AS "부서"
FROM EMP E, DEPT D
WHERE E.JOB = 'CLERK';

SELECT 
     E.ENAME AS "사원명",
     E.JOB,
     D.DNAME AS "부서"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK'
