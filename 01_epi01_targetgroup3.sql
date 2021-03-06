# ความครอบคลุมวัคซีนในเด็กอายุครบ 3 ปี

SET @d1='2014-10-01';
SET @d2='2015-09-30';

SELECT t.*
,CASE WHEN  NOT ISNULL(LAJE1) AND NOT ISNULL(LAJE2) THEN 'compt1'
			WHEN  NOT ISNULL(JE1) AND NOT ISNULL(JE2)  AND NOT ISNULL(JE3) THEN 'compt2'
			WHEN  NOT ISNULL(JE1) AND NOT ISNULL(JE2)  AND NOT ISNULL(LAJE1) THEN 'compt3'
ELSE NULL 
END AS 'JEFULLY'

FROM 
(
SELECT p.idcard
,p.pcucodeperson,p.pid
,concat(c.titlename,p.fname,'    ',p.lname) as fullname
,substr(h.villcode,7,2) as moo,h.hno
,p.birth
,TIMESTAMPDIFF(month,p.birth,CURDATE()) as agemonth
,p.mother
,MIN(if(e.vaccinecode='BCG',e.dateepi,NULL)) as 'BCG'
,MIN(if(e.vaccinecode='HBV1',e.dateepi,NULL)) as 'HBV1'
,MIN(if(e.vaccinecode in ('DTP1','DHB1','D11','D21','D31','D41','D51'),e.dateepi,NULL)) as 'DHB1'
,MIN(if(e.vaccinecode in ('OPV1','D41','D51'),e.dateepi,NULL)) as 'OPV1'
,MIN(if(e.vaccinecode in ('DTP2','DHB2','D12','D22','D32','D42','D52'),e.dateepi,NULL)) as 'DHB2'
,MIN(if(e.vaccinecode in ('OPV2','D42','D52'),e.dateepi,NULL)) as 'OPV2'
,MIN(if(e.vaccinecode in ('IPV-P','D42','D52'),e.dateepi,NULL)) as 'IPV'
,MIN(if(e.vaccinecode in ('DTP3','DHB3','D13','D23','D33','D43','D53'),e.dateepi,NULL)) as 'DHB3'
,MIN(if(e.vaccinecode in ('OPV3','D43','D53'),e.dateepi,NULL)) as 'OPV3'
,MIN(if(e.vaccinecode='MMR',e.dateepi,NULL)) as 'MMR1'
,MIN(if(e.vaccinecode in ('DTP4','D14','D24','D34','D44','D54'),e.dateepi,NULL)) as 'DTP4'
,MIN(if(e.vaccinecode  in ('OPV4','D44','D54'),e.dateepi,NULL)) as 'OPV4'
,MIN(if(e.vaccinecode='MMR2',e.dateepi,NULL)) as 'MMR2'
,MIN(if(e.vaccinecode in ('JE1'),e.dateepi,NULL)) as 'JE1'
,MIN(if(e.vaccinecode in ('JE2'),e.dateepi,NULL)) as 'JE2'
,MIN(if(e.vaccinecode in ('JE3'),e.dateepi,NULL)) as 'JE3'
,MIN(if(e.vaccinecode in ('J11'),e.dateepi,NULL)) as 'LAJE1'
,MIN(if(e.vaccinecode in ('J12'),e.dateepi,NULL)) as 'LAJE2'
,concat(v.fname,'    ',v.lname) as 'volanteer'
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
on p.hcode=h.hcode AND p.pcucodeperson=h.pcucode 
LEFT JOIN visitepi e
on p.pid=e.pid AND p.pcucodeperson=e.pcucodeperson 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND p.nation='99'
AND p.birth BETWEEN DATE_SUB(@d1, INTERVAL 3 YEAR) AND DATE_SUB(@d2, INTERVAL 3 YEAR)
GROUP BY CONCAT(p.pcucodeperson,p.pid)
ORDER BY  h.villcode,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
) as t
HAVING ISNULL(JEFULLY)
;
