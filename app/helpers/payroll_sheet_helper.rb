module PayrollSheetHelper
    @@count = 0

  
  
  def get_rownum_psh
    count_emps = PayrollSheet.group(:emp_id).count


    if @@count < count_emps.count
    then
      @@count = @@count + 1
    else
      @@count = 1
    end
  end

end
