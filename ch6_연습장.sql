
--모두 대문자
SELECT ENAME, UPPER(ENAME) AS "사원명 대문자" FROM EMP;
--모두 소문자
SELECT ENAME, LOWER(ENAME) AS "사원명 소문자" FROM EMP;
--첫글자만 대문자
SELECT ENAME, INITCAP(ENAME) AS "사원명 첫글자 대문자" FROM EMP;


SELECT 
ENAME, 
UPPER(ENAME) AS "사원명 대문자",
LOWER(ENAME) AS "사원명 소문자",
INITCAP(ENAME) AS "사원명 첫글자 대문자", --요기 쉼표가 문제
FROM EMP;

SELECT 
    ENAME, 
    UPPER(ENAME) AS "사원명 대문자",
    LOWER(ENAME) AS "사원명 소문자",
    INITCAP(ENAME) AS "사원명 첫글자 대문자"  
FROM EMP;

--사원 이름의 길이 출력
SELECT ENAME,
LENGTH(ENAME) AS "사원명 글자 길이",
LENGTHB(ENAME) AS "사원명 바이트 길이"
FROM EMP;



--직무 문자열 안에 'A'가 포함된 위치
--INSTR = in STRING 문자열 안에 있는. (컬럼명 (문자열), 찾을문자, 시작위치, 몇번째)
SELECT JOB, 
INSTR(JOB, 'A') AS "A가 몇번째 위치" 
FROM EMP;

SELECT INSTR('MANAGER', 'A', 1, 2) AS 위치 FROM EMP;


--여러개를 찾고 싶을 경우
SELECT JOB, 
       REGEXP_INSTR(JOB, 'A', 1, 1) AS "첫 번째 A 위치",
       REGEXP_INSTR(JOB, 'A', 1, 2) AS "두 번째 A 위치",
       REGEXP_INSTR(JOB, 'A', 1, 3) AS "세 번째 A 위치"
FROM EMP;


--
SELECT JOB, 
INSTR(JOB, 'A') AS "A가 몇번째 위치",
SUBSTR(JOB, 1,3) AS "3글자 읽기",
SUBSTR(JOB, 2,5) AS "2번째부터 시작해서 4글자 읽기"   --글자가 너무 길어서 작동 안 했음
FROM EMP;
    
    
    
    --SUBSTR (컬럼명(문자열), 시작위치 1부터 시작, 길이)
    
    SELECT JOB, 
       INSTR(JOB, 'A') AS "A가 몇번째 위치",
       SUBSTR(JOB, 1,3) AS "3글자 읽기",
       SUBSTR(JOB, 2,4) AS "4글자 읽기"
FROM EMP;



--REPLACE (컬럼명(문자열), 바꿀 대상, 바꿀 내용)

SELECT JOB, 
       INSTR(JOB, 'A') AS "A가 몇번째 위치",  --문자열 위치 찾기
       SUBSTR(JOB, 1,3) AS "3글자 읽기",   --문자열 일부 추출
       REPLACE(JOB, 'CLERK', '직원') AS "한글 직무"  --문자열 바꾸기
FROM EMP;


SELECT JOB, 
       INSTR(JOB, 'A') AS "A가 몇번째 위치",  --문자열 위치 찾기
       SUBSTR(JOB, 1,3) AS "3글자 읽기",   --문자열 일부 추출
       REPLACE(JOB, 'CLERK', '직원') AS "한글 직무",
       REPLACE(JOB, 'MANAGER', '매니저') AS "한글 직무"--문자열 바꾸기
       REPLACE(JOB, 'SALESMAN', '영업사원') AS "한글 직무"--문자열 바꾸기
FROM EMP;





--LPAD, RPAD : 포맷 맞추기
--LPAD(컬럼명, 총길이, '채워질 문자')
SELECT ENAME, LPAD(ENAME, 9, '*') AS "5글자포맷마스킹처리" FROM EMP; --9글자로 맞추고, 존재할(채워질) 여백은 *로 하기.
SELECT ENAME, LPAD(ENAME, 3, '*') AS "5글자포맷마스킹처리" FROM EMP; --3글자로 맞추고, 존재할(채워질) 여백은 *로 하기.


