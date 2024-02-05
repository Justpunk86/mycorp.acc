class EmpJobsBeforeController < ApplicationController
  def index
    @ejb = EmpJobsBefore.all
  end
end
