DROP TABLE VOUCHER_DETAILS;
DROP TABLE VOUCHER_INFO;
DROP TABLE PARTY_INFO;
DROP TABLE BANKOPENINGBAL_INFO;
DROP TABLE BANK_INFO;
DROP TABLE ACCOUNTCODE_INFO;
---- ACCOUNT CODE MASTER

CREATE TABLE ACCOUNTCODE_INFO (
ACCOUNTHEAD VARCHAR2(10) PRIMARY KEY,
PARTICULAR VARCHAR2(50),
TYPE CHAR(1),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE);

---- BANK MASTER

CREATE TABLE BANK_INFO (
BANKNAME VARCHAR2(50),
BRANCHNAME Varchar2(50),
BANKCODE VARCHAR2(10),
ADDRESS Varchar2(150),
PHONENO Varchar2(15),
FAXNO Varchar2(15),
ACCOUNTCODE Varchar2(20),
ACCOUNTNO Varchar2(20) PRIMARY KEY,
ACCOUNTTYPE Char(1),
IFSCCODE Varchar2(11) UNIQUE ,
NEFT_RTGSCODE Varchar2(20),
MICRNO Varchar2(9),
CONTACTPERSON Varchar2(50),
MOBILENO Varchar2(10),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE,
CONSTRAINT FK_BANK_ACTNO FOREIGN KEY (ACCOUNTCODE) REFERENCES ACCOUNTCODE_INFO(ACCOUNTHEAD));

---- BANK OPENING BAL CODE MASTER

CREATE TABLE BANKOPENINGBAL_INFO (
ACCOUNTNO Varchar2(20) PRIMARY KEY,
OPENEDDATE date,
AMOUNT NUMBER(15,4),
DETAILS VARCHAR2(150),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE,
CONSTRAINT FK_BANKOPENINGBAL_ACTNO FOREIGN KEY (ACCOUNTNO) REFERENCES BANK_INFO(ACCOUNTNO) );

---- PARTY MASTER

CREATE TABLE PARTY_INFO (
PARTYNAME VARCHAR2(50) PRIMARY KEY,
PARTYDETAIL Varchar2(50),
FAXNO Varchar2(15),
EMAIL Varchar2(150),
MOBILENO Varchar2(10),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE);


----VOUCHERS

CREATE TABLE VOUCHER_INFO (
KEYNO VARCHAR2(12) primary Key,
ACCOUNTNO Varchar2(20),
FYEAR Varchar2(7),
TRUSTTYPE CHAR(1),
VOUCHERTYPE CHAR(1),
PARTYTYPE CHAR(1),
DETAILS VARCHAR2(300),
EMP_PARTY_CODE VARCHAR2(20),
VOUCHERNO VARCHAR2(25),
PREPAREDBY VARCHAR2(50),
CHECKEDBY VARCHAR2(50),
APPROVEDBY VARCHAR2(50),
APPROVAL CHAR(1) default 'N',
voucher_dt date,
chequeNO VARCHAR2(25),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE,
CONSTRAINT FK_VOUCHER_ACTNO FOREIGN KEY (ACCOUNTNO) REFERENCES BANK_INFO(ACCOUNTNO) );

CREATE TABLE VOUCHER_DETAILS (
KEYNO VARCHAR2(12),
ACCOUNTHEAD VARCHAR2(10),
MONTH_YEAR VARCHAR2(8),
AMOUNT NUMBER(16,4),
DETAILS VARCHAR2(300),
ENTEREDBY VARCHAR2(20),
ENTEREDDT DATE DEFAULT SYSDATE,
Primary key (KEYNO,ACCOUNTHEAD),
CONSTRAINT FK_VOUCHERDT_KEYNO FOREIGN KEY (KEYNO) REFERENCES VOUCHER_INFO(KEYNO) ,
CONSTRAINT FK_VOUCHER_ACTHEAD FOREIGN KEY (ACCOUNTHEAD) REFERENCES ACCOUNTCODE_INFO(ACCOUNTHEAD));

alter table BANK_INFO add  TRUSTTYPE CHAR(1);

delete from PARTY_INFO;
alter table PARTY_INFO add  (BANKNAME VARCHAR2(50),
BRANCHNAME Varchar2(50),
BANKCODE VARCHAR2(10),
ADDRESS Varchar2(150),
PHONENO Varchar2(15),
BFAXNO Varchar2(15),
ACCOUNTCODE Varchar2(20),
ACCOUNTNO Varchar2(20) unique not null,
ACCOUNTTYPE Char(1),
IFSCCODE Varchar2(11) UNIQUE ,
NEFT_RTGSCODE Varchar2(20),
MICRNO Varchar2(9),
CONTACTPERSON Varchar2(50),
BMOBILENO Varchar2(10),
CONSTRAINT FK_PARTY_ACTNO FOREIGN KEY (ACCOUNTCODE) REFERENCES ACCOUNTCODE_INFO(ACCOUNTHEAD));
alter table PARTY_INFO add  contactNo Varchar2(15);

alter table Voucher_details drop column amount;

alter table Voucher_details add( credit number(15,4),debit number(15,4));

alter table Voucher_info add preperation_dt date default sysdate;

alter table BANK_INFO add(unitname varchar2(20));

alter table Voucher_info drop column chequeNO;
alter table Voucher_details add chequeNO VARCHAR2(25);



