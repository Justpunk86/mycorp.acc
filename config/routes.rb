Rails.application.routes.draw do
  get '/' => 'home#index'
  
  get '/emps' => 'employees#index'
  get '/emps/new' => 'employees#new'
  post '/emps' => 'employees#create'
  get '/emps/:id' => 'employees#show'
  delete '/emps/:id' => 'employees#destroy'
  get '/emps/:id/edit' => 'employees#edit'
  put '/emps/:id' => 'employees#update'

  

  get '/payroll_sheet' => 'payroll_sheet#index'
  get '/payroll_employee' => 'payroll_employee#index'
  get '/total_sheet' => 'total_sheet#index'

  get '/dic_job_title' => 'dic_job_title#index'
  get '/dic_pay_params' => 'dic_pay_params#index'
  get '/dic_sick_rate' => 'dic_sick_rate#index'

  get '/emp_jobs' => 'emp_jobs_data#index'
  get '/emp_salary_data' => 'emp_salary_data#index'
  get '/emp_sick_data' => 'emp_sick_data#index'
  get '/emp_piecework_data' => 'emp_piecework_data#index'
  get '/emp_bonus_data' => 'emp_bonus_data#index'
  get '/emp_jobs_before' => 'emp_jobs_before#index'


  #resources :employees

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

