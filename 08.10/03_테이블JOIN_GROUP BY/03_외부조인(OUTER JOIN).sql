--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
----고객테이블에는 있는데, 주문(판매) 테이블에 없는 사람
--------
--(방법1) MINUS : 차집합 처리
SELECT CUSTID FROM CUSTOMER --1,2,3,4,5
MINUS
SELECT CUSTID FROM ORDERS; -- 1,1,2,3,4,1, .....
------------------------
--(방법2) 서브쿼리 
SELECT *
FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
-------------------------
-- (방법3) 외부조인 OUTER JOIN
-- 고객 중 한 번도 구입내역이 없는 고객명단 (나중에 이벤트에 넘길 명단(데이터) 방법으로 사용)
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE
--    , O.ORDERID, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+) --조인조건(LEFT OUTER JOIN), 오른쪽에 부족한 부분 +하여  NULL값 표시했음
AND O.ORDERID IS NULL -- 찾을(검색,선택)조건
;
--==============================================================
-- 표준 SQL(LEFT OUTER JOIN)
SELECT *
FROM CUSTOMER C LEFT OUTER JOIN ORDERS O --좌측기준 (CUSTOMER)
    ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL
;

-- RIGHT OUTER JOIN
SELECT *
FROM ORDERS O RIGHT OUTER JOIN CUSTOMER C --우측기준 (CUSTOMER)
    ON  O.CUSTID = C.CUSTID
WHERE O.ORDERID IS NULL
;

-- 외부조인(우측기준) 
SELECT C.CUSTID, C.NAME, C.ADDRESS, C.PHONE
    , O.ORDERID, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE O.CUSTID(+) = C.CUSTID --조인조건(RIGHT OUTER JOIN) // 우측은 전부 나오고, 좌측은 부족한 부분 명시적으로 채워넣기
AND O.ORDERID IS NULL -- 찾을(검색,선택)조건
;
------------------------------------------------
-- 조인(JOIN, INNER JOIN, 내부조인) : 조인테이블 모두에 존재하는 데이터를 검색
-- 외부조인(OUTER JOIN) : 어느 한 쪽 테이블에만 존재하는 데이터를 검색
------------------------------------------------

CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT VALUES ('10', '총무부');
INSERT INTO DEPT VALUES ('20', '급여부');
INSERT INTO DEPT VALUES ('30', 'IT부');
COMMIT;

CREATE TABLE DEPT1 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT1 VALUES ('10', '총무부');
INSERT INTO DEPT1 VALUES ('20', '급여부');
COMMIT;


CREATE TABLE DEPT2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);

INSERT INTO DEPT2 VALUES ('20', '급여부');
INSERT INTO DEPT2 VALUES ('30', 'IT부');
COMMIT;

--=================================================
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;

--LEFT OUTER JOIN : 좌측 테이블 기준(좌측 데이터 모두표시, )
SELECT *
    FROM DEPT D, DEPT1 D1
    WHERE D.ID = D1.ID(+) --기준 테이블에는 있고, 반대 테이블에는 없는 것을 찾기위함 : (+)
;

--RIGHT OUTER JOIN : 우측 테이블 기준(우측 데이터 모두표시)
SELECT *
    FROM DEPT2 D2, DEPT D
    WHERE D2.ID(+) = D.ID
;

-- FULL OUTER JOIN(표준SQL) : 테이블 기준(우측 데이터 모두표시)
SELECT *
    FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
        ON D1.ID = D2.ID
ORDER BY D1.ID 
;
-------------------------------------
--(실습) DEPT1, DEPT2 테이블 사용해서 
--1. DEPT1 에는 있고, DEPT2 에는 없는 데이터 찾기(LEFT OUTER JOIN)
--2. DEPT2 에는 있고, DEPT1 에는 없는 데이터 찾기(RIGHT OUTER JOIN)
-------------------------------------

--1. DEPT1 에는 있고, DEPT2 에는 없는 데이터 찾기(LEFT OUTER JOIN)
SELECT *
    FROM DEPT1 D1, DEPT2 D2
    WHERE D1.ID = D2.ID(+)
        AND D2.ID IS NULL
;
SELECT *
    FROM DEPT1 D1 LEFT OUTER JOIN DEPT2 D2 --조인테이블 + 조인방식(좌측기준)
        ON D1.ID = D2.ID
    WHERE D2.ID IS NULL --D1에 일부 데이터가 있지만, D2에 일부 데이터가 없는 것을 구하는 것.
;

--2. DEPT2 에는 있고, DEPT1 에는 없는 데이터 찾기(RIGHT OUTER JOIN)
SELECT *
    FROM DEPT1 D1, DEPT2 D2
    WHERE D1.ID(+) = D2.ID
        AND D1.ID IS NULL
;
SELECT *
    FROM DEPT1 D1 RIGHT OUTER JOIN DEPT2 D2 --조인테이블 + 조인방식(우측기준)
        ON D1.ID = D2.ID
    WHERE D1.ID IS NULL
;

--3. 양쪽의 NULL값 구하기 (FULL OUTER JOIN)
--(+)를 양쪽에 대입하지 못하므로 표준SQL 식을 써야 한다.

--3_1. 모든 집합
SELECT *
    FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
        ON D1.ID = D2.ID
ORDER BY D1.ID
;
--3_2. NULL값만
SELECT *
    FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
        ON D1.ID = D2.ID
    WHERE D1.ID IS NULL 
        OR D2.ID IS NULL 
ORDER BY D1.ID
;

--번외_교집합 (모든집합 - NULL값)
SELECT *
    FROM DEPT1 D1 INNER JOIN DEPT2 D2
        ON D1.ID = D2.ID
ORDER BY D1.ID
;