SELECT ENAME, RPAD(ENAME, 3, '*') AS "5글자포맷마스킹처리" FROM EMP; --3글자로 맞추고, 존재할(채워질) 여백은 *로 하기.
SELECT ENAME, RPAD(ENAME, 9, '*') AS "5글자포맷마스킹처리" FROM EMP; --9글자로 맞추고, 존재할(채워질) 여백은 *로 하기.




--//TRIM 문자열 양쪽 문자 제거
--TRIM (LEADING | TRAILING | BOTH '제거문자' FROM 문자열)
--LEADING : 앞에서 제거
--TRAILING : 뒤에서 제거
--BOTH : 양쪽 제거 (생략 시 기본값으로 적용)
--목적, 공백 또는 지정 문자 제거

--DUAL : 더미 테이블, 없는 테이블, 주로 간단한 함수 테스트가 목적
SELECT TRIM('   ORACLE             ') AS "양쪽 공백 제거" FROM DUAL;
SELECT TRIM('   ORACLE   ') AS "양쪽 공백 제거" FROM DUAL;

SELECT LTRIM ('   ORACLE   ') AS "왼쪽 공백 제거" FROM DUAL;
SELECT RTRIM ('   ORACLE   ') AS "왼쪽 공백 제거" FROM DUAL;

SELECT TRIM('   ORACLE   ') AS "왼쪽 공백 제거", 
TRIM('   ORACLE   ') AS "왼쪽 공백 제거", 
TRIM('   ORACLE   ') AS "왼쪽 공백 제거" 
FROM DUAL;

--

SELECT 
TRIM(BOTH '#' FROM '###HELLO###') AS "BOTH 결과",
TRIM('#' FROM '###HELLO###') AS "BOTH 생략 결과",
TRIM(LEADING '#' FROM '###HELLO###') AS "리딩 결과",
TRIM(TRAILING '#' FROM '###HELLO###') AS "트레일링 결과" 
FROM DUAL;


--문자열 연결 해보기
--CONCAT(컬러명1(문자열1),컬러명2(문자열2))
--2 문자열을 연결(합치는) 함수

SELECT
CONCAT (ENAME, JOB) AS "이름+직무" FROM EMP;

--연결할 문자열 3개 이상일 때는 '||' 버티컬 바 2개를 붙여야 함
SELECT ENAME || ' ' || JOB AS "이름+직무" FROM EMP;





--퀴즈 1 주민번호에서 생년월일만 추출해보기 SUBSTR
--별칭 생년월일로 출력. 프롬 듀얼 이용

SELECT SUBSTR('999999-2222222',1,6) AS "생년월일" FROM DUAL; --내 시도

SELECT SUBSTR('코드-481DJ$@',4) AS "식별자추출" FROM DUAL; --내 시도
SELECT SUBSTR('code-dk5J',6) AS "식별자추출" FROM DUAL; --내 시도



--퀴즈 2 이메일에서 @ 위치 찾기 INSTR 활용.
--별칭 골뱅이 위치로 출력 해보기 프롬 듀얼 활용
SELECT INSTR('dododo@gmail.com','@') AS "골뱅이 위치" FROM DUAL; --7번째
SELECT INSTR('do3123dodo@gmail.com','@') AS "골뱅이 위치" FROM DUAL; --11번째

--퀴즈 3 전화번호에서 -제거해보기, 010-7661-3709 별칭 정리된 번호로 프롬 듀얼 활용
--시도 1 SELECT TRIM('-' FROM '010-7661-3709') AS "정리된 번호" FROM DUAL;
--시도 2 
--SELECT REPLACE ('010-7661-3709','-','') AS "정리된 번호 FROM DUAL;

--시도 3 
--SELECT REPLACE ('010-7661-3709','-','') AS "정리된 번호 FROM DUAL;

SELECT REPLACE ('010-7661-3709','-','') AS "정리된 번호" FROM DUAL;

SELECT REPLACE ('010-4004-5555','5','3') AS "수정된 번호" FROM DUAL;

SELECT REPLACE ('아다르고어다르다','다','응') AS "수정된 글" FROM DUAL;



--퀴즈 4 부서번호를 왼쪽으로 공백 채우기, 별칭은 정렬용으로 출력. FROM EMP 이용
SELECT LPAD(DEPTNO, 10,' ') AS "정렬용" FROM EMP;
SELECT LPAD(DEPTNO, 10,'*') AS "정렬용" FROM EMP;
SELECT LPAD(DEPTNO, 2) AS "정렬용" FROM EMP;

