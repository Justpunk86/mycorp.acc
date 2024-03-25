class EmployeesController < ApplicationController

  before_action :set_emp, only: [:update, :show, :destroy, :edit]
  
  def index
    @emps = Employee.all
    
  end

  def new
    @new_emp = Employee.new
  end

  def create
    @new_emp = Employee.new(emp_params)

  
    if @new_emp.valid?
      @new_emp.save
      redirect_to "#{emps_path}/new"
    else
       render action: 'new'
    end
    
  end

  def show
    #@emp = Employee.find(params[:id])

  end

  def edit
    #@emp = Employee.find(params[:id])
  end

  def update
    #emp = Employee.find(params[:id])

    if @emp.update emp_params
      redirect_to "#{emps_path}/#{@emp.emp_id}/edit"
    else
      render action: 'edit'
    end
    
  end

  def destroy
    #emp = Employee.find(params[:id])
    @emp.delete

    redirect_to emps_path
  end


  private

  def set_emp
    @emp = Employee.find(params[:id])
  end

  def emp_params
    params.
    require(:employee).
    permit(
      :last_name,
      :first_name,
      :father_name,
      :snils,
      :tin,
      :passport_sn,
      :passport_num,
      :onboarding_date,
      :leaving_date,
      :insurance_start_date)
  end
end
