class DicPayParamsController < ApplicationController
  def index
    @dic_pay_params = DicPayParams.all
  end
end
