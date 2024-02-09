class EmpJobsDataController < ApplicationController
  def index
    
    @ejd = EmpJobsData.
    joins("inner join employees on
            emp_jobs_data.emp_id = employees.emp_id
           inner join dic_job_title on
            emp_jobs_data.job_title_id = dic_job_title.job_title_id
            "
        ).
            select("employees.emp_id",
                  "person_num",
                  "job_start_date",
                  "job_title",
                  "emp_jobs_data.job_title_id")

  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_jobs_data][:person_num]).
           select("emp_id").first

    y = params[:emp_jobs_data]["job_start_date(1i)"]
    m = params[:emp_jobs_data]["job_start_date(2i)"]
    d = params[:emp_jobs_data]["job_start_date(3i)"]

    job_start_date = Date.new(y.to_i,m.to_i,d.to_i)

    jti = DicJobTitle.
          where(job_title: params[:emp_jobs_data]["job_title"]).
          select("job_title_id").first


    ejd = EmpJobsData.new()
    ejd.emp_id = emp_id.id
    ejd.job_start_date = job_start_date
    ejd.job_title_id = jti.id
    ejd.save

    redirect_to emp_jobs_data_path
  end

  def destroy
    ejd = EmpJobsData.where(
      "emp_id = ? and job_title_id = ?",
      params[:emp_id],
      params[:job_title_id]
      ).first
    ejd.delete

    redirect_to emp_jobs_data_path
  end

  private
  def ejd_params

    params.require(:emp_jobs_data).
    permit(:emp_id,
      :job_title_id)
  end

  
end
