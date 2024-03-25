class EmpJobsData < ApplicationRecord
  self.table_name = 'emp_jobs_data'
  self.primary_key = 'emp_id' && 'job_title_id'
  
   # belongs_to :employee
   # belongs_to :dic_job_title

  validates :emp_id,
    uniqueness: {
      scope: :emp_id,
      # scope: :job_title_id,
      scope: :job_start_date,
      message: "*уже существует указанная дата и личный номер"
    }

  # validates_associated :dic_job_title
end