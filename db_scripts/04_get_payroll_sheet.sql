drop function get_payroll_sheet;

create function get_payroll_sheet(in_month integer, in_year integer)
returns table(person_num text, bio text, job_title text, 
			base_sal numeric, worked_days integer, sal_days integer,
			piece_job numeric, bonus numeric, tax numeric, sick_days integer, sick_payments numeric, tot_payment numeric)
as $$
	with get_origin_data as
	(select e.person_num,
		e.last_name||' '||
		substring(e.first_name,1,1)||'.'||
		substring(e.father_name,1,1)||'.' as BIO,
		get_job_title(e.person_num , in_month, in_year) job_title,
		get_salary(e.person_num , in_month, in_year) base_sal,
		get_worked_days(e.person_num ,in_month,in_year) as worked_days,
		get_salary(e.person_num , in_month, in_year) * 
			get_worked_days(e.person_num ,in_month,in_year) sal_days,
		get_piece_job(e.person_num, in_month, in_year) piece_job,
		get_bonus(e.person_num, in_month, in_year) bonus,
		get_tax(e.person_num, in_month, in_year) tax,
		get_sick_days(e.person_num, in_month, in_year) sick_days,
		get_sick_payment(e.person_num, in_month, in_year) sick_payments,
		sum(
		(trunc(
				get_salary(e.person_num , in_month, in_year) / get_days_month(in_month, in_year),2) * 
				get_worked_days(e.person_num ,in_month,in_year)
			) + 
		get_piece_job(e.person_num, in_month, in_year) +  
		get_bonus(e.person_num, in_month, in_year) +
		 get_sick_payment(e.person_num, in_month, in_year) -
		 get_tax(e.person_num, in_month, in_year)) over (partition by e.person_num) as tot_payment
		
	from employees e
	join emp_jobs_data ejd
		on e.emp_id  = ejd.emp_id  
	join emp_salary_data esd
		on e.emp_id = esd.emp_id)
	select od.person_num,
			od.BIO,
			od.job_title,
			od.base_sal,
			od.worked_days,
			od.sal_days,
			od.piece_job,
			od.bonus,
			od.tax,
			od.sick_days,
			od.sick_payments,
			od.tot_payment
	from get_origin_data od
	union all 
	select
		'итого',
		null,
		null,
		null,
		null,
		sum(od.sal_days) sum_sal_days,
		sum(od.piece_job) sum_piece_job,
		sum(od.bonus) sum_bonus,
		sum(od.tax) sum_tax,
		null,
		sum(od.sick_payments) sum_sick_payments,
		sum(od.tot_payment) sum_total_paymetns
	from get_origin_data od;
--	group by od.person_num;
	
$$ language sql;

select * from get_payroll_sheet(12, 2023);

	