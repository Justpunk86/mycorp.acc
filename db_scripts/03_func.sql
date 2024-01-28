
create function get_job_title(in_person_num text, in_month integer, in_year integer) 
returns text
as $$
	select djt.job_title 
		from emp_jobs_data ejd 
		join dic_job_title djt on ejd.job_title_id = djt.job_title_id 
		where (select e.person_num from employees e where e.emp_id = ejd.emp_id) = in_person_num
		and (ejd.job_start_date <= make_date(in_year,in_month,1)
			or 
				(
					extract(month from ejd.job_start_date) = in_month 
					and
					extract(year from ejd.job_start_date) = in_year
				)
			)
		order by ejd.job_start_date desc limit 1;
$$ language sql;



create function get_salary(in_person_num text, in_month integer, in_year integer) 
returns numeric
as $$
select sum(ss.salary)
	from
	(select 0 salary
	union
	select s.salary
	from
	(select esd.salary 
		from emp_salary_data esd  
		where (select e.person_num from employees e where e.emp_id = esd.emp_id) = in_person_num
		and (esd.salary_start_date <= make_date(in_year,in_month,1)
			or 
				(
					extract(month from esd.salary_start_date) = in_month 
					and
					extract(year from esd.salary_start_date) = in_year
				)
			)
		order by esd.salary_start_date desc limit 1) s
	) ss;
$$ language sql;

create function get_sick_days(in_person_num text, in_month integer, in_year integer)
returns integer
as $$
	select sum(abs(s.cnt_sd))
		  from 
			(
			select 0 cnt_sd
			union all
			select (esd.date_stop_sick - esd.date_start_sick) cnt_sd
			 from emp_sick_data esd
			where (select e.person_num from employees e where e.emp_id = esd.emp_id) = in_person_num
			  and esd.date_start_sick >= make_date(in_year,in_month,1)
			  and esd.date_stop_sick <= (make_date(in_year,in_month,1) + '1 month'::interval)::date
			)s
$$ language sql;

drop function get_days_month;

create function get_days_month(in_month integer, in_year integer)
returns integer
as $$
declare
	total_days integer;
	result_cnt integer := 0;	
	start_date date;
	next_day text;

begin
	
	total_days = abs(make_date(in_year,in_month,1) - 
				(make_date(in_year,in_month,1) + '1 month'::interval)::date);

	start_date = make_date(in_year,in_month,1);
	next_day = to_char(start_date,'DAY');
	
	for i in 1..total_days
		loop
			
		
			if (trim(next_day) like 'SATURDAY' or trim(next_day) like 'SUNDAY')	
			then
				null;				
			else
				result_cnt = result_cnt + 1;
			end if;
		next_day = to_char(start_date + i,'DAY');
		end loop;
	
	return result_cnt;
end;
$$ language plpgsql;

drop function get_work_days_interval;

create function get_work_days_interval(start_date date, end_date date)
returns integer
as $$
declare
	total_days integer;
	result_cnt integer := 0;	
	next_day text;

begin
	
	total_days := abs(end_date - start_date);

	next_day = to_char(start_date,'DAY');
	
	for i in 1..total_days
		loop
		
			if (trim(next_day) like 'SATURDAY' or trim(next_day) like 'SUNDAY')	
			then
				null;				
			else
				result_cnt = result_cnt + 1;
			end if;
		next_day = to_char(start_date + i,'DAY');
		end loop;
	
	return result_cnt;
end;
$$ language plpgsql;


drop function get_worked_days;

