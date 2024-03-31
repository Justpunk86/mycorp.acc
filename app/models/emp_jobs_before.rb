class EmpJobsBefore < ApplicationRecord
  self.table_name = 'emp_jobs_before'
  self.primary_key = 'emp_id' && 'start_date' && 'end_date'

  validates :corp_name, presence: {message: "*название предприятия должно быть заполнено"}

  validates :emp_id, uniqueness: {scope: :start_date, scope: :end_date, message: "*данный стаж уже учтён"}

  validates :start_date, comparison: {less_than: :end_date, message: "*дата начала должна быть меньше даты окончания"}
end