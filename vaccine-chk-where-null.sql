# HDC
SET @startdate='2015-10-01';
SET @stopdate='2016-09-30';


SELECT CID,MISSED1,MISSED2,MISSED3,MISSED4,MISSED5,MISSED6,MISSED7,MISSED8,MISSED9
-- ,CONCAT_WS(MISSED1,MISSED2,MISSED3,MISSED4,MISSED5,MISSED6,MISSED7,MISSED8,MISSED9) AS MISSED_ALL
,CONCAT(COALESCE(MISSED1,''),COALESCE(MISSED2,''),COALESCE(MISSED3,''),COALESCE(MISSED4,''),COALESCE(MISSED5,''),COALESCE(MISSED6,'')
,COALESCE(MISSED7,''),COALESCE(MISSED8,''),COALESCE(MISSED9,'') ) AS MISSED
FROM 
(
SELECT 
CID
,if(ISNULL(BCG_VISIT),'BCG1',NULL) as MISSED1
,if(ISNULL(HB1_VISIT),'HBV1',NULL) as MISSED2
,if(ISNULL(DHB1_VISIT),'DHB1',NULL) as MISSED3
,if(ISNULL(OPV1_VISIT),'OPV1',NULL) as MISSED4
,if(ISNULL(DHB2_VISIT),'DHB2',NULL) as MISSED5
,if(ISNULL(OPV2_VISIT),'OPV2',NULL) as MISSED6
,if(ISNULL(DHB3_VISIT),'DHB3',NULL) as MISSED7
,if(ISNULL(OPV3_VISIT),'OPV3',NULL) as MISSED8
,if(ISNULL(MMR_VISIT),'MMR1',NULL) as MISSED9
FROM me_vaccined 
WHERE	  TYPEAREA in('1','3') 
AND (BIRTH BETWEEN DATE_ADD(@startdate,INTERVAL -1 YEAR) AND DATE_ADD(@stopdate,INTERVAL -1 YEAR) )
HAVING NOT ISNULL(MISSED1) OR  NOT ISNULL(MISSED2) OR  NOT ISNULL(MISSED3) OR  NOT ISNULL(MISSED4) 
OR  NOT ISNULL(MISSED5) OR  NOT ISNULL(MISSED6) OR  NOT ISNULL(MISSED7)
OR  NOT ISNULL(MISSED8) OR  NOT ISNULL(MISSED9)
) as t 
