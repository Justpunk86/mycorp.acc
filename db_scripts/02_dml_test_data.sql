insert into dic_job_title(
job_title
)
values ('Начальник отдела'),
('Программист'),
('Старший программист'),
('Системный администратор');

insert into employees(
person_num,
last_name, 
first_name, 
father_name,
snils, 
tin, 
passport_sn, 
passport_num, 
insurance_qty_after,
onboarding_date, 
leaving_date, 
insurance_start_date
)
values ((select 'mc-'||last_value + 1 from employees_emp_id_seq), 'Иванов', 'Иван', 'Иванович', 123456, 8600000001, 0001, 000001,
		 to_date('01.12.2023','dd.mm.yyyy'), null, 
		to_date('01.01.2023','dd.mm.yyyy')),
		((select 'mc-'||last_value  + 1 from employees_emp_id_seq), 'Сидоров', 'Сидор', 'Исидорович', 000002, 8600000002, 0002, 000002,
		 to_date('02.12.2022','dd.mm.yyyy'), null, to_date('02.01.2023','dd.mm.yyyy')),
		((select 'mc-'||last_value + 1 from employees_emp_id_seq), 'Иванов', 'Иван', 'Иванович', 000003, 8600000003, 0003, 000003,
		 to_date('03.12.2023','dd.mm.yyyy'), null, to_date('03.01.2023','dd.mm.yyyy'));

insert into emp_jobs_data(
emp_id,
job_start_date,
job_title_id
)
values (14,(select d.onboarding_date from employees d where d.emp_id = 14),4),
(15,(select d.onboarding_date from employees d where d.emp_id = 15),5),
(16,(select d.onboarding_date from employees d where d.emp_id = 16),6);

insert into emp_salary_data(
emp_id,
salary_start_date,
salary
)
values (14,(select d.onboarding_date from employees d where d.emp_id = 14),25000),
(15,(select d.onboarding_date from employees d where d.emp_id = 15),35000),
(16,(select d.onboarding_date from employees d where d.emp_id = 16),45000);



insert into emp_sick_data(
emp_id,
date_start_sick,
date_stop_sick
)
values (14,to_date('10.12.2023','dd.mm.yyyy'),to_date('15.12.2023','dd.mm.yyyy')),
(15,to_date('15.12.2023','dd.mm.yyyy'),to_date('20.12.2023','dd.mm.yyyy'));

insert into emp_piecework_data(
emp_id,
contract_number,
contract_date,
expiration_date,
contract_amount,
payment_date
)
values (16,00001,to_date('01.12.2023','dd.mm.yyyy'),to_date('05.12.2023','dd.mm.yyyy'),10000,to_date('05.12.2023','dd.mm.yyyy'));

insert into emp_bonus_data(emp_id, payment_date, amount)
values (15, to_date('25.12.2023','dd.mm.yyyy'), 5000);

insert into dic_sick_rate(min_value, max_value, rate)
values (0, 5, 0.6),
(5, 8, 0.8),
(8, 99, 1);

insert into dic_pay_params(param_name,value)
values('mrot',4611),
('max_payment_100_per_day',1202.74),
('tax_ru',0.13);

insert into emp_jobs_before(emp_id,start_date,end_date,corp_name)
values (14,to_date('01.11.2022','dd.mm.yyyy'),to_date('31.12.2022','dd.mm.yyyy'),'Coca-cola'),
(15,'01.01.2021','01.12.2022','Ozon'),
(15,'01.01.2023','01.12.2023','X5'),
(15,'01.01.2022','01.10.2023','Ozon'),
(15,'01.10.2023','01.12.2023','X5'),
(16,'01.01.2022','01.10.2023','Ozon'),
(16,'01.10.2023','01.12.2023','X5');

/*insert into emp_time_sheet(emp_id, month, year, worked_days)
values (14, 12, 2023, get_days_month(12, 2023) - get_sick_days('mc-14', 12, 2023)),
(15, 12, 2023, get_days_month(12, 2023) - get_sick_days('mc-15', 12, 2023)),
(16, 12, 2023, get_days_month(12, 2023) - get_sick_days('mc-16', 12, 2023));*/

