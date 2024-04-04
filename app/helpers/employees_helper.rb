module EmployeesHelper
  @@count = 0


  
  def get_rownum_emp
    count_emps = Employee.group(:emp_id).count
    if @@count < count_emps.count
    then
      @@count = @@count + 1
    else
      @@count = 1
    end
  end

  def emp_check_fk
    @references = []
    @emps.each do |e|
      esckd = EmpSickData.find_by emp_id: e.id
      esd = EmpSalaryData.find_by emp_id: e.id
      epd = EmpPieceworkData.find_by emp_id: e.id
      ejd = EmpJobsData.find_by emp_id: e.id

      ejb = EmpJobsBefore.find_by emp_id: e.id
      ebd = EmpBonusData.find_by emp_id: e.id

      @references.push esckd if esckd
      @references.push esd if esd
      @references.push epd if epd
      @references.push ejd if ejd
      @references.push ejb if ejb
      @references.push ebd if ebd

      # if esckd || esd || epd || ejd || ejb
      #   @references.push ejd
      # end
      
      if @references.count > 0
        e.errors.add :emp_id, "*есть связанные записи"
        # return true
      end 
      @references = []
    end
    # false
  end



end
