/*select '1 year 10 month'::interval;
select 8600000001::bigint;
alter table employees alter column tin set data type bigint;
alter table employees alter column leaving_date drop not null;
alter table emp_salary_data alter column salary set data type Numeric(7,2);
alter table emp_sick_data add constraint c_stop_sick_start_sick 
check ( date_stop_sick > date_start_sick);
alter table emp_piecework_data add constraint c_contract_date 
check ( expiration_date > contract_date);

select * from employees e;
select * from dic_job_title djt ;
select * from emp_jobs_data ejd;
select * from emp_salary_data esd;*/

insert into dic_job_title(
job_title
)
values ('Начальник отдела'),
('Программист'),
('Системный администратор');

insert into employees(
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
values ('Иванов', 'Иван', 'Иванович', 123456, 8600000001, 0001, 000001,
		'1 year 10 month', '01.01.2024', null, '01.01.2024'),
		('Сидоров', 'Сидор', 'Исидорович', 000002, 8600000002, 0002, 000002,
		'1 year 5 month', '02.01.2024', null, '02.01.2024'),
		('Иванов', 'Иван', 'Иванович', 000003, 8600000003, 0003, 000003,
		'1 year 3 month', '03.01.2024', null, '03.01.2024');

insert into emp_jobs_data(
emp_id,
job_start_date,
job_title_id
)
values (2,(select d.onboarding_date from employees d where d.emp_id = 2),1),
(7,(select d.onboarding_date from employees d where d.emp_id = 7),2),
(8,(select d.onboarding_date from employees d where d.emp_id = 8),3);

insert into emp_salary_data(
emp_id,
salary_start_date,
salary
)
values (2,(select d.onboarding_date from employees d where d.emp_id = 2),25000),
(7,(select d.onboarding_date from employees d where d.emp_id = 7),35000),
(8,(select d.onboarding_date from employees d where d.emp_id = 8),45000);

insert into emp_sick_data(
emp_id,
date_start_sick,
date_stop_sick
)
values (2,'01.01.2024','03.01.2024');

insert into emp_piecework_data(
emp_id,
contract_number,
contract_date,
expiration_date,
contract_amount,
payment_date
)
values (8,00001,'01.01.2024','05.01.2024',10000,'05.01.2024');
