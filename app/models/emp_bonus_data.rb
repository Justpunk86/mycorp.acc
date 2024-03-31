class EmpBonusData < ApplicationRecord
  self.primary_key = 'emp_id' && 'order_num'

   validates :order_num, presence: {message: "*№ приказа должен быть заполнен"}
   validates :amount, presence: {message: "*сумма должна быть заполнена"}

   validates :emp_id, uniqueness: {scope: :order_num, message: "*уже существует выплата по данному приказу"}
  
end