-실행 결과가 여러 개인 다중행 서브쿼리

--기본 문법 
--IN : 복수의 값 중에서 하나와 일치하는 경우를 조회할 때 사용
--DALLAS 에 위치한 부서의 부서번호 중
--하나에 속한 사원의 이름을 출력 예시

SELECT ENAME FROM EMP
WHERE DEPTNO IN (
SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS'
);


--ANY 
--부서 번호가 30번에 속한 사원들 중 적어도 한 명보다
--급여가 적은 사원의 이름을 출력 예시
--  >, 또는 <와 같이 비교 연산자와 함께 사용되고
-- 최소/최대 비교를 하는 경우도 유연하게 사용된다.


DESC EMP;
DESC DEPT;

SELECT ENAME FROM EMP
WHERE SAL < ANY (                          
    SELECT SAL FROM EMP WHERE DEPTNO =30   --30번 부서의 목록들 중에서 
);

--부서 30번의 급여 중 하나라도 큰 값이 있다면 해당 사원보다 적은 급여를 가진 사원을 모두 출력.하라는 뜻
--결론은 30번 부서의 최대값보다 작은 수를 출력. 

--그래서 MAX(SAL)로 해도 같은 조건
SELECT ENAME FROM EMP
WHERE SAL < ANY (                          
    SELECT MAX(SAL) FROM EMP WHERE DEPTNO =30 
);



--ALL 연산자
-- 부서 번호 30번의 모든 사원보다 급여가 많은 사원의 이름 출력
-- 이름 출력
-- ALL은 전부 만족해야 참이 되는 조건,
-- 사실상 가장 큰 값보다 더 커야함.
-- MAX( ) 보다 강하게 사용하는 조건.(max랑 비슷하게 쓰임)
SELECT ENAME FROM EMP
WHERE SAL > ALL (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);


-- 동일한 결과
SELECT ENAME FROM EMP
WHERE SAL > (
    SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30
);



--EXISTS 연산자
--사원이 소속하는 부서의 이름을 출력
--하나라도 존재하면 참(true) 
--내용을 확인하지 않기에 매우 빠른 조건에 존재 확인에 유리
--데이터 확인보다는 존재 유무만 체크
--서브쿼리의 실제 데이터가 아니라 존재 유무만 확인 함.

SELECT DNAME FROM DEPT D
WHERE EXISTS (
    SELECT * FROM EMP E
    WHERE E.DEPTNO = D.DEPTNO
);

        
--30번 부서 사원들과 동일한 급여를 받는 사원

SELECT ENAME, SAL FROM EMP
WHERE SAL IN (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
);


--30번 부서 중 가장 높은 급여보다 작게 급여를 맞는 직원
SELECT ENAME, SAL FROM EMP
WHERE SAL < ALL (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
    );
    
    
    --부서별 최대 급여 출력
    SELECT DEPTNO, MAX(SAL) FROM EMP
    GROUP BY DEPTNO ;
    
    
    
    
    퀴즈 1. 30번 부서의 최소 급여보다 많은 급여를 받는 사원 출력
    
SELECT ENAME FROM EMP
WHERE SAL > ANY (                          
    SELECT SAL FROM EMP WHERE DEPTNO =30   
);
    
    
    --정답
    
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
    SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30
    );
    --EMP 테이블에서 사원의 이름과 급여를 구해라
    --30번 부서에 있는 모든 사원들과 비교를 하고, 
    --모두가 많이 받는 건 참이되어야 한다.

        

    
    
    
    퀴즈 2. 30번 부서의 최대 급여보다 많은 급여를 받는 사원 출력
    
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
    SELECT SAL FROM EMP WHERE DEPTNO = 30
    );
    
    --정답
SELECT ENAME, SAL FROM EMP
WHERE SAL > ALL (
    SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30
    );
        
    
    
    퀴즈 3. EMP 테이블에 소속된 사원이 있는 부서의 이름을 출력 (`EXISTS`) 
       
    
    SELECT DNAME FROM DEPT D  ----순서1. DEPT 의 DNAME을 조회하라. 5섯개의 부서명 중 1개만 이용
WHERE EXISTS (     --순서2, ACCOUNTING한개의 데이터에서
    SELECT * FROM EMP E    (       --순서3, 각각의 EMP, DEPT 조인한 테이블
    WHERE E.DEPTNO = D.DEPTNO    --순서4, 조인한ㅌ 테이블의 
     --순서 5.  .ACOOUNTING 데이터 하나에,
     --    서비쿼리 16개 데탸탙 비교
    -- 결론, 총 몇번을 비교하나요? 16*5인 80번 비교. 지금은 데이터가 적어도 다 비교해도 ㄱㅊ지만 나중엔 감당 못함.
    --성능상 버스쿼리의 빈번한 사용한 좋은 선택은 아니다.
    --해결책은 최대한 인덱스 많이 쓰고, 조인을 사용하기.
    --쿼리 조회시, 외주, GPT 작업하면
    -- 반드시 해당 쿼리의 성능 체크도 같이하기.!!
);



SELECT * FROM DEPT;
SELECT * FROM EMP;



    