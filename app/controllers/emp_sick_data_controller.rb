class EmpSickDataController < ApplicationController
  def index
    @esickdata = EmpSickData.all
  end
end
