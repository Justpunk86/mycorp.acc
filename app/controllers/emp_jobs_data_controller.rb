class EmpJobsDataController < ApplicationController
  def index
    @ejd = EmpJobsData.
    joins("inner join employees on
            emp_jobs_data.emp_id = employees.emp_id
           inner join dic_job_title on
            emp_jobs_data.job_title_id = dic_job_title.job_title_id
            "
        ).
            select("employees.person_num",
                  "emp_jobs_data.job_start_date",
                  "dic_job_title.job_title")

    @dic_jt = DicJobTitle.select("job_title").all
  end



end
