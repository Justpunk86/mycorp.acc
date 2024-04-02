module ApplicationHelper

  def get_date params_data
    y = params_data[:year]
    m = params_data[:month]
    d = params_data[:day]

    result_date = Date.new(y.to_i,m.to_i,d.to_i)
    
  end
  
end
