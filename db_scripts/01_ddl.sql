create table employees(
	emp_id					integer generated always as identity not null,
	person_num				text unique,
	last_name				text not null,
	first_name				text not null,
	father_name 			text not null,
	snils					integer unique not null,
	tin						bigint unique not null,
	passport_sn				integer unique not null,
	passport_num 			integer unique not null,
	onboarding_date			date not null,
	leaving_date			date,
	insurance_start_date	date not null,
	primary key(emp_id),
	constraint uniq_passport_sn_passport_num unique(passport_sn, passport_num)	
);

create function gen_person_num()
returns trigger
as $$
declare

begin
	execute format(
		'update employees set person_num = $1 where emp_id = $2'
	) using 'mc-'||new.emp_id, new.emp_id;
	return new;
end;
$$ language plpgsql;

create trigger upd_person_num
after insert on employees
for each row execute function gen_person_num();


create table dic_job_title(
	job_title_id 	integer generated always as identity not null,
	job_title 		text not null unique,
	primary key(job_title_id)
);

create table emp_jobs_data (
	emp_id			integer not null,
	job_start_date	date not null,
	job_title_id	integer not null,
	primary key(emp_id,job_title_id),
	constraint uniq_emp_jobs_data unique(emp_id,job_title_id,job_start_date),
	foreign key(emp_id) references employees(emp_id),
	foreign key(job_title_id) references dic_job_title(job_title_id)
	
);

create table emp_salary_data(	
	emp_id				integer not null,
	salary_start_date	date not null,
	salary				Numeric(7,2) not null,
	primary key(emp_id,salary),
	constraint uniq_emp_salary_data unique(emp_id,salary,salary_start_date),
	foreign key(emp_id) references employees(emp_id)
);

create table emp_sick_data (
	emp_id				integer not null,
	date_start_sick		date  not null,
	date_stop_sick		date not null,
	primary key(emp_id),
	constraint uniq_emp_sick_data unique(emp_id,date_start_sick,date_stop_sick),
	check ( date_stop_sick > date_start_sick),
	foreign key(emp_id) references employees(emp_id)
);

create table emp_piecework_data (
	emp_id				integer  not null,
	contract_number		integer not null,
	contract_date		date not null,
	expiration_date		date not null,
	contract_amount		Numeric(999,2) not null,
	payment_date		date not null,
	primary key(emp_id),
	constraint uniq_emp_piecework_data unique(emp_id,contract_number),
	check ( expiration_date > contract_date),
	foreign key(emp_id) references employees(emp_id)

);

create table emp_bonus_data	(
	emp_id			integer not null,
	payment_date	date not null,
	amount			Numeric(999,2) not null,
	primary key(emp_id),
	foreign key(emp_id) references employees(emp_id)
);

create table dic_sick_rate(
id			integer generated always as identity not null,
min_value	integer	not null,
max_value	integer not null,
rate		numeric not null,
constraint uniq_dic_sick_rate unique(id)
);

create table dic_pay_params(	
id			integer generated always as identity not null,
param_name	text not null,
value		numeric not null,
constraint uniq_dic_pay_params unique(id)
);

create table emp_jobs_before(	
emp_id		integer,
start_date	date not null,
end_date	date not null,
corp_name	text not null,
constraint uniq_emp_jobs_before unique(emp_id,start_date,end_date),
check ( end_date >= start_date),
foreign key(emp_id) references employees(emp_id)
);

/*create table emp_time_sheet(	
emp_id		integer not null,
month		integer not null,
year		integer not null,
worked_days	integer not null,
foreign key(emp_id) references employees(emp_id),
check ( worked_days > 0 ),
constraint uniq_emp_time_sheet unique(emp_id, month, year)
);
*/
