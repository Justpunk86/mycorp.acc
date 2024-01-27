create function get_total_sheet()
returns table(year_rep text, month_rep text, count_emps text,
			  sum_salary numeric, sum_piece_payments numeric, sum_bonus numeric,
			  sum_tax numeric, sum_sick_payments numeric, sum_total_payments numeric
)
as $$
declare
	first_year			integer = 2022;
	last_year			integer = extract(year from current_date);
	first_month_year	integer;
	last_month_year		integer;

	v_year_rep 				text;
	v_month_rep 			text;
	v_count_emps 			bigint;
	v_sum_salary 			numeric; 
	v_sum_piece_payments 	numeric; 
	v_sum_bonus 			numeric;
	v_sum_tax 				numeric; 
	v_sum_sick_payments 	numeric; 
	v_sum_total_payments 	numeric;

	v_year_year_rep 			text;
	v_year_month_rep 			text;
	v_year_count_emps 			bigint = 0;
	v_year_sum_salary 			numeric = 0; 
	v_year_sum_piece_payments 	numeric = 0; 
	v_year_sum_bonus 			numeric = 0;
	v_year_sum_tax				numeric = 0; 
	v_year_sum_sick_payments 	numeric = 0; 
	v_year_sum_total_payments 	numeric = 0;

	v_total_year_rep 			text;
	v_total_month_rep 			text;
	v_total_count_emps 			bigint = 0;
	v_total_sum_salary 			numeric = 0; 
	v_total_sum_piece_payments 	numeric = 0; 
	v_total_sum_bonus 			numeric = 0;
	v_total_sum_tax 			numeric = 0; 
	v_total_sum_sick_payments 	numeric = 0; 
	v_total_sum_total_payments 	numeric = 0;

begin
  for y in first_year..last_year
	loop
		if y < last_year
		then
			first_month_year = 1;
			last_month_year = 12;
		else
			first_month_year = 1;
			last_month_year = extract(month from current_date);
		end if;
	
		for m in first_month_year..last_month_year
		loop
			with original_data as (
			  select 
			  		to_char(to_date(y::text,'YYYY'),'YYYY') as in_year, 
					to_char(to_date(m::text,'MM'),'MM') as in_month,
					case when get_worked_days(e.person_num ,m,y) > 0 then 1 else 0 end as c_person_num,
					trunc(get_salary(e.person_num , m, y) / get_days_month(m, y),2) * 
						get_worked_days(e.person_num ,m,y)  as sum_payment, 
					get_piece_job(e.person_num, m, y) piece_job,  
					get_bonus(e.person_num, m, y) bonus,
					get_tax(e.person_num, m, y) tax,
					get_sick_payment(e.person_num, m, y) sick_payment,
					trunc(get_salary(e.person_num , m, y) / get_days_month(m, y),2) * 
						get_worked_days(e.person_num ,m,y)  + 
					get_piece_job(e.person_num, m, y) + 
					get_bonus(e.person_num, m, y) +
					get_sick_payment(e.person_num, m, y) -
					get_tax(e.person_num, m, y) as total_payments
				
			from employees e
			)
			select od.in_year as year_rep,
				   od.in_month as month_rep,
				   sum(od.c_person_num) as count_emps,
				   sum(od.sum_payment) as sum_salary,
				   sum(od.piece_job) as sum_piece_payments,
				   sum(od.bonus) as sum_bonus,
				   sum(od.tax) as sum_tax, 
				   sum(od.sick_payment) as sum_sick_payments, 
				   sum(od.total_payments) as sum_total_payments
			from original_data od
			into v_year_rep,
				v_month_rep,
				v_count_emps,
				v_sum_salary, 
				v_sum_piece_payments, 
				v_sum_bonus,
				v_sum_tax,
				v_sum_sick_payments,
				v_sum_total_payments
			group by year_rep, month_rep;
			
			v_year_year_rep = v_year_rep;
			v_year_month_rep = v_month_rep;
			v_year_count_emps = v_count_emps;
			v_year_sum_salary = v_year_sum_salary + v_sum_salary; 
			v_year_sum_piece_payments = v_year_sum_piece_payments + v_sum_piece_payments; 
			v_year_sum_bonus = v_year_sum_bonus + v_sum_bonus;
			v_year_sum_tax = v_year_sum_tax + v_sum_tax; 
			v_year_sum_sick_payments = v_year_sum_sick_payments + v_sum_sick_payments; 
			v_year_sum_total_payments = v_year_sum_total_payments + v_sum_total_payments;
			
			return query
				select
				v_year_rep,
				v_month_rep,
				v_count_emps::text,
				v_sum_salary, 
				v_sum_piece_payments, 
				v_sum_bonus,
				v_sum_tax,
				v_sum_sick_payments,
				v_sum_total_payments;

		end loop;
		--raise notice '%', v_sum_total_payments;
		return query
		select
			v_year_year_rep,
				'итого за год',
				'',
				v_year_sum_salary, 
				v_year_sum_piece_payments, 
				v_year_sum_bonus,
				v_year_sum_tax,
				v_year_sum_sick_payments,
				v_year_sum_total_payments;
			
			v_total_year_rep = v_year_rep;
			v_total_month_rep = v_month_rep;
--			v_total_count_emps = v_count_emps;
			v_total_sum_salary = v_total_sum_salary + v_year_sum_salary; 
			v_total_sum_piece_payments = v_total_sum_piece_payments + v_year_sum_piece_payments; 
			v_total_sum_bonus = v_total_sum_bonus + v_year_sum_bonus;
			v_total_sum_tax = v_total_sum_tax + v_year_sum_tax; 
			v_total_sum_sick_payments = v_total_sum_sick_payments + v_year_sum_sick_payments; 
			v_total_sum_total_payments = v_total_sum_total_payments + v_year_sum_total_payments;
			
			v_year_year_rep = '';
			v_year_month_rep = '';
--			v_year_count_emps = 0;
			v_year_sum_salary = 0; 
			v_year_sum_piece_payments = 0; 
			v_year_sum_bonus = 0;
			v_year_sum_tax = 0; 
			v_year_sum_sick_payments = 0; 
			v_year_sum_total_payments = 0;
		
	end loop;
	return query
		select
			'',
			'итого',
			'',
			v_total_sum_salary, 
			v_total_sum_piece_payments, 
			v_total_sum_bonus,
			v_total_sum_tax,
			v_total_sum_sick_payments,
			v_total_sum_total_payments;
end;

$$ language plpgsql;