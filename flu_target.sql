DROP TABLE IF EXISTS me_need_flu;
CREATE TABLE me_need_flu (
    HOSPCODE VARCHAR(5),
		PID VARCHAR(15),
		BIRTH date,
    CID VARCHAR(13),
		GRP1 VARCHAR(2),
    GRP2 VARCHAR(2),
	  GRP3 VARCHAR(2),
    GRP4 VARCHAR(2),
	  GRP5 VARCHAR(2),
    GRP6 VARCHAR(2),
	  GRP7 VARCHAR(2),
    GRP8 VARCHAR(2),
	  GRP9 VARCHAR(2),
    GRP10 VARCHAR(2),
	  GRP11 VARCHAR(2),
    GRP12 VARCHAR(2),
    C01 VARCHAR(100),
    C02 VARCHAR(100),
    C03 VARCHAR(100),
    C04 VARCHAR(100),
    C05 VARCHAR(100),
    C06 VARCHAR(100),
    C07 VARCHAR(100),
    C08 VARCHAR(100),
    C09 VARCHAR(100),
    C10 VARCHAR(100),
		INDEX USING BTREE (CID),
    PRIMARY KEY (HOSPCODE,PID)
) ENGINE=InnoDB;

# add person

INSERT INTO me_need_flu (HOSPCODE,PID,CID,BIRTH )
SELECT HOSPCODE,PID,CID,BIRTH 
FROM person 
WHERE NOT ISNULL(CID) AND CID <>'' AND SUBSTR(CID,1,1)<>'0' AND SUBSTR(CID,1,1)<>'7' AND SUBSTR(CID,1,1)<>'8' AND SUBSTR(CID,1,1)<>'9';


# 1 COPD J41-J44 

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'J41' AND 'J44' 
) b 
ON a.CID = b.CID  
SET a.GRP1 = '01';


# 2 Asthma J45-J46

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'J45' AND 'J46' 
) b 
ON a.CID = b.CID  
SET a.GRP2 = '01';

# 3 Heart Disease I05-I09 I11  I13  I20  I52  

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'I05' AND 'I09' 
OR substr(DIAGCODE,1,3) IN ('I11','I13','I20','I52')
) b 
ON a.CID = b.CID  
SET a.GRP3 = '01';


# 4 Cerebrovascular Disease I60-I69
UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'I60' AND 'I69' 
) b 
ON a.CID = b.CID  
SET a.GRP4 = '01';

# 5 Diabetes  DM

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'E10' AND 'E14' 
) b 
ON a.CID = b.CID  
SET a.GRP5 = '01';

# 6 Chronic Renal Failure  

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'N18' AND 'N19' 
) b 
ON a.CID = b.CID  
SET a.GRP6 = '01';

# 7 Cancer  

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,4) ='Z511'
) b 
ON a.CID = b.CID  
SET a.GRP7 = '01';

# 8 Thaslassemia 

UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) ='D56'
) b 
ON a.CID = b.CID  
SET a.GRP8= '01';

# 9 SLE 
UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) ='M32'
) b 
ON a.CID = b.CID  
SET a.GRP9= '01';

# 10 HIV 
UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'B20' and 'B24'
) b 
ON a.CID = b.CID  
SET a.GRP10= '01';

# 11 Pregnancy 
 
UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'O00' and 'O99'
) b 
ON a.CID = b.CID  
SET a.GRP11= '01';

# 12 Mentaly and Congenital Abnormalities  
 
UPDATE me_need_flu a 
JOIN 
(
SELECT p.CID 
FROM diagnosis_opd o
LEFT JOIN person p
ON o.HOSPCODE=p.HOSPCODE and	 o.PID=p.PID 
WHERE substr(DIAGCODE,1,3) BETWEEN 'F70' and 'F79' OR substr(DIAGCODE,1,3) BETWEEN 'Q00' and 'Q99'
) b 
ON a.CID = b.CID  
SET a.GRP12= '01';