SELECT ENAME,LPAD(DEPTNO, 10,' ') AS "정렬용" FROM EMP;
SELECT ENAME,LPAD(DEPTNO, 10,'code') AS "정렬용" FROM EMP;




SELECT JOB REPLACE(JOB, 'CLERK', '직원') AS "한글 직무",
       REPLACE(JOB, 'MANAGER', '매니저') AS "한글 직무"--문자열 바꾸기
       REPLACE(JOB, 'SALESMAN', '영업사원') AS "한글 직무"--문자열 바꾸기
FROM EMP;


----퀴즈5, TRIM .
--앞뒤 공백 제거해보기. 예제 문자열 : '공백공백공백(본인이름)공백공백공백'
---별칭 정리된 문자 출력해보기.
--프롬 듀얼 활용

시도 1(실패)
SELECT TRIM'   이상록   ' AS "정리된 문자" FROM DUAL; --괄호를 안 썼다. TRIM 안에 인자를 설정해주기 위해 괄호가 필수
성공. 
SELECT TRIM('   이상록   ') AS "정리된 문자" FROM DUAL;

--퀴즈 6. CONCAT

SELECT CONCAT (ENAME,DEPTNO) AS "사원명+부서번호" FROM EMP;
SELECT ENAME|| ' ' || DEPTNO AS "사원명+부서번호" FROM EMP;
SELECT ENAME || '-' || TO_CHAR(DEPTNO) AS "사원명+부서번호" FROM EMP;






SELECT ENAME || ' ' || JOB AS "이름+직무" FROM EMP;





---숫자 관련 함수 기본
--급여의 소수점 둘째 자리에서 반올림 (값, 반올림이 행해지는 곳이 아닌 향할 자리)
SELECT ENAME, ROUND (SAL, 1) AS "ROUND (SAL, 1)" FROM EMP;

SELECT ROUND(3567.48, 1) AS "반올림된 값" FROM DUAL;
SELECT ROUND(3567.43, 1) AS "반올림된 값" FROM DUAL;

SELECT TRUNC (123.456, 0) AS "TRUNC (123.456, 0)" FROM DUAL;

--사원번호를 2로 나눈 나머지 출력
SELECT ENAME, EMPNO, MOD(EMPNO,2) AS "2로 나눈 나머지" FROM EMP;


--CEIL, FLOOR 비교
SELECT ENAME, EMPNO, CEIL (SAL/3), FLOOR(SAL /3) 
FROM EMP;



--퀴즈 1. 소수점 둘째 자리까지 반올림 해보기.
SELECT ROUND(123.4567, 2) AS "반올림된 값" FROM DUAL;

--퀴즈 2. 소수점 첫째 자리에서 내림 해보기.
SELECT TRUNC (123.4567, 1) AS "내림된 값" FROM DUAL;

--퀴즈 3. CEIL, FLOOR 비교 해보기, 
--임의 숫자 : 1.5, -1.5
--FROM 듀얼
--CEIL은 큰 수를 기준으로 
--이득인 쪽으로 반올림 또는 내림. +를 향해
--FLOOR은 작은 수를 기준으로 
==손해인 쪽으로 반올림 또는 내림
SELECT CEIL (1.5) AS "CEIL" ,
FLOOR(1.5) AS "FLOOR",
CEIL (-1.5), 
FLOOR(-1.5)
FROM DUAL;

SELECT CEIL (4.5/3), FLOOR(4.5 /3) FROM DUAL;
SELECT CEIL (-4.5/3), FLOOR(-4.5 /3) FROM DUAL;


--퀴즈 4 MOD 사원 번호를 4로 나눈 나머지 출력 
--별칭 : 4로 나눈 나머지
--FROM EMP
--✅ MOD(숫자1, 숫자2) → 숫자1을 숫자2로 나눈 나머지 값을 반환하는 함수! 
--✅ 주로 홀수/짝수 판별, 특정 값 그룹화 등에 활용됨


SELECT ENAME AS "사원명", EMPNO AS "사원번호", MOD(EMPNO,4) AS "4로 나눈 나머지" FROM EMP;



----어제자 2025020, 어제자 복습 
dis, all 복습
select DISTINCT JOB AS "직종" FROM EMP;
select ALL JOB AS "직종" FROM EMP;
select DISTINCT JOB "직종" FROM EMP;
select ALL JOB "직종" FROM EMP;

