Rails.application.routes.draw do
  get '/' => 'home#index'
  get '/payroll_sheet' => 'payroll_sheet#index'
  resources :employees

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
