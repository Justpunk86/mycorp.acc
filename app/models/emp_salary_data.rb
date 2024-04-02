class EmpSalaryData < ApplicationRecord
  #self.table_name = 'emp_jobs_data'
  self.primary_key = 'emp_id' && 'salary_start_date'
  #belongs_to :employees

  validates :emp_id, uniqueness: {scope: :salary_start_date, message: "*такая запись оклада уже существует"}

  validates :salary, presence: {message:"*значение зарплаты должно быть заполнено"}
end