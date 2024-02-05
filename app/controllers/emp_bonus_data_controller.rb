class EmpBonusDataController < ApplicationController
  def index
    @ebd = EmpBonusData.all
  end
end
