class EmpSalaryDataController < ApplicationController
  before_action :set_esd, only: %i[index create]

  def index
    @new_esd = EmpSalaryData.new

    
  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_salary_data][:person_num]).
           select("emp_id").first

    # y = params[:emp_salary_data]["salary_start_date(1i)"]
    # m = params[:emp_salary_data]["salary_start_date(2i)"]
    # d = params[:emp_salary_data]["salary_start_date(3i)"]

    # salary_start_date = Date.new(y.to_i,m.to_i,d.to_i)

    @new_esd = EmpSalaryData.new(get_params)
    @new_esd.emp_id = emp_id.id
    # esd.salary_start_date = salary_start_date
    # esd.salary = params[:emp_salary_data][:salary]

    if @new_esd.valid?
      @new_esd.save
      redirect_to emp_salary_data_path
    else
      render action: "index"
    end

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

  private
  def set_esd
    @esd = EmpSalaryData. 
    joins("inner join employees on
            emp_salary_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "salary_start_date",
                  "salary")
  end


  def get_params
    params.
    require(:emp_salary_data).
    permit(
      :emp_id,
      :salary_start_date,
      :salary)
  end
end
