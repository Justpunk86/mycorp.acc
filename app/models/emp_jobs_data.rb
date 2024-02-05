class EmpJobsData < ApplicationRecord
  #self.table_name = 'emp_jobs_data'
  belongs_to :employees
end