drop table tracking_log;
create table tracking_log (
userCd varchar2(30),
description varchar2(200),
opeartionmode char(1),
keyfield varchar2(30),
modulecode varchar2(3),
screenname varchar2(30),
entereddate date default sysdate
);

alter table bank_info add region varchar2(50);
alter table bank_info modify (IFSCCODE Varchar2(20),NEFT_RTGSCODE Varchar2(20),MICRNO Varchar2(20),bankcode varchar2(25));
alter table voucher_info modify EMP_PARTY_CODE VARCHAR2(50);

alter table party_info modify (IFSCCODE Varchar2(20),NEFT_RTGSCODE Varchar2(20),MICRNO Varchar2(20),bankcode varchar2(25),partydetail varchar2(150));

alter table VOUCHER_INFO add(ecpfacno varchar2(15),eregion varchar2(20), pfidFlag varchar2(5),employeename varchar2(100));

alter table ACCOUNTCODE_INFO add (NEWAccountHead varchar2(10),Newparticular varchar2(50),Newtype char(1));

alter table party_info add partycode varchar2(10) ;
create table PARTY_BANK_DETAILS (
PARTYCODE  VARCHAR2(10) not null,
BANKNAME VARCHAR2(50),
BRANCHNAME Varchar2(50),
BANKCODE VARCHAR2(25),
ADDRESS Varchar2(150),
PHONENO Varchar2(15),
BFAXNO Varchar2(15),
ACCOUNTNO Varchar2(20) primary key,
ACCOUNTTYPE Char(1),
IFSCCODE Varchar2(20) UNIQUE ,
NEFT_RTGSCODE Varchar2(20),
MICRNO Varchar2(20),
CONTACTPERSON Varchar2(50),
BMOBILENO Varchar2(10)
);


create sequence PARTY_SEQ;
update party_info set partycode=lpad(PARTY_SEQ.nextval,10,'0');

insert INTO PARTY_BANK_DETAILS (PARTYCODE,BANKNAME,BRANCHNAME,BANKCODE,ADDRESS,PHONENO,BFAXNO,ACCOUNTNO,ACCOUNTTYPE,IFSCCODE,NEFT_RTGSCODE,MICRNO,CONTACTPERSON,BMOBILENO) select PARTYCODE,BANKNAME,BRANCHNAME,BANKCODE,ADDRESS,PHONENO,BFAXNO,ACCOUNTNO,ACCOUNTTYPE,IFSCCODE,NEFT_RTGSCODE,MICRNO,CONTACTPERSON,BMOBILENO  from  party_info;
drop trigger  CHECK_ACCNO;
CREATE OR REPLACE TRIGGER CHECK_ACCNO BEFORE INSERT OR UPDATE ON PARTY_BANK_DETAILS FOR EACH ROW
    DECLARE
      ACCNO1  VARCHAR2(100);
     BEGIN
      IF INSERTING THEN
           SELECT count(ACCOUNTNO) INTO ACCNO1 FROM bank_info WHERE ACCOUNTNO=:NEW.ACCOUNTNO;
          IF ACCNO1 >=1 THEN
             RAISE_APPLICATION_ERROR(-20010,'Account Number Already Exists');
         END IF;
      ELSIF UPDATING THEN
        SELECT count(ACCOUNTNO) INTO ACCNO1 FROM bank_info WHERE ACCOUNTNO=:NEW.ACCOUNTNO;
            IF ACCNO1>=1 THEN
         RAISE_APPLICATION_ERROR(-20010,'Account Number Already Exists');
         END IF;
      END IF;
    END;
 
/
CREATE OR REPLACE TRIGGER CHECK_PACCNO BEFORE INSERT OR UPDATE ON bank_info FOR EACH ROW
DECLARE
  ACCNO1  VARCHAR2(100);
 BEGIN
  IF INSERTING THEN
       SELECT count(ACCOUNTNO) INTO ACCNO1 FROM PARTY_BANK_DETAILS WHERE ACCOUNTNO=:NEW.ACCOUNTNO;
      IF ACCNO1 >=1 THEN
         RAISE_APPLICATION_ERROR(-20010,'Account Number Already Exists');
     END IF;
  ELSIF UPDATING THEN
     SELECT count(ACCOUNTNO) INTO ACCNO1 FROM PARTY_BANK_DETAILS WHERE ACCOUNTNO=:NEW.ACCOUNTNO;
        IF ACCNO1>=1 THEN
     RAISE_APPLICATION_ERROR(-20010,'Account Number Already Exists');
     END IF;
  END IF;
END;
/
alter table party_info drop (BANKNAME,BRANCHNAME,BANKCODE,ADDRESS,PHONENO,BFAXNO,ACCOUNTCODE,ACCOUNTNO,ACCOUNTTYPE,IFSCCODE,NEFT_RTGSCODE,MICRNO,CONTACTPERSON,BMOBILENO);
alter table party_info modify partycode varchar2(10) not null ;

alter table bankopeningbal_info add amounttype char(2) default 'DR';

create table AccountCodeType_INFO (
code char(5) primary key,
accountcodetype varchar2(50) unique not null,
description varchar2(150),
enteredby varchar2(10),
entereddt date default sysdate
);

update accountcode_info set OpenDATE='';
commit;
 
alter table accountcode_info drop  (amount,amounttype);
create table accountcode_details (ACCOUNTHEAD VARCHAR2(10) , trusttype char(1),amount NUMBER(15,2),AMOUNTTYPE CHAR(2) );

alter table voucher_info add transactionType char(1);