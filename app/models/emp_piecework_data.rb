class EmpPieceworkData < ApplicationRecord

  self.primary_key = 'emp_id' && 'contract_number'

  validates :contract_number, presence: {message: "номер договора должен быть заполнен"}
  validates :contract_amount, presence: {message: "сумма договора должна быть заполнена"}

  validates :emp_id, uniqueness: {
    scope: :emp_id,
    scope: :contract_number,
    message: "работа с таким № договора уже существует"
  }

  validates :contract_date, comparison: {
    less_than: :expiration_date,
    message: "дата договора должна быть меньше даты исполнения"
  }
  
end