--복합
select job AS "직종", deptno AS "부서 번호" FROM EMP;

--문자열 관련 내장 함수

//1)이름 첫글자를 F를 기준으로 사전식 정렬
SELECT * FROM EMP WHERE ENAME < 'F'; F 보다 작은 CBA만 뜸
SELECT * FROM EMP WHERE ENAME < 'A'; 안 뜸 

//2)부정 연산자 : !=. <>, ^= 
SELECT * FROM EMP WHERE SAL != 3000; --직원 중 3000급여가 아닌 사람을 열거하라

//3)OR 연산자를 조금 더 간결하게 IN 연산자
SELECT * FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK'); --OR을 이용해서 쓰려면 길어짐. 아래 것은 길게 표현한 것.
--한마디로 아름다운 새, 나비, 자연, 이러면 되는데 아름다운 새, 아름다운 나비, 아름다운 자연 이러는 거.

SELECT * FROM EMP
WHERE JOB = 'MANAGER' 
OR JOB = 'SALESMAN' 
OR JOB = 'CLERK';


--4)A이상 B 이하를 나타내는 BETWEEN A AND B. 다음 두가지로 표현할 수 있다.
SELECT * FROM EMP WHERE SAL >= 2000 AND SAL <= 3000;

SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;


--5) % 모든 문자 : 한글자, 
--S로 시작하는 모든 문자열 검색 (대소문자 준수해야 함)

--첫글자 S
SELECT * FROM EMP WHERE ENAME LIKE 'S%';

--2번째 글자 L을 포함하는 이름
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

--3번째 글자 L
SELECT * FROM EMP WHERE ENAME LIKE '__L%';


--이름에 AM를 포함하는 사원 
SELECT * FROM EMP WHERE ENAME LIKE '%am%'; --소문자라 검색 안 됨
SELECT * FROM EMP WHERE ENAME LIKE '%AM%'; --대문자라 대문자 이름 검색 됨


--검색을 할 때 %am%을 했다
--현재 emp 데이터 테이블의 내용은 모두 대문자
--만약, 나중에 데이터 대, 소문자가 섞여 있는 상황이고
--사용자가 검색을 단순 소문자만 했을 경우,
--검색의 결과는 대소문자 상관없이 결과에 나오게 하기.
--방법은 엄청 많음.


--방법론 1. 이름에 대해 다 소문자로 바꾸고 소문자로도 검색되게
--정확히 일치하는 것만 검색

SELECT ENAME FROM EMP
WHERE LOWER(ENAME) = LOWER('scott');

--방법론 2 am을 대문자로 바꾼 다음에 검색하기
--am을 포함하는 키워드를 찾기.
SELECT ENAME FROM EMP
WHERE ENAME LIKE UPPER('%am%');

--방법론 3. 만약에 대소문자가 섞여 있을 경우?
--기존 데이터를 모두 소문자로 변경 후
--am 포함하는 키워드 찾기
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) LIKE LOWER('%am%');

--동일
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) LIKE LOWER('%Am%');
--동일
SELECT ENAME FROM EMP
WHERE LOWER(ENAME) LIKE LOWER('%aM%');

--OR을 이용해서
SELECT * FROM EMP 
WHERE LOWER(ENAME) LIKE '%am%' 
OR UPPER(ENAME) LIKE '%AM%';

SELECT * FROM EMP 
WHERE LOWER(ENAME) LIKE '%am%' 
OR UPPER(ENAME) LIKE '%AM%';


--GPT가 제시한 내용 - 첫번째는 ename만
--두번째는 모두 
SELECT LOWER(ENAME) AS "소문자 이름" 
FROM EMP 
WHERE LOWER(ENAME) LIKE '%am%';

SELECT * FROM EMP 
WHERE LOWER(ENAME) LIKE '%am%';

--SELECT LOWER(ENAME) AS "소문자 이름" FROM EMP WHERE ENAME = UPPER;









SELECT * FROM LOWER(EMP) WHERE ENAME LIKE '%am%';
--2. 문자열 관련 내장 함수

1)대문자로 바꾸기

SELECT ENAME , UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;


--글자 길이 비교, 바이트로 비교
--DUAL 더미테이블, 테스트 용도
--영문자는 한글자가 1바이트, 한글은 한글자가 2~3바이트 차지

SELECT LENGTH('이상용'), LENGTHB('이상용'), 
LENGTH('ABC'), LENGTHB('ABC') FROM DUAL;