create function get_worked_days(in_person_num text, in_month integer, in_year integer)
returns integer
as $$
	select 
		case 
			when ejd.job_start_date >= make_date(in_year,in_month,1) and
				e.leaving_date <= (make_date(in_year,in_month,1) + '1 month'::interval)::date
			then abs(get_work_days_interval(ejd.job_start_date, e.leaving_date) - 
					get_sick_days(in_person_num,in_month,in_year))
			when ejd.job_start_date <= make_date(in_year,in_month,1) and
				e.leaving_date <= (make_date(in_year,in_month,1) + '1 month'::interval)::date and 
				e.leaving_date >= make_date(in_year,in_month,1)
			then abs(get_work_days_interval(make_date(in_year,in_month,1), e.leaving_date) - 
					get_sick_days(in_person_num,in_month,in_year))
			when ejd.job_start_date >= make_date(in_year,in_month,1) and
				ejd.job_start_date <= (make_date(in_year,in_month,1) + '1 month'::interval)::date and
				e.leaving_date >= (make_date(in_year,in_month,1) + '1 month'::interval)::date
			then abs(
					get_work_days_interval(ejd.job_start_date, 
										(make_date(in_year,in_month,1) + '1 month'::interval)::date) - 
					get_sick_days(e.person_num,in_month,in_year))
			when ejd.job_start_date >= make_date(in_year,in_month,1) and
				ejd.job_start_date <= (make_date(in_year,in_month,1) + '1 month'::interval)::date and
				(e.leaving_date is null or 
				e.leaving_date <= make_date(in_year,in_month,1) or 
				e.leaving_date >= (make_date(in_year,in_month,1) + '1 month'::interval)::date
				)
			then abs(get_days_month(in_month,in_year) - 
					get_work_days_interval(make_date(in_year,in_month,1), ejd.job_start_date) - 
					get_sick_days(in_person_num,in_month,in_year))
			when ejd.job_start_date <= make_date(in_year,in_month,1) and
				(e.leaving_date is null or 
				e.leaving_date <= make_date(in_year,in_month,1) or 
				e.leaving_date >= (make_date(in_year,in_month,1) + '1 month'::interval)::date
				)
			then abs(get_days_month(in_month,in_year) - 
					get_sick_days(in_person_num,in_month,in_year))
			else 0
			end as cnt
				
	  from emp_jobs_data ejd 
	  join employees e 
	  	on e.emp_id = ejd.emp_id
	 where e.person_num = in_person_num;
$$ language sql;


select get_worked_days('mc-14', 12, 2022);
select * from employees e where e.emp_id  = 16;
select * from emp_jobs_data ejd ;

update employees 
set insurance_start_date = to_date('02.12.2022','dd.mm.yyyy')
where emp_id  = 15;


select ejd.job_start_date,
		e.leaving_date,
		case 
			when ejd.job_start_date >= make_date(2023,12,1) and
				e.leaving_date <= (make_date(2023,12,1) + '1 month'::interval)::date
			then abs(get_work_days_interval(ejd.job_start_date, e.leaving_date) - 
					get_sick_days(e.person_num,12,2023))
			when ejd.job_start_date <= make_date(2023,12,1) and
				e.leaving_date <= (make_date(2023,12,1) + '1 month'::interval)::date and 
				e.leaving_date >= make_date(2023,12,1)
			then abs(get_work_days_interval(make_date(2023,12,1), e.leaving_date) - 
					get_sick_days(e.person_num,12,2023))
			when ejd.job_start_date >= make_date(2023,12,1) and
				e.leaving_date >= (make_date(2023,12,1) + '1 month'::interval)::date
			then abs(
					get_work_days_interval(ejd.job_start_date, 
										(make_date(2023,12,1) + '1 month'::interval)::date) - 
					get_sick_days(e.person_num,12,2023))
			when ejd.job_start_date <= make_date(2023,12,1) and
				(e.leaving_date is null or 
				e.leaving_date <= make_date(2023,12,1) or 
				e.leaving_date >= (make_date(2023,12,1) + '1 month'::interval)::date
				)
			then abs(get_days_month(12,2023) - 
					get_sick_days(e.person_num,12,2023))
			else 0
			end as cnt
				
	  from emp_jobs_data ejd 
	  join employees e 
	  	on e.emp_id = ejd.emp_id
	 where e.person_num = 'mc-15';

create function get_piece_job(in_person_num text, in_month integer, in_year integer)
returns numeric
as $$
	select sum(s.cnt)
	from
	(select 0 as cnt
	union
	select epd.contract_amount as cnt
	from emp_piecework_data epd
	where (select e.person_num from employees e where e.emp_id = epd.emp_id) = in_person_num
	and (extract (month from epd.payment_date) = in_month and extract (year from epd.payment_date) = in_year)) s;

$$ language sql;



create function get_bonus(in_person_num text, in_month integer, in_year integer)
returns numeric
as $$
	select sum(s.cnt)
	from
	(select 0 as cnt
	union
	select ebd.amount as cnt
	from emp_bonus_data ebd
	where (select e.person_num from employees e where e.emp_id = ebd.emp_id) = in_person_num
	and (extract (month from ebd.payment_date) = in_month and extract (year from ebd.payment_date) = in_year)) s;
$$ language sql;



