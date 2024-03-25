class Employee < ApplicationRecord
# has_many :emp_jobs_data
  # has_many :emp_salary_data

  validates :last_name, 
              presence: {message: "*атрибут должен быть заполнен"}
  validates :last_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*фамилия может содержать только буквы"}

  validates :first_name, 
              presence: {message: "*атрибут должен быть заполнен"}

  validates :first_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*имя может содержать только буквы"}

  validates :father_name, 
              presence: {message: "*атрибут должен быть заполнен"}
  
  validates :father_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*отчество может содержать только буквы"}

  validates :snils, 
              presence: {message: "*атрибут должен быть заполнен"}
  validates :snils, 
              format: {with: /\A[0-9]+\z/, 
                message: "*отчество может содержать только буквы"}  
  validates :snils, 
              length: {minimum: 11, 
                        minimum: 11, 
                      message: "*кол-во цифр должно быть равно 11"}
  validates :snils, 
              uniqueness: true                      

  validates :tin, 
              presence: {message: "*атрибут должен быть заполнен"}
  validates :tin,               
              format: {with: /\A[0-9]+\z/, 
                message: "*отчество может содержать только буквы"}
  validates :tin,  
              length: {minimum: 10, 
                      maximum: 10, 
                      message: "*кол-во цифр должно быть равно 10"}                 
  validates :tin,                  
              uniqueness: true

  validates :passport_sn, 
              presence: {message: "*атрибут должен быть заполнен"}
  validates :passport_sn, 
              format: {with: /\A[0-9]+\z/, 
                message: "*отчество может содержать только буквы"}  
  validates :passport_sn,       
              length: {minimum: 4, 
                       maximum: 4, 
                      message: "*кол-во цифр должно быть равно 4"}            


  validates :passport_num, 
              presence: {message: "*атрибут должен быть заполнен"}
  validates :passport_num,
              format: {with: /\A[0-9]+\z/, 
                message: "*отчество может содержать только буквы"}  
  validates :passport_num,
              length: {minimum: 6, 
                      maximum: 6,
                      message: "*кол-во цифр должно быть равно 6"}  
  validates :passport_num,
              uniqueness: {
                scope: :passport_sn,
                message: "*уже существует указанная серия и номер"
              }                      


  validates :onboarding_date, 
              presence: {message: "*атрибут должен быть заполнен"}
  

  validates :insurance_start_date, 
              presence: {message: "*атрибут должен быть заполнен"}
  

  
end
