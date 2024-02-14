class Employee < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :father_name, presence: true
  validates :snils, presence: true
  validates :tin, presence: true
  validates :passport_sn, presence: true
  validates :passport_num, presence: true
  validates :onboarding_date, presence: true
  validates :insurance_start_date, presence: true
  # has_many :emp_jobs_data
  # has_many :emp_salary_data
end
