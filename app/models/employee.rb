class Employee < ApplicationRecord
  has_many :emp_jobs_data
  has_many :emp_salary_data
end