create function get_tax(in_person_num text, in_month integer, in_year integer)
returns numeric
as $$
	select 
		trunc(((get_salary(in_person_num, in_month, in_year) / get_days_month(in_month, in_year) * 
			get_worked_days(in_person_num,in_month,in_year)) +
		get_piece_job(in_person_num, in_month, in_year) +
		get_bonus(in_person_num, in_month, in_year)) * 
	(select dpp.value from dic_pay_params dpp where dpp.param_name = 'tax_ru'),2);
$$ language sql;



create function get_insurance_before(in_person_num text)
returns interval
as $$
	select sum(age(ejb.end_date::timestamp, ejb.start_date::timestamp)) insc_before
	from emp_jobs_before ejb
	where (select e.person_num from employees e where e.emp_id = ejb.emp_id) = in_person_num;	
$$ language sql;

create function get_seniority(in_person_num text)
returns interval
as $$
	select 
		(case when e.leaving_date is null 
				then (get_insurance_before(e.person_num) + age(current_date::timestamp, e.onboarding_date::timestamp))
		 else (get_insurance_before(e.person_num) + age(e.leaving_date::timestamp, e.onboarding_date::timestamp))
		 end) as ins_qty
	from employees e
	where e.person_num  = in_person_num;
$$ language sql;



create function get_avg_earning(in_person_num text, in_year integer)
returns numeric
as $$
declare
  result		numeric = 0;
  sal_month 	numeric;
  sal_per_day	numeric;
  total_days	integer = 0;
begin
	for i in 1..12
	loop
		if (get_worked_days(in_person_num, i, in_year) > 0)
		then
			sal_per_day = get_salary(in_person_num, i, in_year) / get_days_month(i, in_year);
		--raise notice '%', get_worked_days(in_person_num, i, in_year);
			total_days = total_days + get_worked_days(in_person_num, i, in_year);
			sal_month = get_worked_days(in_person_num, i, in_year) * sal_per_day;
	
		    sal_month = sal_month + 
		    			get_piece_job(in_person_num, i, in_year) +
		 				get_bonus(in_person_num, i, in_year) -
		 				get_tax(in_person_num, i, in_year);
		  
		    result = result + sal_month;
		end if;
	end loop;

	if (total_days = 0)
	then
		result = 0;
	else
		result = result/total_days;
	end if;

return trunc(result);

end;	
$$ language plpgsql;



create function get_sick_payment(in_person_num text, in_month integer, in_year integer)
returns numeric
as $$
	 select 
			case 
				when
					extract(year from justify_interval(get_seniority(e.person_num))) = 0 and
					extract(month from justify_interval(get_seniority(e.person_num))) <= 6 
				then 
					get_sick_days(e.person_num, in_month, in_year) * 
						trunc((select dpp.value 
								from dic_pay_params dpp 
								where dpp.param_name like 'mrot') /
						get_days_month(in_month, in_year),2)
				when 
					extract(year from get_seniority(e.person_num)) > 0 
						and extract(year from get_seniority(e.person_num)) <= 5
				then trunc(get_sick_days(e.person_num, in_month, in_year) * 
						(get_avg_earning(e.person_num, in_year) * 
						(select dsr.rate 
						from dic_sick_rate dsr 
						where dsr.min_value = 0 and dsr.max_value = 5)),2)
				when 
					extract(year from get_seniority(e.person_num)) > 5 
						and extract(year from get_seniority(e.person_num)) <= 8
				then trunc(get_sick_days(e.person_num, in_month, in_year) * 
						(get_avg_earning(e.person_num, in_year) * 
						(select dsr.rate 
						from dic_sick_rate dsr 
						where dsr.min_value = 5 and dsr.max_value = 8)),2)
				when 
					extract(year from get_seniority(e.person_num)) > 8 
				then 
					case 
					when
						trunc(get_sick_days(e.person_num, in_month, in_year) * 
						(get_avg_earning(e.person_num, in_year) * 
						(select dsr.rate from dic_sick_rate dsr where dsr.min_value >=8)),2) > 
						get_sick_days(e.person_num, in_month, in_year) *	
						(select dpp.value 
							from dic_pay_params dpp 
							where dpp.param_name like 'max_payment_100_per_day')
					then 
						get_sick_days(e.person_num, in_month, in_year) * 
						(select dpp.value 
							from dic_pay_params dpp 
							where dpp.param_name like 'max_payment_100_per_day')
					end
				else 0
			end as sick_pay
	from employees e 
	where e.person_num = in_person_num;
	
$$ language sql;


	 




  