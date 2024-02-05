class DicSickRateController < ApplicationController
  def index
    @dic_sick_rate = DicSickRate.all
  end
end
