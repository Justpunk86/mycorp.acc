class DicJobTitleController < ApplicationController

before_action :set_jt, only: [:index, :create, :destroy]

  def index

    @new_job_title = DicJobTitle.new

    @emp_jobs_data = []
    @dic_job_title.each do |jt|
      ejd = EmpJobsData.find_by job_title_id: jt.id
      if ejd
        @emp_jobs_data.push ejd
      end
      
      if @emp_jobs_data.count > 0
        jt.errors.add :job_title_id, "*есть связанные записи"
      end 
      @emp_jobs_data = []
    end

  end

  def create

    @new_job_title = DicJobTitle.new(job_title_pars)

    if @new_job_title.valid?
      @new_job_title.save
      redirect_to dic_job_title_path
    else
      render action: 'index'

    end
  end

  def destroy
    job_title = DicJobTitle.find(params[:id])
    emp_jobs_data = EmpJobsData.find_by job_title_id: job_title.id

    if emp_jobs_data
      redirect_to dic_job_title_path
    else
      job_title.delete
      redirect_to dic_job_title_path
    end

    
  end

  private

  def job_title_pars
    params.require(:dic_job_title).
    permit(:job_title)
  end

  def set_jt
    @dic_job_title = DicJobTitle.all

  end

end
