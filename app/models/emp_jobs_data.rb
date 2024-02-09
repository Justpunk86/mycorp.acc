class EmpJobsData < ApplicationRecord
  #self.table_name = 'emp_jobs_data'
  self.primary_key = 'emp_id' && 'job_title_id'
  
  # belongs_to :employees
  # belongs_to :dic_job_title
end