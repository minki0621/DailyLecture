-- SYSTEM 유저에서 USER 생성 // MYSTUDY
-- USER SQL
ALTER USER "MYSTUDY"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS

-- ROLES
ALTER USER "MYSTUDY" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES

-- SYSTEM 유저에서 USER 생성
-- USER SQL
CREATE USER "MYSTUDY" IDENTIFIED BY "mystudypw"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- ROLES
GRANT "CONNECT" TO "MYSTUDY" ;
GRANT "RESOURCE" TO "MYSTUDY" ;
----------------------------------



