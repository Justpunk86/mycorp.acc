class PayrollSheetController < ApplicationController

  def index
    @payroll_sheet = PayrollSheet.
    find_by_sql(["select * from get_payroll_sheet(?,?)",12,2023])
  end
end
