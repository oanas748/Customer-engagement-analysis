With title_total_minutes as 
( 
select
	course_id,
	course_title,
	round(sum(minutes_watched),2) as total_minutes_watched,
	count(distinct student_id) as num_students
from
	365_course_info
join
	365_student_learning
using (course_id)
group by course_id),
title_avg_minutes as
(
select
	m.course_id,
    m.course_title,
    m.total_minutes_watched,
    round((m.total_minutes_watched/m.num_students) ,2) as avg_minutes
from
	title_total_minutes m
    ),
title_rating as
(
select
a.*,
    count(course_rating) as number_of_rating,
	IF(COUNT(course_rating) != 0, SUM(course_rating) / COUNT(course_rating), 0) AS average_rating

from
    
    title_avg_minutes a
 left join
	365_course_ratings r
using (course_id)
group by course_id
)
select *
from
title_rating