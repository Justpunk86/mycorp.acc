module PayrollSheetHelper
    @@count = 0

  def get_rownum_psh
    @@count = @@count + 1
  end

  def reset_row_num
    @@count = 0
  end

end