--SUBSTR, 문자열에서 특정 구간을 자르기 할 때 사용
--SUBSTR(선택 컬럼(문자열), 시작위치(1부터 시작), 길이만큼 추출)
--길이만큼 추출 인자 부분 비우면 끝까지
--SUBSTR('HELLO',1,3) -> HEL

--연습 1
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 6) FROM EMP;

--연습2 조금 어렵게
---LENGTH(JOB)로 인해 시작 위치가 -가 된다는 것은
--PRESIDENT 라는 경우 
--123456789 인데 이건 정방향 표현
--    P R E S I D E N T
--   -9-8-7-6-5-4-3-2-1  요렇게 표현이 돼서  

--예시1)작동 안 됐음 수정
SELECT JOB, 
       SUBSTR(JOB, LENGTH(JOB), 2), 
       SUBSTR(JOB, LENGTH(JOB), 3, 3)
     FROM EMP;
     
     예시1-1)수정함. 뭐가 다른지 알기
     SELECT JOB, 
       SUBSTR(JOB, LENGTH(JOB), 2) AS "끝에서 2글자",
       SUBSTR(JOB, -LENGTH(JOB)+2, 3) AS "끝에서 3글자"
FROM EMP;

--두번째 인자는 숫자가 들어가야했음. 그래서 작동하고 안 하고가 결정된.


SELECT JOB, 
       SUBSTR(JOB, LENGTH(JOB) +1, 2) AS "22",
       SUBSTR(JOB, LENGTH(JOB) +1, 3) AS "처음에서 3글자"
FROM EMP;

--LENGTHB는 작동할 수도 있지만, 한글은 2~3배수가 곱해져서 안될 듯

--예시2)
SELECT SUBSTR('HELLO', -5) FROM DUAL;
SELECT SUBSTR('HELLO', -5, 2) FROM DUAL;


--INSTR, 문자의 특정 위치 추출해보기
--INSTR(컬럼명(문자열), 찾기 위한 문자, 시작 위치, 몇번째 위치)
--몇번째 위치라는 인자의 뜻은 해당 번째의 '찾기 위한 문자'라는 의미임.

SELECT INSTR ('HELLO HI LOTTO', 'L') FROM DUAL;
SELECT INSTR ('HELLO HI LOTTO', 'L', 5) FROM DUAL; --앞에 hello 건너뛰고부터라서 HELLO_HI_L < 10번째임
SELECT INSTR ('HELLO HI LOTTO', 'L', 2,2) FROM DUAL;
SELECT INSTR ('HELLO HI LOTTO', 'O', 2,2) FROM DUAL; --E가 두번째에서 두번째 O라는 뜻. 2번에서 시작해서 2번째의 O를 찾아라


--REPLACE (컬럼명(문자열),찾을 문자열, 변경할 문자열)
SELECT '010-8666-6312' AS "변경전 문자열",
REPLACE ('010-8666-6312', '-') AS "-,공백으로 문자열",
REPLACE ('010-8666-6312', '-') AS "옵션무면 걍공백"
FROM DUAL;

SELECT '010-8666-6312' AS "변경전 문자열",
REPLACE ('010-8666-6312', '-','*') AS "*로 대체",
REPLACE ('010-8666-6312', '-') AS "옵션무면 걍공백"
FROM DUAL;

--LAPD(컬럼명(문자열), 문자 총 길이, 여백 채울 문자) 왼쪽으로 특정 문자 채우기하는 내장 함수 
--RAPD(컬럼명(문자열), 문자 총 길이, 여백 채울 문자) 오른쪽으로 특정 문자 채우기
--TRIM, 양쪽 공백 제거하기

SELECT 'ORACLE', 
LPAD('ORACLE', 10, '#'),
RPAD('ORACLE', 10, '#'),
RPAD('841205-1234567', 14, '*'),
RPAD('841205-1', 14, '*')

FROM DUAL;



SELECT TRIM('   ORACLE   '),
LTRIM ('   ORACLE   '),
RTRIM ('   ORACLE   ')
FROM DUAL;

SELECT TRIM('   ORACLE   '),
TRIM(LEADING FROM '   ORACLE   '),
TRIM(TRAILING FROM '   ORACLE   ')
FROM DUAL;





FROM DUAL
SELECT  FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
SELECT * FROM EMP
