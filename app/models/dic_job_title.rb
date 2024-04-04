# class JobTitleValidator < ActiveModel::Validator
#   def validate_jt(record)
#     @dic_job_title = DicJobTitle.find(record.job_title_id)
#     @emp_jobs_data = EmpJobsData.find(@dic_job_title.job_title_id)
  
#     if @emp_jobs_data.count > 0
#       record.errors.add :job_title_id, "*есть связанные записи"
#     end
#   end
# end


class DicJobTitle < ApplicationRecord
  self.table_name = "dic_job_title"
  # has_many :emp_jobs_data

 # validates_associated :emp_jobs_data
  # validates_with JobTitleValidator, validate_jt: :dic_job_title, on: :index
    # validate_jt: :self {message: "*должность имеет связанные записи"}

  validates :job_title,
    presence: {message: "*атрибут должен быть заполнен"}
  validates :job_title, 
    format: {with: /\A([A-ZА-ЯЁ][a-zа-яё])(\S)+/, 
            message: "*должность может содержать только буквы и начинаться с заглавной буквы"}    
end