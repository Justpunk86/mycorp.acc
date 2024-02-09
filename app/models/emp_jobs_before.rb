class EmpJobsBefore < ApplicationRecord
  self.table_name = 'emp_jobs_before'
  self.primary_key = 'emp_id' && 'start_date' && 'end_date'
end