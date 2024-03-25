class JobTitleValidator < ActiveModel::Validator
  def validate(record)
    @dic_job_title = DicJobTitle.find(record.id)
    @emp_jobs_data = @dic_job_title.emp_jobs_data
  
    if @emp_jobs_data.count > 0
      record.errors.add :base, "*есть связанные записи"
    end
  end
end


class DicJobTitle < ApplicationRecord
  self.table_name = "dic_job_title"
  # has_many :emp_jobs_data

 # validates_associated :emp_jobs_data
  # validates_with JobTitleValidator, on: :index

  validates :job_title,
    presence: {message: "*атрибут должен быть заполнен"}
  validates :job_title, 
    format: {with: /\A([A-ZА-ЯЁ][a-zа-яё])(\S)+/, 
            message: "*должность может содержать только буквы и начинаться с заглавной буквы"}    
end