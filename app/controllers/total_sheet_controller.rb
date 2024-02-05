class TotalSheetController < ApplicationController
  def index
    
    @total_sheet = TotalSheet.
        find_by_sql("select * from get_total_sheet()")
    
    
  end
end
