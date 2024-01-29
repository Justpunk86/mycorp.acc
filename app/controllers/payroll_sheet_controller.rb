class PayrollSheetController < ApplicationController

  def index
    @year = 2023
    @month = 12
    
    @payroll_sheet = PayrollSheet.
    find_by_sql(["select * from get_payroll_sheet(?,?)",@month,@year])

    
  end
end
