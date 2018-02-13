create or replace view seat_attendance as
	select s.id, s.type, d.party, count(1) as quantity
	from Seats s join Deputies d on s.id = d.SeatId join Attendances a on a.DeputyId = d.id
	where a.attendance in ('A', 'AO', 'PM', 'IV')
	group by s.id, s.type, d.party;

create or replace view attendance_frequency as
	select s.quantity, count(1) as frequency
	from seat_attendance s
    group by s.quantity;

create or replace view attendance_list as
select s.id, s.state, s.area as district, s.type, MAX(d.displayName) as displayName,
	GROUP_CONCAT(distinct d.displayName SEPARATOR ', ') as attendanceEntry, MAX(d.party) as party, count(1) as entries
from Seats s join Deputies d on s.id = d.SeatId
	join Attendances a on a.DeputyId = d.id and a.attendance in ('A', 'AO', 'PM', 'IV')
group by s.id, s.state, s.area, s.type;
