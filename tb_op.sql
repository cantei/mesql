SELECT person.HOSPCODE,person.CID,person.`NAME`,person.LNAME,person.TYPEAREA
,person.BIRTH
,t1.FIRST_DX,t1.FIRST_VISIT
,TIMESTAMPDIFF(YEAR,person.BIRTH,t1.FIRST_VISIT) as AGE
FROM person 
INNER  JOIN 
		(
		SELECT t.HOSPCODE,t.PID,t.CID,t.`NAME`,t.LNAME,t.SEX,t.BIRTH
		,t.DX
		,t.DATE_DX
		,SPLIT_STR(t.DX,',', 1) AS FIRST_DX
		,SPLIT_STR(t.DATE_DX,',', 1) AS FIRST_VISIT
		FROM 
		(
		SELECT p.HOSPCODE,p.PID,p.CID,p.`NAME`,p.LNAME,p.SEX,p.BIRTH
		,GROUP_CONCAT(o.DIAGCODE ORDER BY o.DATE_SERV ASC SEPARATOR ',') as DX
		,GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV ASC SEPARATOR ',') as DATE_DX
		FROM diagnosis_opd o
		INNER JOIN person p
		ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
		WHERE SUBSTR(o.DIAGCODE,1,3) BETWEEN 'A15' AND 'A19'
		AND  o.HOSPCODE ='10727'
		GROUP BY p.CID
		ORDER BY o.DATE_SERV 
		) as t
) as t1 
ON person.CID=t1.CID
WHERE person.TYPEAREA in ('1','2','3')
AND person.HOSPCODE='07718'
ORDER BY t1.FIRST_VISIT DESC 
