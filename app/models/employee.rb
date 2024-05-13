class Employee < ApplicationRecord
# has_many :emp_jobs_data
  # has_many :emp_salary_data

  validates :last_name, 
              presence: [true, message: "*атрибут должен быть заполнен"]
  
  validates :last_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*фамилия может содержать только буквы"}

  validates :first_name, 
              presence: [true, message: "*атрибут должен быть заполнен"]

  validates :first_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*имя может содержать только буквы"}

  validates :father_name, 
              presence: [true, message: "*атрибут должен быть заполнен"]
  
  validates :father_name, 
              format: {with: /\A[A-ZА-ЯЁ][a-zа-яё]+\z/, 
                message: "*отчество может содержать только буквы"}

  validates :snils, 
              presence: [true, message: "*атрибут должен быть заполнен"]

  validates :snils, 
              format: {with: /\A[0-9]+\z/, 
                message: "*СНИЛС может содержать только цифры"}  
  validates :snils, 
              length: {is: 11, too_long: "*кол-во цифр должно быть равно 11"}
  validates :snils, 
              uniqueness: true                      

  validates :tin, 
              presence: [true,message: "*атрибут должен быть заполнен"]

  validates :tin,               
              format: {with: /\A[0-9]+\z/, 
                message: "*ИНН может содержать только цифры"}

  validates :tin,  
              length: {is: 10, too_long: "*кол-во цифр должно быть равно 10"}                 
  validates :tin,                  
              uniqueness: true

  validates :passport_sn, 
              presence: [true, message: "*атрибут должен быть заполнен"]

  validates :passport_sn, 
              format: {with: /\A[0-9]+\z/, 
                message: "*серия паспорта может содержать только цифры"}  

  validates :passport_sn,       
              length: {is: 4, too_long: "*кол-во цифр должно быть равно 4"}   

  validates :passport_sn,
              uniqueness: {
                scope: :passport_num,
                message: "*уже существует указанная серия и номер"
              }         


  validates :passport_num, 
              presence: [true, message: "*атрибут должен быть заполнен"]

  validates :passport_num,
              format: {with: /\A[0-9]+\z/, 
                message: "*номер паспорта может содержать только цифры"}  
  
  validates :passport_num,
              length: {is: 6, too_long: "*кол-во цифр должно быть равно 6"}  
  
  # validates :passport_num,
  #             uniqueness: {
  #               scope: :passport_sn,
  #               message: "*уже существует указанная серия и номер"
  #             }


  validates :onboarding_date, 
              presence: [true, message: "*атрибут должен быть заполнен"]
  

  validates :insurance_start_date, 
              presence: [true, message: "*атрибут должен быть заполнен"]
  

  
end
