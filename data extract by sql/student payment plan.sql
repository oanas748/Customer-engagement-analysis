select
	a.*,
	if( date_watched between p.date_start and p.date_end,1,0) as paid 
FROM
(SELECT 
    i.*,
    l.date_watched,
    IF(l.student_id IS NULL, 0, ROUND(SUM(l.minutes_watched), 2)) AS minutes_watched,
    IF(l.student_id IS NULL, 0, 1) AS onboarded
FROM
    365_student_info i
        JOIN
    365_student_learning l USING (student_id) 
GROUP BY student_id , date_watched)  a
left join
purchases_info p using (student_id)