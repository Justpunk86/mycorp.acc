class DicJobTitleController < ApplicationController
  
  def index
    @dic_job_title = DicJobTitle.all
  end
end
