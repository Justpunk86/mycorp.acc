Rails.application.routes.draw do

  root to: 'home#index'

  get '/' => 'home#index'
  
  get '/emps' => 'employees#index'
  get '/emps/new' => 'employees#new'
  #post '/emps/new' => 'employees#create'
  post '/emps' => 'employees#create'
  get '/emps/:id' => 'employees#show'
  delete '/emps/:id' => 'employees#destroy'
  get '/emps/:id/edit' => 'employees#edit'
  put '/emps/:id' => 'employees#update'

  

  get '/payroll_sheet' => 'payroll_sheet#index'
  get '/payroll_employee' => 'payroll_employee#index'
  get '/total_sheet' => 'total_sheet#index'

  get '/dic_job_title' => 'dic_job_title#index'
  post '/dic_job_title' => 'dic_job_title#create'
  delete '/dic_job_title/:id' => 'dic_job_title#destroy'
  
  get '/dic_pay_params' => 'dic_pay_params#index'
  get '/dic_sick_rate' => 'dic_sick_rate#index'

  get '/emp_jobs_data' => 'emp_jobs_data#index'
  post '/emp_jobs_data' => 'emp_jobs_data#create'
  delete '/emp_jobs_data/:emp_id&:job_title_id&:job_start_date' => 'emp_jobs_data#destroy'

  get '/emp_salary_data' => 'emp_salary_data#index'
  post '/emp_salary_data' => 'emp_salary_data#create'
  delete '/emp_salary_data/:emp_id&:salary_start_date' => 'emp_salary_data#destroy'

  get '/emp_sick_data' => 'emp_sick_data#index'
  post '/emp_sick_data' => 'emp_sick_data#create'
  delete '/emp_sick_data/:emp_id&:date_start_sick' => 'emp_sick_data#destroy'

  get '/emp_piecework_data' => 'emp_piecework_data#index'
  post '/emp_piecework_data' => 'emp_piecework_data#create'
  delete '/emp_piecework_data/:emp_id&:contract_number' => 'emp_piecework_data#destroy'


  get '/emp_bonus_data' => 'emp_bonus_data#index'
  post '/emp_bonus_data' => 'emp_bonus_data#create'
  delete '/emp_bonus_data/:emp_id&:order_num' => 'emp_bonus_data#destroy'

  get '/emp_jobs_before' => 'emp_jobs_before#index'
  post '/emp_jobs_before' => 'emp_jobs_before#create'
  delete '/emp_jobs_before/:emp_id&:start_date&:end_date' => 'emp_jobs_before#destroy'


  #resources :employees

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

