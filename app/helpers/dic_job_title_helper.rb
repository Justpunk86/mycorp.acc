module DicJobTitleHelper

  def title_check_fk
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
end
