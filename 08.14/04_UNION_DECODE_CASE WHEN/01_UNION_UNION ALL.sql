/* UNION, UNION ALL : 합집합 처리
- UNION : 중복데이터는 하나만 선택 
- UNION ALL : 모든 데이터를 선택(중복데이터도)
(주의) 조회하는 컬럼의 이름, 순서, 갯수, 타입이 일치하게 작성
*/

-- UNION 으로 합하기 : 중복데이터는 1개만 선택
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (1,2,3)
UNION
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (3,4,5);

-- UNION ALL 합하기 : 중복데이터(동일데이터) 모두 선택
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5)
ORDER BY NAME --ORDER BY 절은 마지막에만 사용 가능
;
------------------------------
-- MINUS : 차집합
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (1,2,3)
MINUS
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (3,4,5)
;
------------------------------
-- INTERSECT : 교집합_ 조인문 중 INNER JOIN
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (1,2,3)
INTERSECT
SELECT CUSTID FROM CUSTOMER WHERE CUSTID IN (3,4,5)
;
-- JOIN문
SELECT *
FROM (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1,2,3)) A
    INNER JOIN (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3,4,5)) B
    ON A.CUSTID = B.CUSTID
        AND A.NAME = B.NAME
;


