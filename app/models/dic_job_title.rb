class DicJobTitle < ApplicationRecord
  self.table_name = "dic_job_title"
  has_many :emp_jobs_data
end