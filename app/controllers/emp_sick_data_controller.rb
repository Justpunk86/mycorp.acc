class EmpSickDataController < ApplicationController
  def index
    @esickdata = EmpSickData.
    joins("inner join employees on
            emp_sick_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "date_start_sick",
                  "date_stop_sick")
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

    esd = EmpSickData.new()
    esd.emp_id = emp_id.id
    esd.date_start_sick = date_start_sick
    esd.date_stop_sick = date_stop_sick
    esd.save

    redirect_to emp_sick_data_path
  end

  def destroy
    esd = EmpSickData.where(
      "emp_id = ?",
      params[:emp_id]
      ).first
    esd.delete

    redirect_to emp_sick_data_path
  end
end
