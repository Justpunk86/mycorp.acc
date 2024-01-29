class EmployeesController < ApplicationController
  def new
    
  end

  def create
  end

  def index
    @emps = Employee.all

  end
end
