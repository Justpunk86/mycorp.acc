class EmpJobsBeforeController < ApplicationController
  before_action :set_ejb, only: %i[index create]

  def index
    @new_ejb = EmpJobsBefore.new()

  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_jobs_before][:person_num]).
           select("emp_id").first

    # ys = params[:emp_jobs_before]["start_date(1i)"]
    # ms = params[:emp_jobs_before]["start_date(2i)"]
    # ds = params[:emp_jobs_before]["start_date(3i)"]

    # start_date = Date.new(ys.to_i,ms.to_i,ds.to_i)

    # ye = params[:emp_jobs_before]["end_date(1i)"]
    # me = params[:emp_jobs_before]["end_date(2i)"]
    # de = params[:emp_jobs_before]["end_date(3i)"]

    # end_date = Date.new(ye.to_i,me.to_i,de.to_i)

    @new_ejb = EmpJobsBefore.new(ejb_params)
    @new_ejb.emp_id = emp_id.id
    # @new_ejb.start_date = start_date
    # @new_ejb.end_date = end_date
    # @new_ejb.corp_name = params[:emp_jobs_before][:corp_name]

    if @new_ejb.valid?
      @new_ejb.save
      redirect_to emp_jobs_before_path
    else
      render action: 'index'
    end
    
  end

  def destroy
    ejb = EmpJobsBefore.where(
      "emp_id = ? and start_date = ? and end_date = ?",
      params[:emp_id],
      params[:start_date],
      params[:end_date]
      ).first
    ejb.delete

    redirect_to emp_jobs_before_path
  end

  private
  def set_ejb
    @ejb = EmpJobsBefore.
    joins("inner join employees on
            emp_jobs_before.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "start_date",
                  "end_date",
                  "corp_name")
  end

  def ejb_params

    params.require(:emp_jobs_before).
    permit(:emp_id,
      :start_date,
      :end_date,
      :corp_name)
  end
end
