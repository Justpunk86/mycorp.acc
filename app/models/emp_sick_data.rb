class EmpSickData < ApplicationRecord
  self.primary_key = 'emp_id' && 'date_start_sick'

  validates :date_start_sick, 
    comparison: { less_than: :date_stop_sick,
      message: "дата начала должна быть меньше даты окончания"
     }

  validates :emp_id, uniqueness: {
    scope: :date_start_sick,
    scope: :date_stop_sick,
    message: "такая запись уже существует"
  }
  
  validates :emp_id, uniqueness: {
    scope: :date_start_sick,
    message: "уже существует запись с указанной датой начала"
  }
end