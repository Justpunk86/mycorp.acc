class EmpSalaryDataController < ApplicationController
  def index
    @esd = EmpSalaryData. 
    joins("inner join employees on
            emp_salary_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "salary_start_date",
                  "salary")
  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_salary_data][:person_num]).
           select("emp_id").first

    y = params[:emp_salary_data]["salary_start_date(1i)"]
    m = params[:emp_salary_data]["salary_start_date(2i)"]
    d = params[:emp_salary_data]["salary_start_date(3i)"]

    salary_start_date = Date.new(y.to_i,m.to_i,d.to_i)

    esd = EmpSalaryData.new()
    esd.emp_id = emp_id.id
    esd.salary_start_date = salary_start_date
    esd.salary = params[:emp_salary_data][:salary]
    esd.save

    redirect_to emp_salary_data_path
  end

  def destroy
    esd = EmpSalaryData.where(
      "emp_id = ? and salary_start_date = ?",
      params[:emp_id],
      params[:salary_start_date]
      ).first
    esd.delete

    redirect_to emp_salary_data_path
  end
end
