class PayrollEmployeeController < ApplicationController

  def index
    @in_person_num = nil
    @in_month_start = nil
    @in_year_start = nil
    @in_month_end = nil
    @in_year_end = nil
    
    @payroll_emp = nil

    
    
    if params[:person_num].to_s != '' && 
      params[:month_start].to_s != '' && 
      params[:year_start].to_s != '' && 
      params[:month_end].to_s != '' && 
      params[:year_end].to_s != ''
    then
      @in_person_num = params[:person_num]
      @in_month_start = params[:month_start]
      @in_year_start = params[:year_start]
      @in_month_end = params[:month_end]
      @in_year_end = params[:year_end]
      @payroll_emp = PayrollEmployee.
        find_by_sql(
        ["select * from get_payroll_employee(
          ?,?,?,?,?)",
        @in_person_num,@in_month_start,
        @in_year_start,@in_month_end,
        @in_year_end])
      
    end
  end

end
