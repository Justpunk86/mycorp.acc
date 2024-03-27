class EmpSickDataController < ApplicationController
  
  before_action :set_esd, only: %i[index create]

  def index
    @new_esd = EmpSickData.new
    
  end

  def create
    
    emp_id = Employee.
           where(person_num: params[:emp_sick_data][:person_num]).
           select("emp_id").first

    ys = params[:emp_sick_data]["date_start_sick(1i)"]
    ms = params[:emp_sick_data]["date_start_sick(2i)"]
    ds = params[:emp_sick_data]["date_start_sick(3i)"]

    ye = params[:emp_sick_data]["date_stop_sick(1i)"]
    me = params[:emp_sick_data]["date_stop_sick(2i)"]
    de = params[:emp_sick_data]["date_stop_sick(3i)"]

    date_start_sick = Date.new(ys.to_i,ms.to_i,ds.to_i)
    date_stop_sick = Date.new(ye.to_i,me.to_i,de.to_i) 

    @new_esd = EmpSickData.new()
    @new_esd.emp_id = emp_id.id
    @new_esd.date_start_sick = date_start_sick
    @new_esd.date_stop_sick = date_stop_sick

    if @new_esd.valid?
      @new_esd.save
      redirect_to emp_sick_data_path
    else
      render action: 'index'
    end

    
  end

  def destroy
    @esd = EmpSickData.where(
      "emp_id = ? and date_start_sick = ?",
      params[:emp_id],
      params[:date_start_sick]
      ).first
    @esd.delete

    redirect_to emp_sick_data_path
  end

  private
  def set_esd
    @esickdata = EmpSickData.
    joins("inner join employees on
            emp_sick_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "date_start_sick",
                  "date_stop_sick")
  end
end
