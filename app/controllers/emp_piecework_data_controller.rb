class EmpPieceworkDataController < ApplicationController
  before_action :set_epd, only: %i[index create]


  def index
    @new_epd = EmpPieceworkData.new()
  end

  def create
    emp_id = Employee.
           where(person_num: params[:emp_piecework_data][:person_num]).
           select("emp_id").first

    yc = params[:emp_piecework_data]["contract_date(1i)"]
    mc = params[:emp_piecework_data]["contract_date(2i)"]
    dc = params[:emp_piecework_data]["contract_date(3i)"]

    ye = params[:emp_piecework_data]["expiration_date(1i)"]
    me = params[:emp_piecework_data]["expiration_date(2i)"]
    de = params[:emp_piecework_data]["expiration_date(3i)"]

    yp = params[:emp_piecework_data]["payment_date(1i)"]
    mp = params[:emp_piecework_data]["payment_date(2i)"]
    dp = params[:emp_piecework_data]["payment_date(3i)"]

    contract_date = Date.new(yc.to_i,mc.to_i,dc.to_i)
    payment_date = Date.new(ye.to_i,me.to_i,de.to_i) 
    expiration_date = Date.new(yp.to_i,mp.to_i,dp.to_i)

    @new_epd = EmpPieceworkData.new()
    @new_epd.emp_id = emp_id.id
    @new_epd.contract_number = params[:emp_piecework_data][:contract_number]
    @new_epd.contract_date = contract_date
    @new_epd.expiration_date = expiration_date
    @new_epd.contract_amount = params[:emp_piecework_data][:contract_amount]
    @new_epd.payment_date = payment_date

    if @new_epd.valid?
      @new_epd.save
      redirect_to emp_piecework_data_path
    else
      render action: 'index'
    end
  end

  def destroy
    epd = EmpPieceworkData.where(
      "emp_id = ? and contract_number = ?",
      params[:emp_id],
      params[:contract_number]
      ).first
    epd.delete

    redirect_to emp_piecework_data_path
  end

  private
  def set_epd
    @epd = EmpPieceworkData.
    joins("inner join employees on
            emp_piecework_data.emp_id = employees.emp_id"
        ).
            select("employees.emp_id",
                  "person_num",
                  "contract_date",
                  "expiration_date",
                  "payment_date",
                  "contract_number",
                  "contract_amount")
  end
end
