class EmpSalaryData < ApplicationRecord
  #self.table_name = 'emp_jobs_data'
  self.primary_key = 'emp_id' && 'salary_start_date'
  #belongs_to :employees
end