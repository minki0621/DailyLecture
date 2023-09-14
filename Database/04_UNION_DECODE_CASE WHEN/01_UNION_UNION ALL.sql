/* UNION, UNION ALL : 합집합 처리
- UNION : 중복 데이터는 하나만 선택
- UNION ALL : 모든 데이터를 선택(중복데이터도)
(주의) 조회하는 컬럼의 이름, 순서, 갯수, 타입이 일치하도록 작성
*********************/
-- UNION 사용 예제
--갯수가 안맞거나 타입이 다르면 사용 불가
--같은 컬럼끼리 합치기!(유의미) - 다른 컬럼끼리는 데이터로서 가치가 떨어짐
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3);
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5);
--UNION으로 합하기 : 중복데이터는 1개만 선택되어진다.
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)
UNION
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5);
--동일데이터 3.장미란 은 하나만 표기

-- UNION ALL 합하기 : 중복데이터도 모두 선택
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5)
ORDER BY NAME; -- ORDER BY 절은 문장 맨 뒤 하나만. 

-------------------------
-- MINUS : 차집합(빼기)
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)
MINUS
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5);
-------------------
-- INTERSECT : 교집합 - 조인문 중 INNER JOIN
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5);

--조인문
SELECT *
FROM (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)) A, 
     (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5)) B
WHERE A.CUSTID = B.CUSTID
AND A.NAME = B.NAME 
;

)