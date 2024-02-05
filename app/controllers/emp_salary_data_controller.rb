class EmpSalaryDataController < ApplicationController
  def index
    @esd = EmpSalaryData.all
  end
end
