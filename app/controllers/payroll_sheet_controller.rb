class PayrollSheetController < ApplicationController
  @@count = 0
  def get_num
    @@count = @@count + 1
  end

  def index


    @year = nil
    @month = nil
    @payroll_sheet = nil
    
    if params[:year].to_s != '' && 
      params[:month].to_s != ''
    then
      @year = params[:year]
      @month = params[:month]
      @payroll_sheet = PayrollSheet.
        find_by_sql(
        ["select * from get_payroll_sheet(?,?)",
        @month,@year])
      
    end
  end


end
