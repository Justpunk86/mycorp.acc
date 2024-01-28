drop function get_payroll_employee;

create function get_payroll_employee(in_person_num text, 
									in_month_start integer, in_year_start integer, 
									in_month_end integer, in_year_end integer)
returns table(year_rep text, month_rep text, sum_payment numeric, 
				tax numeric, sick_payment numeric, total_payment numeric)
as $$
declare
	first_month_year	integer;
	last_month_year		integer;

	v_year_rep 				text;
	v_month_rep 			text;
	v_sum_payment			numeric; 
	v_sum_tax 				numeric; 
	v_sum_sick_payments 	numeric; 
	v_sum_total_payments 	numeric;

	v_year_year_rep 			text;
	v_year_month_rep 			text;
	v_year_sum_payment			numeric = 0;
	v_year_sum_tax 				numeric = 0; 
	v_year_sum_sick_payments 	numeric = 0; 
	v_year_sum_total_payments 	numeric = 0;

	v_total_year_rep 			text;
	v_total_month_rep 			text;
	v_total_sum_payment			numeric = 0;
	v_total_sum_tax 			numeric = 0; 
	v_total_sum_sick_payments 	numeric = 0; 
	v_total_sum_total_payments 	numeric = 0;
begin
	for y in in_year_start..in_year_end
	loop
		if y < in_year_end
		then
			first_month_year = in_month_start;
			last_month_year = 12;
		else
			first_month_year = 1;
			last_month_year = in_month_end;
		end if;
	
		for m in first_month_year..last_month_year
		loop

			select 
				to_char(to_date(y::text,'YYYY'),'YYYY') as year_rep, 
				to_char(to_date(m::text,'MM'),'MM') as month_rep,
				trunc(get_salary(in_person_num , m, y) / get_days_month(m, y),2) * 
					get_worked_days(in_person_num ,m,y)  + 
					get_piece_job(in_person_num, m, y) +  
					get_bonus(in_person_num, m, y) as sum_payment,
				get_tax(in_person_num, m, y) tax,
				get_sick_payment(in_person_num, m, y) sick_payment,
				sum(
				(trunc(get_salary(in_person_num , m, y) / get_days_month(m, y),2) * 
						get_worked_days(in_person_num ,m,y)) + 
					get_piece_job(in_person_num, m, y) +  
					get_bonus(in_person_num, m, y) +
				 	get_sick_payment(in_person_num, m, y) -
				 	get_tax(in_person_num, m, y)) over (partition by in_person_num) as total_payment
				 into 
				 	v_year_rep,
					v_month_rep,
					v_sum_payment,
					v_sum_tax, 
					v_sum_sick_payments, 
					v_sum_total_payments;
			
			v_year_year_rep = v_year_rep;
			v_year_month_rep = v_month_rep;
			v_year_sum_payment = v_year_sum_payment + v_sum_payment;
			v_year_sum_tax = v_year_sum_tax + v_sum_tax;
			v_year_sum_sick_payments = v_year_sum_sick_payments + v_sum_sick_payments;
			v_year_sum_total_payments = v_year_sum_total_payments + v_sum_total_payments;
				
			
			return query
				select
					v_year_rep,
					v_month_rep,
					v_sum_payment,
					v_sum_tax, 
					v_sum_sick_payments, 
					v_sum_total_payments;
			
		end loop;
	
		v_total_sum_payment	= v_total_sum_payment + v_year_sum_payment;
		v_total_sum_tax =  v_total_sum_tax + v_year_sum_tax;
		v_total_sum_sick_payments =  v_total_sum_sick_payments + v_year_sum_sick_payments;
		v_total_sum_total_payments = v_total_sum_total_payments + v_year_sum_total_payments;
		
		return query
		select
			v_year_year_rep,
			'итого за год',
			v_year_sum_payment,
			v_year_sum_tax,
			v_year_sum_sick_payments,
			v_year_sum_total_payments;
	end loop;
	return query
	select
		'',
		'итого',
		v_total_sum_payment,
		v_total_sum_tax,
		v_total_sum_sick_payments,
		v_total_sum_total_payments;
end;
$$ language plpgsql;


select * from get_payroll_employee('mc-14',1,2023,1,2024);

	