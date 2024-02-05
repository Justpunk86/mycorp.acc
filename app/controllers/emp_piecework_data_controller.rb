class EmpPieceworkDataController < ApplicationController
  def index
    @epd = EmpPieceworkData.all
  end
end
